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

-- Exercise 7.6
select c.first_name,
       c.last_name,
       case
           when exists(select *
                       from rental r
                            inner join inventory i on r.inventory_id = i.inventory_id
                       where i.store_id != c.store_id
                         and c.customer_id = r.customer_id) > 0 then 'Y'
           else 'N'
       end as "HasRentedOtherStore"
from customer c;

-- Exercise 7.7
select first_name, last_name
from customer
     cross join (values (1), (2), (3), (4)) as t
order by customer_id;

-- Exercise 7.8
select to_char(r.rent_day, 'Day') as day_name, round(avg(r.count)) as average
from (select date_trunc('day', rental_date) rent_day, count(*)
      from rental
      group by rent_day) r
group by day_name
order by average desc;