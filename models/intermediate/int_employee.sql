-- int_employee (one row per employee)
select 
J.EMPLOYEE_ID,
NAME,
CITY,
ADDRESS,
TITLE,
HIRE_DATE,
ANNUAL_SALARY,
QUIT_DATE
from {{ref('base_googledrive__hr_joins')}} AS J
left join {{ref('base_googledrive__hr_quits')}} AS Q
on J.EMPLOYEE_ID = Q.EMPLOYEE_ID