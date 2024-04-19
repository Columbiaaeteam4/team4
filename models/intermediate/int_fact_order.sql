-- fact_order (one row per order, summarizing its details)
WITH ranking AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY ORDER_AT_TS DESC) as row_n
    FROM {{ ref('base_snowflake_db_web_schema__orders') }} 
)

SELECT 
O.order_id as order_id,
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
FROM ranking O
left join {{ ref('base_googledrive__returns') }} R
on O.order_id = R.order_id
WHERE row_n = 1