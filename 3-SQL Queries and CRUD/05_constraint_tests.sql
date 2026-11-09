insert into person
values (134, 'Test User', 'maria.lopez@example.com', '(480) 555-0000');

insert into property
values (26, null, '500 S Mill Ave', 'Tempe', 'AZ', '85281', 'condo', 2015);

insert into lease
values (127, 20, '102', '2027-08-01', '2027-07-01', 1500, 750, 'pending');

insert into maintenance_request
values (149, 74, 20, '999', 'Faucet is dripping', 'open', '2026-11-07', null, null, 'plumbing', 'low');

insert into review
values (32, 20, 4, 'Second review', '2026-11-07');

insert into review
values (74, 20, 6, 'Amazing', '2026-11-07');

delete from landlord
where person_id = 4;
