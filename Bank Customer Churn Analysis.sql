
-- 𝐕𝐢𝐞𝐰𝐢𝐧𝐠 𝐭𝐡𝐞 𝐛𝐚𝐬𝐢𝐜 𝐬𝐭𝐚𝐭𝐢𝐬𝐭𝐢𝐜𝐬 𝐨𝐟 𝐭𝐡𝐞 𝐝𝐚𝐭𝐚𝐬𝐞𝐭 𝐭𝐨 𝐠𝐞𝐭 𝐚 𝐬𝐞𝐧𝐬𝐞 𝐨𝐟 𝐝𝐢𝐬𝐭𝐫𝐢𝐛𝐮𝐭𝐢𝐨𝐧.

SELECT COUNT(*) AS total_records,
       AVG(age) AS average_age,
       MIN(age) AS min_age,
       MAX(age) AS max_age,
       AVG(balance) AS average_balance,
       AVG(estimated_salary) AS average_salary
FROM dbo.[Bank Customer Churn Prediction];

-- 𝐏𝐞𝐫𝐜𝐞𝐧𝐭𝐚𝐠𝐞 𝐨𝐟 𝐜𝐮𝐬𝐭𝐨𝐦𝐞𝐫𝐬 𝐰𝐡𝐨 𝐡𝐚𝐯𝐞 𝐥𝐞𝐟𝐭 𝐭𝐡𝐞 𝐛𝐚𝐧𝐤

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

-- 𝟐𝟎.𝟑𝟕% 𝐂𝐡𝐮𝐫𝐧

-- 𝐂𝐨𝐦𝐩𝐚𝐫𝐢𝐧𝐠 𝐂𝐡𝐮𝐫𝐧 𝐛𝐲 𝐠𝐞𝐧𝐝𝐞𝐫 𝐚𝐧𝐝 𝐜𝐨𝐮𝐧𝐭𝐫𝐲

SELECT gender, country,
       SUM(CAST(churn AS INT)) AS churned_customers,
       COUNT(*) AS total_customers,
       (SUM(CAST(churn AS INT)) * 100.0 / COUNT(*)) AS churn_rate_percentage
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY gender, country;

-- 𝐂𝐡𝐮𝐫𝐧 𝐫𝐚𝐭𝐞𝐬 𝐛𝐚𝐬𝐞𝐝 𝐨𝐧 𝐚𝐠𝐞

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

-- 𝐂𝐫𝐞𝐝𝐢𝐭 𝐬𝐜𝐨𝐫𝐞 𝐯𝐬 𝐂𝐡𝐮𝐫𝐧

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


-- 𝐂𝐡𝐮𝐫𝐧 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬 𝐛𝐲 𝐄𝐬𝐭𝐢𝐦𝐚𝐭𝐞𝐝 𝐒𝐚𝐥𝐚𝐫𝐲

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


-- 𝐂𝐡𝐮𝐫𝐧 𝐀𝐧𝐚𝐥𝐲𝐬𝐢𝐬 𝐛𝐲 𝐁𝐚𝐥𝐚𝐧𝐜𝐞

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











