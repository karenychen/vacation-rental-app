set search_path to vacationschema;
drop table if exists q2 cascade;

-- This table consists of 3 attributes:
-- capacity is either 'at capacity' or 'below capacity'

-- rating is average rating for these 2 types of rentals

-- number is number of rentals for theses 2 types of rentals.

-- If no guest from a rental has rated the property,
-- it is not contributed to average rating but it is
-- incuded in the total number of rentals.
create table q2(
        capacity varchar(20),
        rating float,
        number integer
);

drop view if exists guest_capacity cascade;
drop view if exists below_capacity cascade;
drop view if exists below_capacity_summary cascade;
drop view if exists at_capacity cascade;
drop view if exists at_capacity_summary cascade;

-- Intermediate steps

-- rid, number of guests in a rental and the capacity of the property.
create view guest_capacity(rid, num_guest, capacity) as
select Rental.rid, count(stay.gid) as num_guest, 
min(capacity) as capacity
from Rental join Stay on rental.rid = stay.rid
join Property on Rental.pid = Property.pid
group by Rental.rid
order by Rental.rid;

-- rid, number of guests and capacity of the property in
-- a rental that is below capacity with all guest ratings.
create view below_capacity(rid, num_guest, capacity, rating) as
select guest_capacity.rid, num_guest, capacity, rating
from guest_capacity left join PropertyRating
on guest_capacity.rid = PropertyRating.rid
where num_guest < capacity;

-- average property rating and number of rentals for 
-- below capacity rentals.
create view below_capacity_summary(capacity, rating, number) as
select 'below capacity' as capacity, avg(rating) as rating,
count(distinct rid) as number
from below_capacity;

-- rid, number of guests and capacity of the property in
-- a rental that is at capacity with all guest ratings.
create view at_capacity(rid, num_guest, capacity, rating) as
select guest_capacity.rid, num_guest, capacity, rating
from guest_capacity left join PropertyRating
on guest_capacity.rid = PropertyRating.rid
where num_guest = capacity;

-- average property rating and number of rentals for 
-- at capacity rentals.
create view at_capacity_summary(capacity, rating, number) as
select 'at capacity' as capacity, avg(rating) as rating,
count(distinct rid) as number
from at_capacity;

-- Answer for q2
insert into q2(capacity, rating, number)
(select * from below_capacity_summary)
        union
(select * from at_capacity_summary);