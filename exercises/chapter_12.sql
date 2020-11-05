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

-- Exercise 12.8
create or replace function random (
    p_low int,
    p_high int
)
returns int
language sql
as $$
    select floor(random() * (p_high - p_low + 1))::int + p_low;
$$;

-- Exercise 12.9
create or replace function apply_discount (
    p_customer_id int,
    p_film_id int
)
returns bool
language plpgsql
as $$
    declare
        count_film_rented int;
    begin
        select count(*)
        into count_film_rented
        from rental r
             inner join inventory i on r.inventory_id = i.inventory_id
             inner join film f on i.film_id = f.film_id
        where r.customer_id = p_customer_id
          and f.film_id = p_film_id;

        return unreturned_rentals(p_customer_id) = 0 and count_film_rented = 0;
    end;
$$;

-- Exercise 12.10
create or replace function fizzbizz(p_n int)
returns table (n int, fb text)
language plpgsql
as $$
    begin
        for i in 1..p_n loop
            n := i;
            if n % 3 = 0 and n % 5 = 0 then
                fb :=  'FizzBuzz';
            elsif n % 3 = 0 then
                fb := 'Fizz';
            elsif n % 5 = 0 then
                fb :=  'Buzz';
            else
                fb := n::text;
            end if;
            return next;
        end loop;
    end;
$$;
