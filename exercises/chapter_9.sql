-- Exercise 9.1
(
    select rental_date::date as interaction_date
    from rental
)
union
(
    select payment_date::date as interaction_date
    from payment
)
order by interaction_date;

-- Exercise 9.2
(
    select first_name, last_name
    from customer
)
intersect
(
    select first_name, last_name
    from actor
);

-- Exercise 9.3
(
    select film_id
    from film_actor
    where actor_id = 49
)
intersect
(
    select film_id
    from film_actor
    where actor_id = 152
)
intersect
(
    select film_id
    from film_actor
    where actor_id = 180
);

-- Exercise 9.4
(
    select generate_series(min(rental_id), max(rental_id)) as id
    from rental
)
except
(
    select rental_id as id
    from rental
);

-- Exercise 9.5
(
    select c.first_name, c.last_name
    from rental r inner join customer c on c.customer_id = r.customer_id
    where date_part('isodow', rental_date) = 6
)
except
(
    select c.first_name, c.last_name
    from rental r inner join customer c on c.customer_id = r.customer_id
    where date_part('isodow', rental_date) = 7
)
order by first_name;

-- Exercise 9.6
(
    select rental_date::date as interaction_date, 'rental' as type
    from rental
)
union
(
    select payment_date::date as interaction_date, 'payment' as type
    from payment
)
order by interaction_date;

-- Exercise 9.7
(
    select country
    from staff s
         inner join address a on s.address_id = a.address_id
         inner join city ct on ct.city_id = a.city_id
         inner join country c on c.country_id = ct.country_id
)
intersect
(
    select country
    from customer cr
         inner join address a on cr.address_id = a.address_id
         inner join city ct on ct.city_id = a.city_id
         inner join country c on c.country_id = ct.country_id
);