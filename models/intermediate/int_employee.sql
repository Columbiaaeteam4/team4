<<<<<<< HEAD
<<<<<<< HEAD
select 
    J.employee_id,
    NAME,
    CITY,
    ADDRESS,
    TITLE,
    HIRE_DATE,
    ANNUAL_SALARY,
    QUIT_DATE
FROM {{ref('base_googledrive__hr_joins')}} as J
left join {{ref('base_googledrive__hr_quits')}} as Q
on J.EMPLOYEE_ID = Q.EMPLOYEE_ID
Order by 1
=======
=======
--dim_employee (one row per employee)
>>>>>>> c90ce17ee580512b69637f14be71013ca7d76b0a
select 
    J.employee_id,
    NAME,
    CITY,
    ADDRESS,
    TITLE,
    HIRE_DATE,
    ANNUAL_SALARY,
    QUIT_DATE
FROM {{ref('base_googledrive__hr_joins')}} AS J
left join {{ref('base_googledrive__hr_quits')}} AS Q
on J.EMPLOYEE_ID = Q.EMPLOYEE_ID
Order by 1
>>>>>>> 9c0015b0f72397c721e5b786c63bb241041502ec
