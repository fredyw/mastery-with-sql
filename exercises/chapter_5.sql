-- Exercise 5.1
select title || ' is ' || coalesce(length || ' minutes', 'unknown') as length_desc
from film;

-- Exercise 5.2
select left(title, 3) || repeat('*', length(title) - 3) as "Guess!"
from film;