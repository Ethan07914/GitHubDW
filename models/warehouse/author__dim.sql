with final as (
select distinct
       author.name as author_name,
       author.email as author_email,
       current_timestamp() as ingestion_timestamp
       from {{ ref('stg__bigquery__commits') }}
)

select {{ dbt_utils.generate_surrogate_key(['author_name', 'author_email']) }} as author_pk,
       final.*
       from final