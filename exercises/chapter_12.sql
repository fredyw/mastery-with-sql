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

-- Exercise 12.3
create view vw_monthly_totals as (
    select date_trunc('month', payment_date) as month, sum(amount) as total
    from payment
    group by month
    order by month
);

-- Exercise 12.4
with montly_totals as (
    select month, total as income, rank() over (order by month) as rank
    from vw_monthly_totals
)
select m1.month,
       m1.income, m2.income as "prev month income",
       (m1.income - m2.income) as "change"
from montly_totals m1 left join montly_totals m2 on m1.rank = m2.rank + 1;

select month,
       total as income,
       lag(total) over (order by month) as "prev month income",
       total - lag(total) over (order by month) as "change"
from vw_monthly_totals;

-- Exercise 12.5
begin;

create materialized view mvw_rental_film as
select *
from vw_rental_film;

(
    select * from vw_rental_film
    except
    select * from mvw_rental_film
)
union all
(
    select * from mvw_rental_film
    except
    select * from vw_rental_film
);

rollback;

-- Exercise 12.6
create or replace function unreturned_rentals (
    p_customer_id int
)
returns int
language sql
as $$
    select count(*)::int
    from rental
    where return_date is null
      and customer_id = p_customer_id
$$;

-- Exercise 12.7
select customer_id,
       unreturned_rentals(customer_id) as unreturned_rentals
from customer;