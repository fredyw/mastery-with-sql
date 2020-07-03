-- Exercise 3.1
select title
from film;

-- Exercise 3.2
select first_name as "First Name", last_name as "Last Name"
from actor;

-- Exercise 3.3
select count(*)
from inventory;

-- Exercise 3.4
select actor_id, first_name, last_name, last_update
from actor;

-- Exercise 3.5
select first_name, length(first_name)
from customer;

-- Exercise 3.6
select first_name,
       last_name,
       left(first_name, 1) || left(last_name, 1) as "initial"
from customer;

-- Exercise 3.7
select title,
       rental_rate,
       replacement_cost,
       ceil(replacement_cost / rental_rate) as "# rentals to break-even"
from film;

-- Exercise 3.8
select title, rating
from film
where rating = 'G';

-- Exercise 3.9
select title, length
from film
where length > 120;

-- Exercise 3.10
select rental_id, rental_date
from rental
where rental_date < '2005-06-01';

-- Exercise 3.11
select title,
       rental_rate,
       replacement_cost,
       ceil(replacement_cost / rental_rate) as "# rentals to break-even"
from film
where ceil(replacement_cost / rental_rate) > 30;

-- Exercise 3.12
select rental_id, rental_date
from rental
where customer_id = '388'
  and (rental_date >= '2005-01-01' and rental_date < '2006-01-01');

-- Exercise 3.13
select title, rental_duration, length
from film
where length <= 60;

select title, rental_duration, length
from film
where not (length > 60);

-- Exercise 3.14
-- It returns neither 'G' nor 'PG'.
select title, rating
from film
where rating != 'G'
  and rating != 'PG';

-- This returns all rows except NULL rating.
select title, rating
from film
where rating != 'G'
   or rating != 'PG';

-- Exercise 3.15
select rental_id, rental_date, return_date
from rental
where return_date >= rental_date
   or return_date < rental_date;

-- Exercise 3.16
select rental_id, return_date
from rental
where return_date is null;

-- Exercise 3.17
select title, rating
from film
where (rating != 'G' and rating != 'PG')
   or rating is null;

-- Exercise 3.18
select title, rating
from film
where rating in ('PG', 'G', 'PG-13');

-- Exercise 3.19
select title, length
from film
where length between 90 and 120;

-- Exercise 3.20
select title
from film
where title like '%GRAFFITI';