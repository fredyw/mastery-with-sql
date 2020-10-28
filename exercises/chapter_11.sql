-- Exercise 11.1
copy playground.note_tags
from '/home/fredy/data/github/mastery-with-sql/ch11-note_tags.csv'
with (format csv, header true);

-- Exercise 11.2
copy (
    select u.first_name || ' ' || u.last_name as name, count(*) as note_count
    from playground.users u
         inner join playground.notes n on u.email = n.user_email
    group by name
    order by note_count desc
)
to '/tmp/ch11-2.txt'
with (format csv, header true);

-- Exercise 11.3
copy (
    select 'test'::text,
           33::numeric,
           33.3, 33.2999992::real,
           true::boolean,
           '2019-05-12'::date,
           '2019-05-12 15:25:11.644876+10'::timestamptz,
           interval '1 day'
)
to '/tmp/ch11-3.txt';

-- Exercise 11.4
begin;

insert into customer(store_id, first_name, last_name, address_id, active)
values (1, 'John', 'Henry', 1, 1)
returning *;

rollback;

-- Exercise 11.5
begin;

create table rental_stats (
    date date,
    num_rentals int
);

insert into rental_stats
select rental_date::date as rental_day, count(*)
from rental
group by rental_day
order by rental_day;

rollback;

-- Exercise 11.6
begin;

update customer
set email = lower(first_name) || '.' || lower(last_name) || '@sakilacustomer.org'
returning *;

rollback;

-- Exercise 11.7
begin;

update film
set rental_rate = rental_rate * 1.1
where film_id in (select i.film_id
                  from rental
                       inner join inventory i on rental.inventory_id = i.inventory_id
                  group by i.film_id
                  order by count(*) desc
                  limit 20);

rollback;

-- Exercise 11.8
begin;

alter table film add column length_hrs numeric(2, 1);

update film set length_hrs = film.length_hrs / 60.0
returning *;

rollback;

-- Exercise 11.9
begin;

delete from payment
where amount = 0
returning *;

rollback;

-- Exercise 11.10
begin;

delete from language
where language_id not in (select distinct film.language_id from film);

rollback;