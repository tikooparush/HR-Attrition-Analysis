USE hr_analysis;
SELECT COUNT(*) FROM `wa_fn-usec_-hr-employee-attrition`;

-- overall attrition rate
SELECT Attrition,
COUNT(*) AS total,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `wa_fn-usec_-hr-employee-attrition`), 2) AS percentage
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Attrition;

-- Attrition rate by department
SELECT Department, COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Department
ORDER BY attrition_rate DESC;

-- Attrition by overtime
SELECT OverTime, COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY OverTime
ORDER BY attrition_rate DESC;

-- Average Monthly Income by Job Role
SELECT 
JobRole,
ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY JobRole
ORDER BY avg_monthly_income DESC;

-- Attrition by Age Group
SELECT 
    CASE
        WHEN ï»¿Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN ï»¿Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN ï»¿Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN ï»¿Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN ï»¿Age BETWEEN 56 AND 65 THEN '56-65'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY age_group
ORDER BY attrition_rate DESC;

DESCRIBE `wa_fn-usec_-hr-employee-attrition`;