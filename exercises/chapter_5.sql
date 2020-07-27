-- Exercise 5.1
select title || ' is ' || coalesce(length || ' minutes', 'unknown') as length_desc
from film;

-- Exercise 5.2
select left(title, 3) || repeat('*', length(title) - 3) as "Guess!"
from film;

-- Exercise 5.3
select round(100.0 * count(*) filter (where rating = 'NC-17') / count(*)) as "% NC-17",
       round(100.0 * count(*) filter (where rating = 'PG') / count(*)) as "% PG",
       round(100.0 * count(*) filter (where rating = 'G') / count(*)) as "% G",
       round(100.0 * count(*) filter (where rating = 'R') / count(*)) as "% R",
       round(100.0 * count(*) filter (where rating = 'PG-13') / count(*)) as "% PG-13"
from film;