-- Exercise 11.1
copy playground.note_tags
from '/home/fredy/data/github/mastery-with-sql/ch11-note_tags.csv'
with (format csv, header true);

-- Exercise 11.2
copy (
    select u.first_name || ' ' || u.last_name as name, count(*) as note_count
    from playground.users u
         inner join playground.notes n on u.email = n.user_email
    group by name
    order by note_count desc
)
to '/tmp/ch11-2.txt'
with (format csv, header true);

-- Exercise 11.3
copy (
    select 'test'::text,
           33::numeric,
           33.3, 33.2999992::real,
           true::boolean,
           '2019-05-12'::date,
           '2019-05-12 15:25:11.644876+10'::timestamptz,
           interval '1 day'
)
to '/tmp/ch11-3.txt';