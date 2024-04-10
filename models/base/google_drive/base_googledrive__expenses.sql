-- google_drive: expenses
select 
_FILE,
_LINE,
_modified as _modified_TS,
_fivetran_synced as _fivetran_synced_TS,
DATE,
EXPENSE_TYPE,
CAST(REPLACE(EXPENSE_AMOUNT, '$', '') AS DECIMAL(10, 2)) AS EXPENSE_AMOUNT
from {{  source('google_drive', 'expenses')}}