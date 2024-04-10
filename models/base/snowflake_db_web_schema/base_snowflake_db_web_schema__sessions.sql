-- snowflake_db_web_schema: sessions
select
_FIVETRAN_ID, 
CAST(CLIENT_ID AS STRING) AS CLIENT_ID, 
IP, 
SESSION_ID, 
SESSION_AT AS SESSION_AT_TS, 
OS, 
_FIVETRAN_DELETED, 
_FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS
from {{  source('snowflake_db_web_schema', 'sessions')}}