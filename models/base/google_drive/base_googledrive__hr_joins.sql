-- google_drive: hr_joins
select 
_FILE,
_LINE,
_modified as _modified_TS,
_FIVETRAN_SYNCED as _fivetran_synced_TS,
CAST(EMPLOYEE_ID AS VARCHAR) AS EMPLOYEE_ID,
TO_DATE(REPLACE(HIRE_DATE, 'day  ', ''), 'YYYY-MM-DD') AS HIRE_DATE,
NAME,
CITY,
ADDRESS,
TITLE,
ANNUAL_SALARY
from {{  source('google_drive', 'hr_joins')}}
