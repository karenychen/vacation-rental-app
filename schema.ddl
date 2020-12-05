-- Constraints that could not be enforced:
-- 1. There are no overlapping rental periods in the same property.
-- This involves a check with subquery which is not supported by psql.

-- Constraints that could have been inforced but were not enforced:
-- 1. Renter >= 18 years old at first day of rental. 
-- This is a cross-table check and needs to be performed using either an 
-- assertion or a trigger.
-- 2. The tuple (rid, gid) in each row in Rental must also be in Stay,
-- that is, the renter of a rental must be a guest of the rental.
-- This is a cross-table check and needs to be performed using either an
-- assertion or a trigger.
-- 3. Number of guests of a rental <= capacity of the property.
-- This is a cross table check and needs to be performed using either an
-- assertion or a trigger.
-- 4. Price of a rental already exists in Price.
-- This is a cross table check and needs to be performed using either an
-- assertion or a trigger.

drop schema if exists vacationschema cascade;
create schema vacationschema;
set search_path to vacationschema;

-- A person who is registered as a guest on LuxuryRentals,
-- whether or not they are the official renter.
create table Guest (
    gid integer primary key,
    name varchar not null,
    dob date not null,
    address varchar not null
) ;

-- A host for one or more properties registered on LuxuryRentals.
create table Host (
    hid integer primary key,
    email varchar(30) not null
) ;

-- A property registered on LuxuryRentals.
create table Property (
    pid integer primary key,
    hid integer not null references Host,
    num_bedroom integer not null,
    constraint bedroomInRange
        check (num_bedroom >= 0),
    num_bathroom integer not null,
    constraint bathroomInRange
        check (num_bathroom >= 0),
    capacity integer not null,
    constraint capacityInRange
        check (capacity >= num_bedroom),
    address varchar not null,
    hot_tub boolean not null,
    sauna boolean not null,
    laundry boolean not null,
    cleaning boolean not null,
    breakfast boolean not null,
    concierge boolean not null,
    constraint atLeastOneAmendity
        check (hot_tub or sauna or laundry 
        or cleaning or breakfast or concierge)
) ;

-- Possible values of a city type 
create domain citytype as varchar(6)
    not null
    constraint validCityType
        check (value in ('bus', 'LRT', 'subway', 'none'));

-- A property that is considered to be a city property.
-- Each property can only be listed once.
create table CityProperty (
    pid integer primary key references Property,
    score integer not null,
    constraint scoreInRange
        check (score >= 0 and score <= 100),
    type citytype not null
) ;

-- Possible values of a water type 
create domain watertype as varchar(5)
    not null
    constraint validWaterType
        check (value in ('beach', 'lake', 'pool'));

-- A peoperty that is considered to be a water property
-- Each property can be listed more than once if it has
-- more than one type.
create table WaterProperty (
    pid integer references Property,
    type watertype not null,
    lifeguard boolean not null,
    primary key(pid, type)
) ;

-- Credit card information.
-- Note that this table could be included in the
-- Rental relation, but I decided not to because
-- it is not secure to include it there!!!!!!!
create table Card (
    cid integer primary key,
    gid integer not null references Guest,
    number char(16) not null,
    constraint validCard
        check (number ~ '^[0-9]*$'),
    unique(cid, gid)
);

-- Possible start dates (has to be a saturday)
create domain week as date
    not null
    constraint isSaturday
        check (extract(isodow from value) = 6);

-- A rental on LuxuryRentals.
create table Rental (
    rid integer primary key,
    gid integer not null references Guest, -- renter
    pid integer not null references Property,
    cid integer not null references Card,
    start_date week not null,
    end_date week not null,
    unique(rid, gid),
    unique(pid, start_date),
    constraint validStartEnd
        check(end_date - start_date >= 7),
    foreign key (gid, cid) references Card(gid, cid)
) ;

-- The price for one week of rental of a property.
create table Price (
    pid integer references Property,
    date week not null,
    price float not null,
    primary key (pid, date)
) ;

-- Associated guests in each rental
-- There is at least one column (the renter) for each rental.
create table Stay (
    rid integer references Rental,
    gid integer references Guest,
    primary key (rid, gid)
) ;

-- Ratings

-- Possible values of a rating
create domain score as smallint
    default null
    check (value >= 0 and value <= 5);

-- The property in this rental was given this rating
-- by the renter or additional guests from the rental.
-- A property can be rated more than once after a rental.
create table PropertyRating (
    rid integer references Rental,
    gid integer not null references Guest,
    rating score not null,
    primary key (rid, gid),
    foreign key (rid, gid) references Stay(rid, gid)
) ;

-- The property in this rental was given this comment
-- by the renter or additional guest from the rental
-- who has already rated the property.
-- A property can be given more than one comment after a rental.
create table PropertyComment (
    rid integer references Rental,
    gid integer not null references Guest,
    comment varchar not null,
    primary key (rid, gid),
    foreign key (rid, gid) references PropertyRating(rid, gid)
) ;

-- The host in this rental was given this rating
-- by the renter from this rental.
-- A host can only be rated once after a rental.
create table HostRating (
    rid integer primary key references Rental,
    gid integer not null references Guest,
    rating score not null,
    foreign key (rid, gid) references Rental(rid, gid)
) ;