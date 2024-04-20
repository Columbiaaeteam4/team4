-- daily_finances (summarizing revenue and costs at the daily level)
WITH daily_metrics AS (
    SELECT 
        DATE(ORDER_AT_TS) AS DATE,
        SUM(REVENUE_PER_ORDER) AS REVENUE,
        SUM(SHIPPING_COST) AS SHIPPING_COST,
        SUM(REVENUE_PER_ORDER * TAX_RATE) AS TAX_COST
    FROM {{ref('int_fact_order')}}
    GROUP BY 1
),

daily_expense as (
    select date, sum(expense_amount) as EXPENSE_AMOUNT
    from {{ref('base_googledrive__expenses')}}
    group by date
)

SELECT 
    COALESCE(E.DATE, D.DATE) AS DATE,
    COALESCE(REVENUE, 0) AS REVENUE, 
    COALESCE(SHIPPING_COST, 0) AS SHIPPING_COST,
    COALESCE(TAX_COST, 0) AS TAX_COST,
    COALESCE(EXPENSE_AMOUNT, 0) AS EXPENSE,
    COALESCE(SHIPPING_COST, 0) + COALESCE(TAX_COST, 0) + COALESCE(EXPENSE_AMOUNT, 0) AS TOTAL_COST,
    COALESCE(REVENUE, 0) - (COALESCE(SHIPPING_COST, 0) + COALESCE(TAX_COST, 0) + COALESCE(EXPENSE_AMOUNT, 0)) AS PROFIT
FROM daily_expense E
LEFT JOIN daily_metrics D 
ON E.DATE = D.DATE