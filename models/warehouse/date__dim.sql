with final as (
select format_date('%F', d) as date_pk,
       extract(YEAR from d) as year,
       extract(MONTH from d) as month,
       format_date('%B', d) as month_name,
       format_date('%w', d) as week_day,
       format_date('%A', d) as day_name,
      (case
           when format_date('%A', d) in ('Sunday', 'Saturday') then 0
           else 1
       end) as is_weekday,
       from (
       select *
              from
              unnest(generate_date_array('1970-01-01', '2040-01-01', interval 1 day)) as d)
)

select *
       from final
