-- Exercise 4.1
select count(*) as "# customers", count(email) as "# customers with email"
from customer;

-- Exercise 4.2
select count(*) as "# customers",
       count(email) as "# customers with email",
       100.0 * count(email) / count(*) as "# with email"
from customer;