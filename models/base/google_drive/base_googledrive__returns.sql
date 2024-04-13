-- google_drive: returns
select 
_FILE,
_LINE,
_modified as _modified_TS,
_FIVETRAN_SYNCED as _fivetran_synced_TS,
RETURNED_AT,
ORDER_ID,
CAST(IS_REFUNDED AS BOOLEAN) AS IS_REFUNDED
from {{  source('google_drive', 'returns')}}
