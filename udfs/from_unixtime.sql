/*
select from_unixtime(1530635022862);

select from_unixtime(1459762341);
*/
create or replace function public.from_unixtime (epoch BIGINT)
  returns timestamp
stable
as $$
  select case 
    when len($1)=13 then (TIMESTAMP 'epoch' + $1/1000 * INTERVAL '1 Second ')
    when len($1)=10 then (TIMESTAMP 'epoch' + $1 * INTERVAL '1 Second ')
    else null
  end
$$ language sql; 