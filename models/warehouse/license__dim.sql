with final as (
select distinct
       license as license_name,
       CASE
           WHEN license = 'unlicense' THEN 0
           ELSE 1
       END AS is_copyright,
       current_timestamp() as ingestion_timestamp
       from {{ ref('stg__bigquery__licenses') }}
)

select {{ dbt_utils.generate_surrogate_key(['license_name']) }}  as license_pk,
       final.*
       from final