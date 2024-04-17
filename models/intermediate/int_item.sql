-- dim_item (one row per item sold on the website)
select 
    ITEM_NAME,
    ITEM_VIEW_AT_TS,
    PRICE_PER_UNIT,
    ADD_TO_CART_QUANTITY,
    REMOVE_FROM_CART_QUANTITY
from {{ ref('base_snowflake_db_web_schema__orders') }} O
inner join {{ ref('base_snowflake_db_web_schema__item_views') }} I
on O.session_id = I.session_id
order by 1