-- DATOS PROPORCIONADOS POR LA PÁGINA DE KAGGLE
-- LINK https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries
-- drop table Data_Science_Job_Salaries;

CREATE TABLE Data_Science_Job_Salaries(
    id NUMBER,
    work_year NUMBER,
    experience_level VARCHAR2(10),
    employment_type VARCHAR2(10),
    job_title VARCHAR2(100),
    salary NUMBER,
    salary_currency VARCHAR2(10),
    salary_in_usd NUMBER,
    employee_residence VARCHAR2(10),
    remote_ratio NUMBER,
    company_location VARCHAR2(10),
    company_size VARCHAR2(10)
);

select count(*) as total_resgistros_en_tabla from Data_Science_Job_Salaries;

-- Hacer un query de la tabla Data_Science_Job_Salaries que debe mostrar los siguientes datos
-- (job_title, experience_level, work_year, employee_residence, salary_in_usd) 
-- de los salary_in_usd que esten entre 100000 y 900000 del año 2020, del país Estados Unidos (US)
-- y que el nivel de experiencia sea Entry Level (EN), agruparlos por las siguientes columnas: 
-- (experience_level, work_year, job_title,employee_residence,salary_in_usd) y ordenarlos por 
-- experience_level y salary_in_usd de forma ascendente  

SELECT job_title, experience_level, work_year, employee_residence, salary_in_usd from Data_Science_Job_Salaries
    WHERE salary_in_usd BETWEEN 100000 and 900000
    and work_year=2020 and employee_residence='US' and experience_level = 'EN'
    GROUP BY experience_level, work_year, job_title,employee_residence,salary_in_usd
    ORDER BY experience_level, salary_in_usd DESC;
    
-- Hacer un query que muestre (job_title, experience_level, work_year, salary_in_usd, company_size)
-- de la tabla Data_Science_Job_Salaries, del país Estados Unidos (US) y que el nivel de experiencia sea Entry Level (EN)
-- agruparlos por las siguientes columnas: 
-- (experience_level, work_year, salary_in_usd, job_title, company_size) y ordenarlos por 
-- work_year,company_size,experience_level,salary_in_usd de forma ascendente, el query debe aparecer el salario maximo

SELECT job_title, experience_level, work_year, max(salary_in_usd), company_size FROM Data_Science_Job_Salaries 
WHERE employee_residence='US' and experience_level = 'EN'
GROUP BY experience_level, work_year, salary_in_usd, job_title, company_size
ORDER BY work_year,company_size,experience_level,salary_in_usd ASC;

-- Hacer un query que muestre  job_title, experience_level, work_year, salario maximo y salario minimo, de la tabla Data_Science_Job_Salaries
-- del país Estados Unidos (US) y que el nivel de experiencia sea Entry Level (EN)
-- agruparlos por las siguientes columnas: 
-- experience_level, work_year, job_title 
--  y ordenarlos de forma ascendente por:
-- work_year,experience_level

SELECT job_title, experience_level, work_year, max(salary_in_usd), min(salary_in_usd) from Data_Science_Job_Salaries
    where employee_residence='US' and experience_level = 'EN'
    GROUP BY experience_level, work_year, job_title
    ORDER BY work_year,experience_level ASC;  

--Hacer un query que muestre employee_residence, work_year, salario maximo, salario minimo, y la suma de los salarios
--de la tabla Data_Science_Job_Salaries 
-- de los países Estados Unidos (US) y Japon (JP)
-- agruparlos por las siguientes columnas: 
-- work_year, y employee_residence
--  y ordenarlos de forma ascendente por:
-- work_year

SELECT employee_residence, work_year, max(salary_in_usd), min(salary_in_usd), sum(salary_in_usd) FROM Data_Science_Job_Salaries 
    WHERE employee_residence= 'US' OR employee_residence='JP' OR employee_residence='MX' OR employee_residence='FR'
    GROUP BY work_year, employee_residence
    ORDER BY work_year ASC;
    
SELECT employee_residence, work_year, max(salary_in_usd), min(salary_in_usd), sum(salary_in_usd) FROM Data_Science_Job_Salaries 
    WHERE employee_residence in ('US','JP')
    GROUP BY work_year, employee_residence
    ORDER BY work_year ASC;


SELECT job_title, employee_residence, work_year, max(salary_in_usd), min(salary_in_usd) FROM Data_Science_Job_Salaries 
    WHERE employee_residence in ('MX')
    GROUP BY work_year, employee_residence, job_title
    ORDER BY work_year ASC;
    
--Hacer un query que muestre job_title, employee_residence, work_year, salario maximo, salario minimo,
-- de la tabla Data_Science_Job_Salaries 
-- del país Estados Unidos (US),y de todos los job_title sean Data Engineer
-- agruparlos por las siguientes columnas: 
-- work_year, employee_residence, job_title
--  y ordenarlos de forma ascendente por:
-- work_year

Select job_title, employee_residence, work_year, max(salary_in_usd), min(salary_in_usd) from Data_Science_Job_Salaries 
WHERE employee_residence = 'US' AND job_title like 'Data%'
GROUP BY work_year, employee_residence, job_title
Order by work_year ASC;

-- Hacer un query que muestre experience_level, job_title, employee_residence, work_year,salario maximo, 
-- salario minimo y el promedio salarial 
-- de la tabla Data_Science_Job_Salaries 
-- del país Estados Unidos (US),y de todos los job_title sean exactamente igual a Data Engineer
-- agruparlos por las siguientes columnas: 
-- experience_level, work_year, employee_residence, job_title
--  y ordenarlos de forma ascendente por:
-- experience_level, work_year

SELECT experience_level, job_title, employee_residence, work_year, max(salary_in_usd), min(salary_in_usd), avg(salary_in_usd) 
    from Data_Science_Job_Salaries where employee_residence = 'US' AND job_title = 'Data Engineer'
    Group by experience_level, work_year, employee_residence, job_title
    Order by experience_level, work_year ASC;