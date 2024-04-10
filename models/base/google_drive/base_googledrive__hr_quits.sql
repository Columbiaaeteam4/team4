select 
_FILE,
_LINE,
_modified as _modified_TS,
_FIVETRAN_SYNCED as _fivetran_synced_TS,
CAST(EMPLOYEE_ID AS VARCHAR) AS EMPLOYEE_ID,
QUIT_DATE
from {{  source('google_drive', 'hr_quits')}}
