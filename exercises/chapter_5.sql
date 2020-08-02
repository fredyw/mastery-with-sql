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

-- Exercise 5.4
select int '33'; -- 33
-- select int '33.3'; -- error
select cast(33.3 as int); -- 33
select cast(33.8 as int); -- 33
select 33::text; -- '33'
select 'hello'::varchar(2); -- 'he'
-- select cast(35000 as smallint); -- error
-- select 12.1::numeric(1, 1); -- error

-- Exercise 5.5
select '2019-03-04 03:30PM America/New_York'::timestamptz,
       '2019-03-04 03:30PM EST'::timestamptz,
       '2019-03-04 03:30PM -5'::timestamptz;
