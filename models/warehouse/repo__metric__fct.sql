with repos as (
SELECT warehouse_repos.repo_pk as repo_fk,
       warehouse_repos.repo_name,
       sum(stg_repos.watch_count) as watch_count
       from {{ ref('stg__bigquery__repos') }} as stg_repos
       inner join {{ ref('repo__dim') }} as warehouse_repos
       on stg_repos.repo_name = warehouse_repos.repo_name
group by warehouse_repos.repo_pk,
         warehouse_repos.repo_name
),

authors as (
SELECT warehouse_author.author_pk as author_fk,
       stg_author.repo_name,
       row_number() over(partition by stg_author.repo_name order by stg_author.author.time_sec) as rn
       FROM {{ ref('stg__bigquery__commits') }} as stg_author
       inner join {{ ref('author__dim') }} as warehouse_author
       on stg_author.author.name = warehouse_author.author_name
),

commits as (
select repo_name,
       count(repo_name) as commit_count
       from {{ ref('stg__bigquery__commits') }} as commits
group by repo_name
),

size_in_bytes as (
select repo_name,
       sum(`language`[SAFE_OFFSET(0)].bytes) AS total_bytes
       from {{ ref('stg__bigquery__languages') }}
group by repo_name
),

final as (
select repos.repo_fk,
       warehouse_license.license_pk as license_fk,
       authors.author_fk,
       commits.commit_count,
       repos.watch_count,
       size_in_bytes.total_bytes,
       current_timestamp() as ingestion_timestamp
       from repos
       left join commits on repos.repo_name = commits.repo_name
       left join authors on repos.repo_name = authors.repo_name
       and authors.rn = 1
       inner join {{ ref('stg__bigquery__licenses') }} as stg_licenses
       on stg_licenses.repo_name = repos.repo_name
       inner join {{ ref('license__dim') }} as warehouse_license
       on stg_licenses.license = warehouse_license.license_name
       inner join size_in_bytes on size_in_bytes.repo_name = repos.repo_name
)

select {{ dbt_utils.generate_surrogate_key(['repo_fk', 'ingestion_timestamp']) }} as repo_metric_pk,
       final.*
       from final
