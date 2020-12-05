insert into Guest values
(9876, 'Jasper Scott', '1999-12-05', '41 College St'),
(8765, 'Karen Clark', '2000-01-31', '41 College St'), 
(7654, 'Nancy Cox', '1999-10-20', '24 Ross Dr'),
(6543, 'Betty Evans', '1969-01-03', '25th Ave'),
(5432, 'Jeremy Perry', '1976-10-04', '56 Bloor St'),
(4321, 'Michael Perry', '2005-07-06', '56 Bloor St'),
(3210, 'Daniel Kim', '1974-11-06', '28 Finch Ave');

insert into Host values
(12, 'hector@gmail.com'),
(78, 'silvia@hotmail.com'),
(52, 'megan@yahoo.com'),
(23, 'jared@outlook.com');

insert into Property values
-- pid, hid, num_bedroom, num_bathroom, capacity, address 
-- hot_tub, sauna, laundry, cleaning, breakfast, concierge
(12345, 12, 2, 2, 3, '7 College St', true, false, false, true, false, true),
(23456, 12, 4, 3, 8, '28 4th Ave', false, false, true, true, true, true),
(34567, 78, 6, 4, 12, '38 Grenville St', true, false, true, false, true, false),
(45678, 52, 0, 1, 1, '23 Main St', false, false, false, false, false, true),
(56789, 23, 3, 2, 3, '58 Cambie St', false, false, true, false, true, true);

insert into CityProperty values
(12345, 98, 'subway'),
(23456, 0, 'none'),
(34567, 35, 'LRT'),
(56789, 80, 'bus');

insert into WaterProperty values
(12345, 'beach', true),
(12345, 'lake', false),
(12345, 'pool', false),
(23456, 'pool', true),
(23456, 'lake', true),
(45678, 'beach', false);

insert into Card values
-- cid, gid, number
(1, 9876, '5824839471956043'),
(2, 9876, '5878095198212309'),
(3, 7654, '0976859258601933'),
(4, 3210, '1294039581049871');

insert into Rental values
-- rid, gid, pid, cid, start_date, num_weeks
(1, 9876, 12345, 1, '2019-11-09', '2019-11-23'),
(2, 9876, 12345, 2, '2019-11-23', '2019-11-30'),
(3, 7654, 45678, 3, '2019-11-02', '2019-11-09'),
(4, 3210, 34567, 4, '2019-12-21', '2019-12-28');


insert into Price values
-- pid, date, price
(12345, '2019-11-09', 500.00),
(12345, '2019-11-16', 300.00),
(12345, '2019-11-23', 400.00),
(45678, '2019-11-02', 290.00),
(34567, '2019-12-21', 1200.00);

insert into Stay values
-- rid, gid
(1, 9876),
(1, 8765),
(2, 9876),
(2, 7654),
(2, 4321),
(3, 7654),
(4, 9876),
(4, 8765),
(4, 7654),
(4, 6543),
(4, 5432), 
(4, 4321),
(4, 3210);

insert into PropertyRating values
(2, 4321, 4),
(2, 9876, 5),
(3, 7654, 1),
(4, 4321, 5),
(4, 6543, 4),
(4, 3210, 5),
(4, 8765, 3);

insert into PropertyComment values
(3, 7654, 'Bad place!'),
(4, 3210, 'Good place!');

insert into HostRating values
(1, 9876, 4),
(2, 9876, 5),
(4, 3210, 5);