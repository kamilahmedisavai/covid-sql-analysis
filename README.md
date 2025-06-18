# covid-sql-analysis
# 🦠 COVID-19 SQL Analysis Project

## 📊 Overview

This project performs exploratory data analysis (EDA) on a COVID-19 patient dataset using SQL. It answers critical questions about mortality, comorbidities, age/gender distribution, ICU and intubation effects, and more. The goal is to derive actionable insights from real-world healthcare data using SQL skills.

---

## 🔍 Key Questions Answered

- What is the overall mortality rate?
- How does mortality differ by gender and age group?
- What comorbidities are most associated with death?
- How do ICU admission and intubation affect outcomes?
- What trends exist by classification type?

---

## 🧠 Insights Summary

- **Elderly patients (65+)** had the highest mortality count.
- **Males** had slightly higher mortality rates than females.
- **Chronic kidney disease** and **cardiovascular conditions** showed the highest comorbidity-linked mortality rates.
- **ICU and intubated patients** had significantly higher death counts, suggesting disease severity correlation.

---

## 🛠 Tools & Skills Used

- **SQL Server / PostgreSQL**
- Conditional Aggregation (CASE WHEN)
- Common Table Expressions (CTEs)
- GROUP BY and ORDER BY
- Data Cleaning and Filtering
- Healthcare Data Analysis

---

## 📁 Files in This Repository

| File                          | Description                                         |
|-------------------------------|-----------------------------------------------------|
| `covid_analysis_queries.sql`  | SQL script containing all analytical queries        |
| `README.md`                   | Project description, questions, and insights        |

---

## 📈 Sample Queries

Some queries included in the project:

- Total cases and deaths:
  ```sql
  SELECT COUNT(*) AS total_patients,
         SUM(CASE WHEN DATE_DIED NOT IN ('9999-99-99', '97') THEN 1 ELSE 0 END) AS total_deaths
  FROM covid_patients;
