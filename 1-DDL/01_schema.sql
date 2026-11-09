create table person (
    person_id  integer,
    name       varchar(100) not null,
    email      varchar(100) not null unique,
    phone      varchar(20),
    primary key (person_id));

create table tenant (
    person_id   integer,
    university  varchar(100),
    primary key (person_id),
    foreign key (person_id) references person
        on delete cascade);

create table landlord (
    person_id     integer,
    company_name  varchar(100),
    primary key (person_id),
    foreign key (person_id) references person
        on delete cascade);

create table property (
    property_id  integer,
    landlord_id  integer not null,
    address      varchar(150) not null,
    city         varchar(50) not null,
    state        char(2) not null,
    zip          char(5) not null,
    type         varchar(20) not null check (type in ('apartment', 'house', 'townhouse', 'condo')),
    year_built   integer check (year_built > 1800),
    primary key (property_id),
    foreign key (landlord_id) references landlord
        on delete no action);


create table unit (
    property_id     integer,
    unit_no         varchar(10),
    bedrooms        integer not null check (bedrooms >= 0),
    bathrooms       numeric(3,1) not null check (bathrooms > 0),
    sqft            integer check (sqft > 0),
    rent            numeric(8,2) not null check (rent > 0),
    status          varchar(15) not null check (status in ('available', 'occupied', 'maintenance')),
    predicted_rent  numeric(8,2) check (predicted_rent > 0),
    primary key (property_id, unit_no),
    foreign key (property_id) references property
        on delete cascade);

create table lease (
    lease_id      integer,
    property_id   integer not null,
    unit_no       varchar(10) not null,
    start_date    date not null,
    end_date      date not null,
    monthly_rent  numeric(8,2) not null check (monthly_rent > 0),
    deposit       numeric(8,2) not null check (deposit > 0),
    status        varchar(15) not null check (status in ('pending', 'active', 'ended')),
    check (end_date > start_date),
    primary key (lease_id),
    foreign key (property_id, unit_no) references unit (property_id, unit_no)
        on delete no action);

create table signs (
    tenant_id  integer,
    lease_id   integer,
    primary key (tenant_id, lease_id),
    foreign key (tenant_id) references tenant,
    foreign key (lease_id) references lease
        on delete cascade);

create table maintenance_request (
    request_id      integer,
    tenant_id       integer not null,
    property_id     integer not null,
    unit_no         varchar(10) not null,
    description     varchar(200) not null,
    status          varchar(15) not null check (status in ('open', 'in_progress', 'resolved')),
    submitted_date  date not null,
    resolved_date   date,
    cost            numeric(8,2) check (cost > 0),
    ai_category     varchar(20),
    ai_urgency      varchar(10) check (ai_urgency in ('low', 'medium', 'high', 'emergency')),
    check (resolved_date is null or resolved_date >= submitted_date),
    primary key (request_id),
    foreign key (tenant_id) references tenant
        on delete no action,
    foreign key (property_id, unit_no) references unit (property_id, unit_no)
        on delete no action);

create table review (
    tenant_id    integer,
    property_id  integer,
    rating       smallint not null check (rating >= 1 and rating <= 5),
    comment      varchar(200),
    review_date  date not null,
    primary key (tenant_id, property_id),
    foreign key (tenant_id) references tenant,
    foreign key (property_id) references property
        on delete cascade);
