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

select customer_id
from rental
group by customer_id
having count(*) >  40;