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