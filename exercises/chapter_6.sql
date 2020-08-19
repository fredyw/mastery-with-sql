-- Exercise 6.1
select r.rental_date, f.title
from rental r
     inner join customer c
                on r.customer_id = c.customer_id
     inner join inventory i
                on i.inventory_id = r.inventory_id
     inner join film f
                on f.film_id = i.film_id
where c.first_name = 'PETER'
  and c.last_name = 'MENARD'
order by r.rental_date desc;