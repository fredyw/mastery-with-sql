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

-- Exercise 3.21
select title, rating
from film
where rating not in ('G', 'PG');

-- Exercise 3.22
select first_name, last_name
from customer
where email is not null
order by last_name desc;

-- Exercise 3.23
select country_id, city
from city
order by country_id, city;

-- Exercise 3.24
select first_name || ' ' || last_name as full_name,
       length(first_name || ' ' || last_name) as len
from actor
order by len desc;

-- Exercise 3.25
-- ORDER BY x, y DESC --> is equivalent to ORDER BY x ASC, y DESC
-- ORDER BY x DESC, y DESC

-- Exercise 3.26
select rental_id, date_part('hour', rental_date) as "rental hour"
from rental
where date_part('hour', rental_date) >= 22;

-- Exercise 3.27
select payment_id, payment_date
from payment
order by payment_date desc
limit 3;

-- Exercise 3.28
select title, length, rating
from film
where rating != 'R'
order by length, title
limit 4;

-- Exercise 3.29
select payment_id, amount, payment_date
from payment
where payment_date >= '2007-01-01'
  and payment_date < '2007-02-01'
order by payment_date desc
limit 3;

-- Exercise 3.30
select p.payment_id, p.amount, p.payment_date
from (select payment_id, amount, payment_date
      from payment
      where payment_date >= '2007-01-01'
        and payment_date < '2007-02-01'
      order by payment_date desc
      limit 3) p
order by payment_date;

-- Exercise 3.31
select distinct rating
from film
where rating is not null
order by rating;

-- Exercise 3.32
select distinct date_part('hour', rental_date) as hour
from rental
order by hour;

-- Exercise 3.33
select distinct rental_duration, rental_rate
from film
order by rental_duration;

-- Exercise 3.34
select first_name
from actor
order by last_name;

-- last_name is not in the select list for SELECT DISTINCT.
-- select distinct first_name
-- from actor
-- order by last_name;

-- Exercise 3.35
select distinct rating,
                case rating
                    when 'G' then 'General'
                    when 'PG' then 'Parental Guidance Recommended'
                    when 'PG-13' then 'Parents Strongly Cautioned'
                    when 'R' then 'Restricted'
                    when 'NC-17' then 'Adults Only'
                end as "rating description"
from film
where rating is not null
order by rating;

-- Exercise 3.36
select rental_id,
       rental_date,
       return_date,
       case
           when return_date is null then 'Not Returned'
           else 'Returned'
       end as "return_status"
from rental
order by return_status;

-- Exercise 3.37
select country
from country
order by case country
             when 'Australia' then 0
             when 'United Kingdom' then 1
             when 'United States' then 2
             else 4
         end,
         country;

-- Exercise 3.38
select first_name, last_name, email
from customer
order by random()
limit 5;