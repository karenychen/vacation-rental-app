set search_path to vacationschema;
drop table if exists q3 cascade;

create table q3(
        email varchar(30),
        rating float,
        price float
);

drop view if exists avg_rating cascade;
drop view if exists not_highest cascade;
drop view if exists highest cascade;
drop view if exists most_expensive cascade;

-- Intermediate steps

-- Average rating of hosts with a rating.
create view avg_rating(hid, rating) as
select hid, avg(rating)
from HostRating join Rental
on HostRating.rid = Rental.rid
join Property
on Rental.pid = Property.pid
group by Property.hid;

-- hid and rating for hosts who does not have
-- a highest rating.
create view not_highest(hid, rating) as
select a1.hid, a1.rating
from avg_rating a1 join avg_rating a2
on a1.rating < a2.rating;

-- hid and rating for the host with highest rating.
create view highest(hid, rating) as
(select * from avg_rating)
        except
(select * from not_highest);

-- hid, rating and the most expensive booking week
-- the host with highest rating has recorded.
create view most_expensive(hid, rating, price) as
select highest.hid, rating, max(price)
from highest join Property
on highest.hid = Property.hid
join Price on Property.pid = Price.pid
group by highest.hid, rating;


-- Answer for q3
insert into q3(email, rating, price)
select email, rating, price
from most_expensive join Host
on most_expensive.hid = Host.hid;
