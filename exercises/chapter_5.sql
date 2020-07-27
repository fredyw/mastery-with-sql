-- Exercise 5.1
select title || ' is ' || coalesce(length || ' minutes', 'unknown') as length_desc
from film;