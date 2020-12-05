set search_path to vacationschema;
drop table if exists q5 cascade;

-- The result table consists of 5 attributes:

-- pid is the pid of each property

-- highest_price and lowest_price are the highest
-- and lowest price ever charged for a week.
-- If the property has only been rented for a week,
-- then highest_price = lowest price.

-- range is highest_price - lowest_price

-- highest_range is has a star in the row with greatest range.
-- If there is a tie, there will be a star on every property
-- with a greatest range.
create table q5(
        pid integer,
        highest_price float,
        lowest_price float,
        range float,
        highest_range varchar(1)
);

drop view if exists all_prices cascade;
drop view if exists prices_range cascade;
drop view if exists not_highest cascade;
drop view if exists with_highest_range cascade;

-- Intermediate steps

-- Highest and lowest prices for each property that has ever been rented.
create view all_prices(pid, highest_price, lowest_price) as
select pid, max(price), min(price)
from Price
group by pid;

-- Highest price, lowest price, and range for each property
-- that has ever been rented.
create view prices_range(pid, highest_price, lowest_price, range) as
select pid, highest_price, lowest_price,
(highest_price - lowest_price) as range
from all_prices;

-- Properties that doesnt have the highest range.
create view not_highest(pid) as
select p1.pid 
from prices_range p1 join prices_range p2
on p1.range < p2.range;

-- Property(ies) with the highest range with a star in highest_range.
create view with_highest_range(
        pid, highest_price, lowest_price, range, highest_range) as
select pid, highest_price, lowest_price, range, '*' as highest_range
from prices_range
where pid not in (select * from not_highest);

-- Answer for q5
insert into q5(pid, highest_price, lowest_price, range, highest_range)
select pid, highest_price, lowest_price, range, highest_range
from (select pid from Property) as p natural left join prices_range
natural left join with_highest_range;
