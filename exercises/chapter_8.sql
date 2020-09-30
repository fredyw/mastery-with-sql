-- Exercise 8.1
select t.rental_id, t.customer_id, t.rental_date
from (select rental_id,
             customer_id,
             rental_date,
             row_number()
             over (partition by customer_id order by rental_date desc) as row_number
      from rental) t
where t.row_number <= 3;

-- Exercise 8.2
with rent_counts as (
    select i.film_id,
           rank() over (order by count(*)) as rank
    from rental r
         inner join inventory i on r.inventory_id = i.inventory_id
    group by i.film_id
)
select distinct r.customer_id
from rental r
     inner join inventory i on r.inventory_id = i.inventory_id
where i.film_id in (select film_id
                    from rent_counts
                    where rank = 1);

-- Exercise 8.3
select rating
from (select rating,
             row_number() over (partition by rating) as row_number
      from film) t
where row_number = 1 and rating is not null;

-- Exercise 8.4
select customer_id,
       rental_id,
       return_date - rental_date as rent_duration,
       avg(return_date - rental_date) over (partition by customer_id)
from rental;

-- Exercise 8.5
select month,
       amount,
       sum(amount) over (order by month) as running_total
from (select date_trunc('month', payment_date) as month,
             sum(amount) as amount
      from payment
      group by month) t
order by month;

-- Exercise 8.6
with earning_per_rating as (
    select f.title,
           f.rating,
           f.rental_rate * count(*) as income,
           rank()
           over (partition by f.rating order by f.rental_rate * count(*) desc) as rank
    from rental r
         inner join inventory i on r.inventory_id = i.inventory_id
         inner join film f on f.film_id = i.film_id
    where f.rating is not null
    group by f.film_id
)
select title,
       rating,
       income
from earning_per_rating
where rank <= 3;

-- Exercise 8.7
with row_numbers as (
    select row_number() over (order by rental_id) as row_number
    from rental
)
select row_number as missing_from, row_number as missing_to
from row_numbers rn
     left join rental r on rn.row_number = r.rental_id
where r.rental_id is null;

with t as (
    select rental_id as current,
           lead(rental_id) over (order by rental_id) as next
    from rental
)
select current + 1 as missing_from,
       next - 1 as missing_to
from t
where next - current > 1;

-- Exercise 8.8
with rental_dates as (
    select customer_id,
           rental_date,
           lag(rental_date)
           over (partition by customer_id order by rental_date) as prev_rental_date
    from rental
)
select customer_id, max(rental_date - prev_rental_date)
from rental_dates
group by customer_id
order by customer_id;