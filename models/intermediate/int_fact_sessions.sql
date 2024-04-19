-- fact_session (one row per session, summarizing its events)
WITH ranking AS (
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY Session_ID ORDER BY SESSION_AT_TS DESC) as row_n
from {{ ref('base_snowflake_db_web_schema__sessions') }} S
)

select 
S.SESSION_ID,
S.CLIENT_ID,
O.ORDER_ID,
S.SESSION_AT_TS,
S.OS,
S.IP,
P.VIEW_AT_TS,
P.PAGE_NAME,
O.SHIPPING_ADDRESS,
O.TAX_RATE,
O.PAYMENT_INFO,
O.ORDER_AT_TS,
O.STATE,
O.SHIPPING_COST,
O.PAYMENT_METHOD,
O.PHONE,
I.ADD_TO_CART_QUANTITY,
I.REMOVE_FROM_CART_QUANTITY,
I.ITEM_NAME,
I.ITEM_VIEW_AT_TS,
I.PRICE_PER_UNIT,
from ranking S
left join {{ ref('base_snowflake_db_web_schema__page_views') }} P
on S.session_id = P.session_id
left join {{ ref('base_snowflake_db_web_schema__orders') }} O
on S.session_id = O.session_id
left join {{ ref('base_snowflake_db_web_schema__item_views') }} I
on S.session_id = I.session_id
WHERE row_n = 1