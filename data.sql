insert into Guest values
(1000, 'Darth Vader', '1985-12-06', 'Death Star'),
(2000, 'Leia, Princess', '2001-10-05', 'Alderaan'), 
(3000, 'Juliet Capulet', '1991-07-24', 'Verona'),
(4000, 'Romeo Montague', '1988-05-11', 'Verona'),
(5000, 'Mercutio', '1988-03-03', 'Verona'),
(6000, 'Chewbacca', '1998-09-15', 'Kashyyyk');

insert into Host values
(01, 'luke@gmail.com'),
(02, 'leia@gmail.com'),
(03, 'han@gmail.com');

insert into Property values
-- pid, hid, num_bedroom, num_bathroom, capacity, address 
-- hot_tub, sauna, laundry, cleaning, breakfast, concierge
(10000, 01, 3, 1, 6, 'Tatooine', true, false, false, true, false, false),
(20000, 02, 1, 1, 2, 'Alderaan', true, true, false, true, false, false),
(30000, 03, 2, 1, 3, 'Corellia', false, false, false, false, true, true),
(40000, 02, 2, 1, 2, 'Verona', false, false, true, false, false, false),
(50000, 03, 2, 2, 4, 'Florence', true, false, false, false, false, false),
(60000, 01, 1, 1, 2, 'Toronto', true, true, true, true, false, true);

insert into CityProperty values
(30000, 20, 'bus');

insert into WaterProperty values
(20000, 'lake', false);

insert into Card values
-- cid, gid, number
(100, 1000, '3466704824219330'),
(200, 2000, '6011253896008199'),
(400, 4000, '5446447451075463'),
(500, 5000, '4666153163329984'),
(600, 6000, '6011624297465933');

insert into Rental values
-- rid, gid, pid, cid, start_date, end_date
(1, 1000, 20000, 100, '2019-01-05', '2019-01-12'),
(2, 2000, 30000, 200, '2019-01-12', '2019-01-26'),
(3, 4000, 20000, 400, '2019-01-12', '2019-01-19'),
(4, 5000, 50000, 500, '2019-01-05', '2019-01-12'),
(5, 6000, 50000, 600, '2019-01-12', '2019-01-19');

insert into Price values
-- pid, date, price
(20000, '2019-01-05', 580.00),
(30000, '2019-01-12', 750.00),
(30000, '2019-01-19', 750.00),
(20000, '2019-01-12', 600.00),
(50000, '2019-01-05', 1000.00),
(50000, '2019-01-12', 1220.00);

insert into Stay values
-- rid, gid
(1, 1000),
(1, 2000),
(2, 2000),
(2, 3000),
(2, 4000),
(3, 4000),
(3, 3000),
(4, 5000), 
(4, 1000),
(4, 4000),
(5, 6000),
(5, 2000);

insert into PropertyRating values
(1, 2000, 5),
(1, 1000, 2),
(2, 4000, 5),
(2, 3000, 5),
(2, 2000, 1),
(3, 3000, 5),
(4, 5000, 1),
(4, 4000, 1),
(5, 6000, 3);

insert into PropertyComment values
(1, 1000, 'Looks like she hides rebel scum here.'),
(2, 2000, 'A bit scruffy, could do with more regular housekeeping'),
(5, 6000, 'Fantastic, arggg');

insert into HostRating values
(1, 1000, 2),
(2, 2000, 5),
(3, 4000, 3),
(4, 5000, 4),
(5, 6000, 4);