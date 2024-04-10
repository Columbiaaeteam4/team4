-- snowflake_db_web_schema: item_views
select
_FIVETRAN_ID,
REMOVE_FROM_CART_QUANTITY,
ADD_TO_CART_QUANTITY,
ITEM_NAME,
ITEM_VIEW_AT AS ITEM_VIEW_AT_TS,
SESSION_ID,
PRICE_PER_UNIT,
_FIVETRAN_DELETED,
_FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS
from {{  source('snowflake_db_web_schema', 'item_views')}}