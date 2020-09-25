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