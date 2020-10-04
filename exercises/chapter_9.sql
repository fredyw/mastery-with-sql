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