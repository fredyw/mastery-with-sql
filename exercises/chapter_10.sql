-- Exercise 10.1
create schema beach;

-- Exercise 10.2
create table beach.customers (
    first_name text,
    last_name text,
    email text,
    phone text,
    date date
);

-- Exercise 10.3
create table beach.equipment (
    item_type text,
    description text,
    replacement_cost numeric(7, 2)
);

-- Exercise 10.4
alter table beach.equipment add missing boolean;

-- Exercise 10.5
create table beach.customers (
    customer_id bigint generated always as identity primary key,
    email text,
    first_name text,
    last_name text,
    phone text,
    create_date date
);

-- Exercise 10.6
create table beach.equipment (
    equipment_id bigserial primary key,
    item_type text,
    description text,
    replacement_cost numeric(7, 2),
    missing boolean
);