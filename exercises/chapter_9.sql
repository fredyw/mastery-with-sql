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

-- Exercise 9.3
(
    select generate_series(min(rental_id), max(rental_id)) as id
    from rental
)
except
(
    select rental_id as id
    from rental
);