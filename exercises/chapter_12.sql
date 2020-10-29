-- Exercise 12.1
create view vw_rental_film as (
    select r.rental_id, f.title, f.length, f.rating
    from rental r
         inner join inventory i on r.inventory_id = i.inventory_id
         inner join film f on i.film_id = f.film_id
    order by r.rental_id
 );

-- Exercise 12.2
select c.customer_id, count(r.rental_id)
from customer as c
    left join (rental as r inner join vw_rental_film as rf
               on r.rental_id = rf.rental_id and rf.rating = 'R')
               using (customer_id)
group by c.customer_id
order by c.customer_id;