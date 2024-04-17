--dim_client (one row per client)
WITH ranking AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY ClIENT_ID ORDER BY SESSION_AT_TS DESC) as row_n
    FROM {{ ref('base_snowflake_db_web_schema__sessions') }}
)

select 
    CLIENT_ID,
    IP,
    OS
FROM ranking
WHERE row_n = 1