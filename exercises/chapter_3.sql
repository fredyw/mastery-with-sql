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
