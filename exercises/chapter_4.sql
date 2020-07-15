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
select sum(amount) as "total"
from payment;

-- Exercise 4.6
select actor_id, count(*) as "num_films"
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
       count(*) as "num_payments",
       sum(amount) "payment_total",
       avg(amount) "avg_payment_amount"
from payment
group by date_part('year', payment_date), date_part('month', payment_date), staff_id
order by year, month;