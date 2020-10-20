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