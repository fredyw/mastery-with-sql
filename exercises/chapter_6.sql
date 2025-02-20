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

-- Exercise 6.5
select f.title, l.name as "language"
from film f
     inner join
     language l
     on f.language_id = l.language_id;

select f.title, l.name as "language"
from film f
     inner join
     language l
     using (language_id);

-- Exercise 6.6
select f.title
from film f
     left outer join inventory i on f.film_id = i.film_id
where i.store_id is null;

-- Exercise 6.7
select f.title, count(i.film_id) as count
from film f
     left outer join inventory i on f.film_id = i.film_id
group by f.film_id, f.title
order by count;

-- Exercise 6.8
select c.customer_id, count(r.rental_id) as num_rented
from customer c
     left outer join rental r on c.customer_id = r.customer_id and
                                 r.rental_date::timestamp::date = '2005-05-24'
group by c.customer_id
order by num_rented desc, c.customer_id;

-- Exercise 6.9
select f.film_id, s.store_id, count(i.inventory_id) as stock
from film f
     cross join store s
     left join inventory i
               on f.film_id = i.film_id and s.store_id = i.store_id
group by f.film_id, s.store_id
order by stock, f.film_id, s.store_id;

-- Exercise 6.10
select t, count(r.rental_id)
from generate_series('2005-01-01 00:00:00'::timestamp,
                     '2005-12-01 00:00:00'::timestamp,
                     '1 month') t
     left join rental r
               on date_trunc('month', r.rental_date) = t
group by t;

-- Exercise 6.11
select r1.customer_id
from rental r1
     inner join rental r2
                on r1.customer_id = r2.customer_id and
                   r1.rental_date < r2.rental_date
     inner join inventory i1 on r1.inventory_id = i1.inventory_id
     inner join inventory i2 on r2.inventory_id = i2.inventory_id
where i1.film_id = 97
  and i2.film_id = 841;