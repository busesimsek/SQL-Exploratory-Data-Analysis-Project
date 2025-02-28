-- ==============================================
-- Project Title: Exploratory Data Analysis (EDA) of 2022 Layoffs
-- Author: Buse Şimşek
-- Date: 12 February 2025
-- Description: This project conducts exploratory data analysis (EDA) to uncover patterns, trends, and insights within the dataset.
-- Tools: MySQL
-- ==============================================

/*
Details:
- Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
- The dataset was cleaned in my previous project:
  - Check: https://github.com/busesimsek/SQL-Data-Cleaning-Project

- Objectives for this Exploratory Data Analysis (EDA) Project:
  1. Analyze the date range of layoffs and trends over time.
  2. Identify the largest layoffs by company, industry, country, and stage.
  3. Explore patterns in layoffs by year, month, and rolling totals.
  4. Determine which companies laid off their entire workforce.
  5. Rank companies based on layoffs per year and identify the top 5 per year.

- Outputs:
  - Insights into layoff trends across different sectors and timeframes.
  - A ranking of companies with the most layoffs by year.
  - Monthly and yearly layoff progression using rolling sums.
  - A dataset prepared for further visualization and modeling.
*/

-- With our dataset prepped and objectives set, it's time to uncover key insights. Let's analyze! 📊

SELECT *
FROM layoffs_staging2; -- The dataset contains 3,248 rows. Let's explore!

-- First, let's determine the date range covered in our dataset.
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;
-- The dataset includes layoffs from March 11, 2020, to November 22, 2024.
-- This period starts right after the COVID-19 lockdowns and extends up to the date the data was retrieved.

-- Let's identify the largest single layoff event recorded.
SELECT MAX(total_laid_off)
FROM layoffs_staging2;
-- The highest number of employees laid off in one instance is 15,000.

-- Now, let's check the maximum percentage of workforce layoffs.
SELECT MAX(percentage_laid_off)
FROM layoffs_staging2;
-- The maximum percentage is 1, meaning some companies laid off their entire workforce.

-- Let's identify companies that laid off their entire workforce.
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
-- We have 288 rows returned. "Katerra" ranks highest with 2,434 employees laid off.

-- Now, let's analyze total layoffs per company.
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
-- The query returns 2,350 unique companies. Amazon leads with 27,840 total layoffs.

/*
Top 10 companies by total layoffs:
1. Amazon - 27,840
2. Meta - 21,000
3. Intel - 16,057
4. Microsoft - 14,708
5. Tesla - 14,500
6. Cisco - 14,300
7. Google - 13,472
8. Dell - 12,650
9. Salesforce - 11,140
10. SAP - 11,000
*/

-- Now, let's analyze total layoffs by industry.
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- The query returns 31 unique industries. Retail leads with 71,703 total layoffs.

/*
Top 5 industries by total layoffs:
1. Retail - 71,703
2. Consumer - 71,046
3. Other - 61,912
4. Transportation - 60,548
5. Hardware - 54,870
*/

-- Moving on to layoffs by country.
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- The query returns 60 unique countries. The US dominates with 455,331 total layoffs.

/*
Top 5 countries by total layoffs:
1. United States - 455,331
2. India - 56,469
3. Germany - 28,572
4. United Kingdom - 20,090
5. Netherlands - 19,005
*/
-- The US stands out significantly compared to other countries!

-- Now, let's analyze total layoffs by date to identify peak layoff periods.
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 2 DESC;
-- The query returns 882 unique dates.

/*  
Top 5 dates with the highest layoffs:
1. 2023-01-04 - 16,171
2. 2024-08-01 - 15,180
3. 2022-11-16 - 14,926
4. 2023-01-20 - 14,682
5. 2024-04-15 - 14,000
*/

-- Now, let's check total layoffs by year to uncover trends over time.
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

/*
Total layoffs by year:
2024 - 149,006
2023 - 264,220
2022 - 164,319
2021 - 15,823
2020 - 80,998
*/

-- 2023 recorded the highest total layoffs.
-- Also, the significant difference between 2020 and 2021 suggests that the 2020 layoffs were likely influenced by COVID-19 lockdowns!

-- Now, let's analyze total layoffs by company stage to see which stage had the most layoffs.
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
-- Companies in the "Post-IPO" stage had the highest total layoffs, with 375,102.

-- Let's track layoffs by month for each year to observe patterns over time.
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 1;
-- This will help us visualize month-to-month layoff trends across multiple years.

-- Now, let's analyze the progression of layoffs over time using a rolling sum.
WITH Rolling_Total AS
(
    SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS sum_of_total
    FROM layoffs_staging2
    GROUP BY `MONTH`
    ORDER BY 1
)
SELECT `MONTH`, sum_of_total, SUM(sum_of_total) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
-- This query provides the total layoffs per month and a cumulative rolling sum to observe long-term trends.

-- Let's examine layoffs by company per year to see which companies had the highest layoffs annually.
SELECT company, YEAR(`DATE`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`DATE`)
ORDER BY 1;
-- This breakdown will help us track layoff trends for each company across different years.

-- Now, let's rank companies by the highest total layoffs in a given year.  
SELECT company, YEAR(`DATE`), SUM(total_laid_off)  
FROM layoffs_staging2  
GROUP BY company, YEAR(`DATE`)  
ORDER BY 3 DESC;  
-- We observe that major corporations like Amazon, Intel, Tesla, Google, and Microsoft are among the top in layoffs.  

-- Let's determine which companies had the highest layoffs each year by ranking them.
WITH Company_Year (company, years, total_laid_off) AS
(
    SELECT company, YEAR(`DATE`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`DATE`)
)
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
ORDER BY years, ranking;
-- This query assigns a rank to each company based on layoffs per year, helping us identify the top companies with the most layoffs annually.

/*
Key findings:
- 2020: Uber had the highest layoffs.
- 2021: ByteDance led layoffs.
- 2022: Meta had the most layoffs.
- 2023: Amazon ranked first.
- 2024: Intel topped the layoffs.
*/

-- Let's filter the top 5 companies with the highest layoffs per year.
WITH Company_Year (company, years, total_laid_off) AS
(
    SELECT company, YEAR(`DATE`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`DATE`)
),
Company_Year_Rank AS
(
    -- Assigning a ranking to each company based on layoffs per year.
    SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM Company_Year
)
-- Filtering to keep only the top 5 companies for each year.
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5;

-- Now, we have the top 5 companies with the highest layoffs for each year.

/*
==============================================
Conclusion & Key Insights:
==============================================

1. Layoff Trends Over Time:
   - The dataset spans from March 11, 2020, to November 22, 2024.
   - 2023 recorded the highest layoffs, followed by 2022 and 2024.
   - The highest single-day layoffs occurred on January 4, 2023.

2. Industries with the Most Layoffs:
   - Retail, Consumer, and Transportation industries had the highest layoffs.
   - The "Other" category also had significant layoffs, which may require further breakdown.

3. Countries with the Most Layoffs:
   - The United States leads significantly with 455,331 total layoffs.
   - India, Germany, the UK, and the Netherlands follow, but with much lower numbers.

4. Companies with the Most Layoffs:
   - Amazon had the highest total layoffs (27,840), followed by Meta and Intel.
   - Some companies (e.g., Katerra) laid off their entire workforce.

5. Layoffs by Company Stage:
   - Companies in the "Post-IPO" stage had the most layoffs, indicating that even established companies faced major reductions.

6. Ranking of Companies by Year:
   - The top companies by layoffs changed yearly:
     - 2020: Uber
     - 2021: ByteDance
     - 2022: Meta
     - 2023: Amazon
     - 2024: Intel

7. Rolling Layoff Trends:
   - A rolling sum analysis shows layoffs were highest in early 2023 and mid-2024.
   - Layoff spikes correlate with industry downturns and economic events.

==============================================
Future Steps:
==============================================

- Conduct further analysis by adding external economic indicators to understand correlations.
- Use visualization tools (e.g., Tableau, Power BI) to create dynamic dashboards.
- Explore additional factors such as company size, revenue impact, and hiring trends.

This SQL analysis provides a foundational understanding of layoffs, but further statistical and predictive modeling could deepen insights.
*/