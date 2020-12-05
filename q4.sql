set search_path to vacationschema;
drop table if exists q4 cascade;

-- The result table consists of two attributes

-- Type is either 'water', 'city' or 'others',
-- corresponding to properties that is water type
-- and/or city type, or neither.

-- extra_guest is the number of average extra guests
-- for properties of that type. If the type of property
-- has never been booked, extra_geust is null.
create table q4(
        type varchar(30),
        extra_guest float
);

drop view if exists avg_guest cascade;
drop view if exists property_guest cascade;
drop view if exists avg_water cascade;
drop view if exists avg_city cascade;
drop view if exists avg_other cascade;

-- Intermediate steps

-- Average number of extra guest for each rental.
create view avg_guest(rid, pid, number) as
select Stay.rid, pid, count(Stay.gid) - 1 as number
from Stay join Rental on Stay.rid = Rental.rid
group by Stay.rid, pid;

-- Average number of extra guest for water property
create view avg_water(type, number) as
select 'water' as type, avg(number) as number
from avg_guest
where pid in (
        select pid from WaterProperty
);

-- Average number of extra guest for city property
create view avg_city(type, number) as
select 'city' as type, avg(number) as number
from avg_guest
where pid in (
        select pid from CityProperty
);

-- pid and number of extra guest for other property
create view avg_other(type, number) as
select 'other' as type, avg(number) as number
from avg_guest
where pid not in (
        select pid from WaterProperty
) and pid not in (
        select pid from CityProperty
);

-- Answer for q4
insert into q4(type, extra_guest)
(select * from avg_water)
        union
(select * from avg_city)
        union
(select * from avg_other);
