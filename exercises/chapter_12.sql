-- Exercise 12.1
begin;

create view vw_rental_film as (
    select r.rental_id, f.title, f.length, f.rating
    from rental r
         inner join inventory i on r.inventory_id = i.inventory_id
         inner join film f on i.film_id = f.film_id
    order by r.rental_id
 );

select * from vw_rental_film;

rollback;