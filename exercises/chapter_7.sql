-- Exercise 7.1
select distinct first_name, last_name
from customer
     inner join rental r on customer.customer_id = r.customer_id
where rental_date::date = (select min(rental_date::date) from rental);

-- Exercise 7.2
select film_id, title
from film
where film_id not in (select film_id from film_actor);

select f.film_id, f.title
from film f
     left join film_actor fa on f.film_id = fa.film_id
where fa.film_id is null;

-- Exercise 7.3
select c.customer_id, c.first_name, c.last_name
from customer c
     inner join rental r
                on c.customer_id = r.customer_id
     inner join inventory i on r.inventory_id = i.inventory_id
where i.film_id = (select i.film_id
                   from rental r
                        inner join inventory i on r.inventory_id = i.inventory_id
                   group by i.film_id
                   order by count(*), i.film_id
                   limit 1);

-- Exercise 7.4
select country
from country
where (select count(*) from city where city.country_id = country.country_id) > 15;

-- Exercise 7.5
select c.customer_id,
       c.first_name,
       c.last_name,
       (select i.store_id
        from rental r
             inner join inventory i on
            r.inventory_id = i.inventory_id
        where c.customer_id = r.customer_id
        group by i.store_id
        order by count(*) desc
        limit 1) as "Favorite Store"
from customer c;