-- dim_item (one row per item sold on the website)
select 
    ITEM_NAME,
    COUNT(ITEM_VIEW_AT_TS) AS TOTAL_VIEW_AMOUNT_PER_ITEM,
    ARRAY_AGG(DISTINCT PRICE_PER_UNIT) AS PRICE_PER_UNIT_ARRAY,
    sum(ADD_TO_CART_QUANTITY) AS TOTAL_ADD_TO_CART_QUANTITY_PER_ITEM,
    sum(REMOVE_FROM_CART_QUANTITY) AS TOTAL_REMOVE_FROM_CART_QUANTITY_PER_ITEM
from {{ ref('base_snowflake_db_web_schema__item_views') }}
group by ITEM_NAME