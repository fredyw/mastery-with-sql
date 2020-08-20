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

-- Exercise 6.2
select s.store_id, st.first_name || ' ' || st.last_name as "Manager", st.email
from store s
     inner join staff st
                on s.manager_staff_id = st.staff_id;

-- Exercise 6.3
select f.film_id, f.title, count(*) as count
from rental r
     inner join inventory i
                on r.inventory_id = i.inventory_id
     inner join film f
                on f.film_id = i.film_id
group by f.film_id, f.title
order by count desc
limit 3;

-- Exercise 6.4
select r.customer_id,
       count(distinct f.film_id) as num_films,
       count(distinct fa.actor_id) as num_actors
from rental r
     inner join inventory i
                on r.inventory_id = i.inventory_id
     inner join film f
                on f.film_id = i.film_id
     inner join film_actor fa
                on fa.film_id = f.film_id
group by r.customer_id
order by r.customer_id;