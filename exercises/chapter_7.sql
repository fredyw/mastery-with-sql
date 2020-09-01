-- Exercise 7.1
select distinct first_name, last_name
from customer
     inner join rental r on customer.customer_id = r.customer_id
where rental_date::date = (select min(rental_date::date) from rental);
