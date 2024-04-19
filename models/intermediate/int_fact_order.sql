-- fact_order (one row per order, summarizing its details)
WITH o_ranking AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY ORDER_AT_TS DESC) as order_row_n
    FROM {{ ref('base_snowflake_db_web_schema__orders') }} 
),

r_ranking AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY RETURNED_AT DESC) as return_row_n
    from {{ ref('base_googledrive__returns') }} 
),

items AS (
    select session_id,
           ARRAY_AGG(DISTINCT ITEM_NAME) AS ITEM_NAME_ARRAY,
           sum((ADD_TO_CART_QUANTITY - REMOVE_FROM_CART_QUANTITY) * PRICE_PER_UNIT) AS REVENUE
    from {{ ref('base_snowflake_db_web_schema__item_views') }}
    group by session_id
)

SELECT 
O.order_id,
O.session_id,
I.ITEM_NAME_ARRAY,
I.REVENUE,
client_name,
SHIPPING_ADDRESS,
TAX_RATE,
PAYMENT_INFO,
ORDER_AT_TS,
STATE,
SHIPPING_COST,
payment_method,
phone,
returned_at,
is_refunded
FROM o_ranking O
left join r_ranking R
on O.order_id = R.order_id
left join items I
on O.session_id=I.session_id
WHERE order_row_n = 1 and return_row_n=1

