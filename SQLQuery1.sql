-- STEP 1: Create a filtered dataset with a valid death indicator
WITH cleaned_data AS (
    SELECT *,
           CASE 
               WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 
               ELSE 0 
           END AS IS_DEAD
    FROM covid_patients
)

-- Follow CTE with a SELECT statement
SELECT TOP 10 * FROM cleaned_data;



--1. How many total records and deaths are there?
SELECT 
    COUNT(*) AS total_patients,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS total_deaths,
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4) AS mortality_rate
FROM covid_patients;

--2. Mortality by Sex (Gender)
SELECT 
    CASE SEX 
        WHEN 1 THEN 'Male'
        WHEN 2 THEN 'Female'
        ELSE 'Unknown'
    END AS gender,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths,
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4) AS death_rate
FROM covid_patients
GROUP BY SEX;


--3. Deaths by Age Group

SELECT 
    CASE 
        WHEN AGE BETWEEN 0 AND 17 THEN '0-17'
        WHEN AGE BETWEEN 18 AND 44 THEN '18-44'
        WHEN AGE BETWEEN 45 AND 64 THEN '45-64'
        WHEN AGE >= 65 THEN '65+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths
FROM covid_patients
GROUP BY 
    CASE 
        WHEN AGE BETWEEN 0 AND 17 THEN '0-17'
        WHEN AGE BETWEEN 18 AND 44 THEN '18-44'
        WHEN AGE BETWEEN 45 AND 64 THEN '45-64'
        WHEN AGE >= 65 THEN '65+'
        ELSE 'Unknown'
    END
ORDER BY age_group;

--4. Top Comorbidities in Deaths
SELECT 'DIABETES' AS condition, COUNT(*) AS deaths 
FROM covid_patients WHERE DIABETES = 1 AND DATE_DIED NOT IN ('9999-99-99', '97')
UNION
SELECT 'OBESITY', COUNT(*) FROM covid_patients WHERE OBESITY = 1 AND DATE_DIED NOT IN ('9999-99-99', '97')
UNION
SELECT 'COPD', COUNT(*) FROM covid_patients WHERE COPD = 1 AND DATE_DIED NOT IN ('9999-99-99', '97')
UNION
SELECT 'ASTHMA', COUNT(*) FROM covid_patients WHERE ASTHMA = 1 AND DATE_DIED NOT IN ('9999-99-99', '97')
ORDER BY deaths DESC;

-- ICU and Mortality
SELECT 
    ICU,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths
FROM covid_patients
GROUP BY ICU;



--6. Mortality by Comorbidity (with rate)
SELECT 
    'DIABETES' AS condition,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths,
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4) AS death_rate
FROM covid_patients
WHERE DIABETES = 1

UNION ALL

SELECT 
    'OBESITY',
    COUNT(*),
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4)
FROM covid_patients
WHERE OBESITY = 1

UNION ALL

SELECT 
    'COPD',
    COUNT(*),
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4)
FROM covid_patients
WHERE COPD = 1

UNION ALL

SELECT 
    'ASTHMA',
    COUNT(*),
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4)
FROM covid_patients
WHERE ASTHMA = 1

UNION ALL

SELECT 
    'RENAL_CHRONIC',
    COUNT(*),
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4)
FROM covid_patients
WHERE RENAL_CHRONIC = 1

UNION ALL

SELECT 
    'CARDIOVASCULAR',
    COUNT(*),
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 4)
FROM covid_patients
WHERE CARDIOVASCULAR = 1

ORDER BY death_rate DESC;


--7. Intubation vs Mortality

SELECT 
    INTUBED,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths
FROM covid_patients
GROUP BY INTUBED;



--9. Classification Summary

SELECT 
    CLASIFFICATION_FINAL,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS deaths
FROM covid_patients
GROUP BY CLASIFFICATION_FINAL
ORDER BY CLASIFFICATION_FINAL;
