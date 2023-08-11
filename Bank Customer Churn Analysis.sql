
--Viewing the basic statistics of the dataset to get a sense of distribution. 

SELECT COUNT(*) AS total_records,
       AVG(age) AS average_age,
       MIN(age) AS min_age,
       MAX(age) AS max_age,
       AVG(balance) AS average_balance,
       AVG(estimated_salary) AS average_salary
FROM dbo.[Bank Customer Churn Prediction];

-- Percentage of customers who have left the bank

SELECT churn, COUNT(*) AS count
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY churn;


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Bank Customer Churn Prediction'
  AND COLUMN_NAME = 'churn';


SELECT SUM(CAST(churn AS INT)) AS churned_customers,
       COUNT(*) AS total_customers,
       (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction];

-- 20.37% Churn

-- Comparing Churn by gender and country

SELECT gender, country,
       SUM(CAST(churn AS INT)) AS churned_customers,
       COUNT(*) AS total_customers,
       (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY gender, country;

-- Churn rates based on age

SELECT CASE
           WHEN age < 18 THEN 'Under 18'
           WHEN age BETWEEN 18 AND 30 THEN '18-30'
           WHEN age BETWEEN 31 AND 45 THEN '31-45'
           WHEN age BETWEEN 46 AND 60 THEN '46-60'
           ELSE 'Over 60'
       END AS age_group,
       SUM(CAST(churn AS INT)) AS churned_customers,
       COUNT(*) AS total_customers,
       (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY CASE
             WHEN age < 18 THEN 'Under 18'
             WHEN age BETWEEN 18 AND 30 THEN '18-30'
             WHEN age BETWEEN 31 AND 45 THEN '31-45'
             WHEN age BETWEEN 46 AND 60 THEN '46-60'
             ELSE 'Over 60'
         END
ORDER BY CASE
             WHEN age < 18 THEN 'Under 18'
             WHEN age BETWEEN 18 AND 30 THEN '18-30'
             WHEN age BETWEEN 31 AND 45 THEN '31-45'
             WHEN age BETWEEN 46 AND 60 THEN '46-60'
             ELSE 'Over 60'
         END;

-- Credit score vs Churn

SELECT CASE
           WHEN credit_score < 500 THEN 'Poor'
           WHEN credit_score BETWEEN 500 AND 700 THEN 'Average'
           ELSE 'Good'
       END AS credit_score_range,
       SUM(CAST(churn AS INT)) AS churned_customers,
       COUNT(*) AS total_customers,
       (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY CASE
             WHEN credit_score < 500 THEN 'Poor'
             WHEN credit_score BETWEEN 500 AND 700 THEN 'Average'
             ELSE 'Good'
         END;


-- Churn Analysis by Estimated Salary
SELECT
    CASE
        WHEN estimated_salary < 50000 THEN 'Low'
        WHEN estimated_salary BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_range,
    SUM(CAST(churn AS INT)) AS churned_customers,
    COUNT(*) AS total_customers,
    (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY
    CASE
        WHEN estimated_salary < 50000 THEN 'Low'
        WHEN estimated_salary BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END;


-- Churn Analysis by Balance

SELECT
    CASE
        WHEN balance < 1000 THEN 'Low'
        WHEN balance BETWEEN 1000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS balance_range,
    SUM(CAST(churn AS INT)) AS churned_customers,
    COUNT(*) AS total_customers,
    (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY
    CASE
        WHEN balance < 1000 THEN 'Low'
        WHEN balance BETWEEN 1000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END;











