-- Manual INSERT examples: a new landlord joins and lists a new property with two units

insert into person
values (133, 'Maria Lopez', 'maria.lopez@example.com', '(480) 555-0142');

insert into landlord
values (133, 'Lopez Student Housing');

insert into property
values (25, 133, '1200 E Lemon St', 'Tempe', 'AZ', '85281', 'apartment', 2019);

insert into unit
values (25, '101', 2, 2.0, 950, 1650, 'available', 1720);

insert into unit
values (25, '102', 1, 1.0, 680, 1250, 'available', 1210);
