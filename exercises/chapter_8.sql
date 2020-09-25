-- Exercise 8.1
select t.rental_id, t.customer_id, t.rental_date
from (select rental_id,
             customer_id,
             rental_date,
             row_number()
             over (partition by customer_id order by rental_date desc) as row_number
      from rental) t
where t.row_number <= 3;