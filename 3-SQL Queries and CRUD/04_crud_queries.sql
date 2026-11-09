CRUD operations for the Student Rental Platform

-- SELECT 1: a student searches for available units in Tempe priced at or below the predicted fair rent
select address, unit_no, bedrooms, bathrooms, rent, predicted_rent
from property, unit
where property.property_id = unit.property_id
and city = 'Tempe'
and status = 'available'
and rent <= predicted_rent;

-- SELECT 2: landlord 4 views their unresolved maintenance requests
select request_id, address, unit_no, name, description, ai_category, ai_urgency
from maintenance_request, property, person
where maintenance_request.property_id = property.property_id
and maintenance_request.tenant_id = person.person_id
and landlord_id = 4
and status <> 'resolved';

-- SELECT 3: average rating and number of reviews for each property with at least 4 reviews
select property_id, avg(rating), count(*)
from review
group by property_id
having count(*) >= 4;

-- INSERT: tenant 74 (on an active lease for unit 102 of property 20) submits a maintenance request
insert into maintenance_request
values (148, 74, 20, '102', 'Garbage disposal is jammed and makes a humming noise', 'open', '2026-11-07', null, null, 'appliance', 'medium');

select *
from maintenance_request
where request_id = 148;

-- UPDATE: the landlord marks request 148 as resolved and records the repair cost
update maintenance_request
set status = 'resolved', resolved_date = '2026-11-09', cost = 95.00
where request_id = 148;

select *
from maintenance_request
where request_id = 148;

-- DELETE: tenant 115 removes their review of property 7

select *
from review
where tenant_id = 115 and property_id = 7;

delete from review
where tenant_id = 115 and property_id = 7;

select *
from review
where tenant_id = 115 and property_id = 7;
