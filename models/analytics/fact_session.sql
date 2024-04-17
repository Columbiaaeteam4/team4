select 
    SESSION_ID,
    CLIENT_ID,
    ORDER_ID,
    CASE WHEN ORDER_ID IS NOT NULL THEN TRUE ELSE FALSE END as IS_ORDERED,
    CASE WHEN CLIENT_ID IS NOT NULL THEN TRUE ELSE FALSE END as IS_EXECUTED,
    OS,
    IP,
    PAGE_NAME,
    SHIPPING_ADDRESS,
    PAYMENT_INFO,
    STATE,
    PAYMENT_METHOD,
    PHONE,
    ITEM_NAME,
    CASE WHEN ITEM_VIEW_AT_TS IS NOT NULL THEN TRUE ELSE FALSE END as IS_VIEWED,
from {{ ref('int_sessions') }}