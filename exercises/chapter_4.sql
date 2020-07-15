-- Exercise 4.1
select count(*) as "# customers", count(email) as "# customers with email"
from customer;

-- Exercise 4.2
select count(*) as "# customers",
       count(email) as "# customers with email",
       100.0 * count(email) / count(*) as "# with email"
from customer;

-- Exercise 4.3
select count(distinct customer_id)
from payment;

-- Exercise 4.4
select avg(return_date - rental_date) as "avg rental duration"
from rental;

-- Exercise 4.5
select sum(amount) as total
from payment;

-- Exercise 4.6
select actor_id, count(*) as num_films
from film_actor
group by actor_id
order by num_films desc;

-- Exercise 4.7
select customer_id
from rental
group by customer_id
having count(*) >  40;

-- Exercise 4.8
select date_part('year', payment_date) as "year",
       date_part('month', payment_date) as "month",
       staff_id,
       count(*) as num_payments,
       sum(amount) payment_total,
       avg(amount) avg_payment_amount
from payment
group by date_part('year', payment_date), date_part('month', payment_date), staff_id
order by year, month;

-- Exercise 4.9
select count(case
                 when return_date - rental_date < interval '3 days' then 1
             end) as "lt 3 days",
       count(case
                 when return_date - rental_date >= interval '3 days' then 1
             end) as "gt 3 days",
       count(case when return_date is null then 1 end) as "never returned"
from rental;

-- Exercise 4.10
select case
           when length between 0 and 59 then '0-1hrs'
           when length between 60 and 119 then '1-2hrs'
           when length between 120 and 179 then '2-3hrs'
           else '3hrs+'
       end as "len",
       count(*) as "count"
from film
group by 1
order by len;

-- Exercise 4.11
-- avg ignores NULL lengths whereas count(*) will count all the rows including those
-- with NULL lengths.

-- Exercise 4.12
select customer_id, avg(return_date - rental_date) as avg_rent_duration
from rental
group by customer_id
order by avg_rent_duration desc;

-- Exercise 4.13
select customer_id
from payment
group by customer_id
having bool_and(amount > 2);