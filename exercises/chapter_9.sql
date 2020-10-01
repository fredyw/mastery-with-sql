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
