-- fact_session (one row per session, summarizing its events)
WITH s_ranking AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY Session_ID ORDER BY SESSION_AT_TS DESC) as session_row_n
    from {{ ref('base_snowflake_db_web_schema__sessions') }}
),

pages AS (
    SELECT SESSION_ID, 
           ARRAY_AGG(DISTINCT PAGE_NAME) AS PAGE_NAME_ARRAY, 
           COUNT(VIEW_AT_TS) AS PAGE_VIEW_AMOUNT
    FROM {{ ref('base_snowflake_db_web_schema__page_views') }}
    GROUP BY SESSION_ID
),

items AS (
    select session_id,
           COUNT(ITEM_VIEW_AT_TS) AS TOTAL_ITEM_VIEW_AMOUNT_PER_SESSION,
           ARRAY_AGG(DISTINCT ITEM_NAME) AS ITEM_NAME_ARRAY_PER_SESSION,
           sum(ADD_TO_CART_QUANTITY) AS TOTAL_ADD_TO_CART_QUANTITY_PER_SESSION,
           sum(REMOVE_FROM_CART_QUANTITY) AS TOTAL_REMOVE_FROM_CART_QUANTITY_PER_SESSION
    from {{ ref('base_snowflake_db_web_schema__item_views') }}
    group by session_id
),

orders AS (
    SELECT session_id, count(order_id) AS ORDER_AMOUNT,
    from (select *,
                 ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY ORDER_AT_TS DESC) as order_row_n
          FROM {{ ref('base_snowflake_db_web_schema__orders') }}) 
    where order_row_n=1
    group by session_id
)

select 
    S.SESSION_ID,
    S.CLIENT_ID,
    O.ORDER_AMOUNT,
    S.SESSION_AT_TS,
    P.PAGE_VIEW_AMOUNT,
    P.PAGE_NAME_ARRAY,
    I.TOTAL_ADD_TO_CART_QUANTITY_PER_SESSION,
    I.TOTAL_REMOVE_FROM_CART_QUANTITY_PER_SESSION,
    I.ITEM_NAME_ARRAY_PER_SESSION,
    I.TOTAL_ITEM_VIEW_AMOUNT_PER_SESSION
from s_ranking S
left join pages P
on S.session_id = P.session_id
left join orders O
on S.session_id = O.session_id
left join items I
on S.session_id = I.session_id
WHERE session_row_n = 1
