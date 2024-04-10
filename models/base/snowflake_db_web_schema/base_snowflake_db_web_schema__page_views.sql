select
_FIVETRAN_ID, 
VIEW_AT AS VIEW_AT_TS, 
SESSION_ID, 
PAGE_NAME, 
_FIVETRAN_DELETED, 
_FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS
from {{  source('snowflake_db_web_schema', 'page_views')}}