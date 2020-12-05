set search_path to vacationschema;
drop table if exists q1 cascade;

-- The result table consists of 2 attributes:
-- luxury amendities that can be offered in a property
-- number of properties that offers this amendity.
-- If no properties offer this amendity, number = 0
create table q1(
        type varchar(30),
        number integer
);

drop view if exists hot_tub cascade;
drop view if exists sauna cascade;
drop view if exists laundry_service cascade;
drop view if exists daily_cleaning cascade;
drop view if exists daily_breakfast_delivery cascade;
drop view if exists concierge_service cascade;
drop view if exists answer cascade;

-- Intermediate steps

-- Number of properties that offers hot tub.
create view hot_tub(type, number) as
select 'hot tub' as type, count(*) as number
from Property
where hot_tub = true;

-- Number of properties that offers sauna.
create view sauna(type, number) as
select 'sauna' as type, count(*) as number
from Property
where sauna = true;

-- Number of properties that offers laundry service.
create view laundry_service(type, number) as
select 'laundry service' as type, count(*) as number
from Property
where laundry = true;

-- Number of properties that offers daily cleaning.
create view daily_cleaning(type, number) as
select 'daily cleaning' as type, count(*) as number
from Property
where cleaning = true;

-- Number of properties that offers daily breakfast delivery.
create view daily_breakfast_delivery(type, number) as
select 'daily breakfast delivery' as type, count(*) as number
from Property
where breakfast = true;

-- Number of properties that offers concierge service.
create view concierge_service(type, number) as
select 'concierge service' as type, count(*) as number
from Property
where concierge = true;

-- Answer for q1
create view answer(type, number) as
(select *
from hot_tub)
    union
(select *
from sauna)
    union
(select *
from laundry_service)
    union
(select *
from daily_cleaning)
    union
(select *
from daily_breakfast_delivery)
    union
(select *
from concierge_service);

-- Insert answer into q1
insert into q1(type, number)
select * from answer;