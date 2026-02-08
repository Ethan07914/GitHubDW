with repo_languages as (
select repo_name,
       `language`[SAFE_OFFSET(0)].name as language_name,
       `language`[SAFE_OFFSET(0)].bytes,
       row_number() over(partition by repo_name order by `language`[SAFE_OFFSET(0)].bytes desc) as rn
       from {{ ref('stg__bigquery__languages') }}
),

created as (
select repo_name,
       MIN(author.time_sec) as created_at
       from {{ ref('stg__bigquery__commits') }}
group by repo_name
),

final as (
select {{ dbt_utils.generate_surrogate_key(['repo_languages.repo_name']) }} as repo_pk,
       repo_languages.repo_name,
       language_name as primary_language,
       FORMAT_TIMESTAMP('%F', TIMESTAMP_SECONDS(created.created_at)) as created_at
       from {{ ref('stg__bigquery__repos') }} as repos
       inner join repo_languages on repos.repo_name = repo_languages.repo_name
       left join created on repo_languages.repo_name = created.repo_name
where rn = 1
)

select *,
       current_timestamp() as ingestion_timestamp
       from final