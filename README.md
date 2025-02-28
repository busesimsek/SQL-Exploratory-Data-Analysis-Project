# Exploratory Data Analysis (EDA) of Layoffs Data Using MySQL

## Table of Contents  
- [Project Overview](#project-overview)  
- [Dataset](#dataset)  
- [Key Findings](#key-findings)  
  - [Date Range of Layoff Data](#date-range-of-layoff-data)  
  - [Largest Layoffs](#largest-layoffs)  
  - [Companies with Entire Workforce Laid Off](#companies-with-entire-workforce-laid-off)  
  - [Companies with the Highest Total Layoffs](#companies-with-the-highest-total-layoffs)  
  - [Industries with the Highest Total Layoffs](#industries-with-the-highest-total-layoffs)  
  - [Countries with the Highest Total Layoffs](#countries-with-the-highest-total-layoffs)  
  - [Dates with the Highest Total Layoffs](#dates-with-the-highest-total-layoffs)  
  - [Total Layoffs by Year](#total-layoffs-by-year)  
  - [Layoffs by Company Stage](#layoffs-by-company-stage)  
  - [Top Layoff Companies by Year](#top-layoff-companies-by-year)  
- [Methodology](#methodology)  
- [Conclusion](#conclusion)  
- [Future Work](#future-work)  
- [How to Use This Project](#how-to-use-this-project)  


## Project Overview
This project performs an exploratory data analysis (EDA) on a dataset containing layoff information from various companies using MySQL. The dataset includes details on layoffs across different industries, countries, and years, starting from March 11, 2020, through November 22, 2024. The purpose of this analysis is to uncover trends, patterns, and insights related to layoffs over time.

## Dataset
The dataset used in this project is named `layoffs_staging2`, which contains information about layoffs such as:
- Company name
- Industry
- Country
- Date of layoff
- Number of employees laid off (`total_laid_off`)
- Percentage of employees laid off (`percentage_laid_off`)
- Company stage (e.g., startup, post-IPO, etc.)

## Key Findings

### Date Range of Layoff Data
- The dataset includes layoffs from **March 11, 2020, to November 22, 2024**.

### Largest Layoffs
- The maximum number of employees laid off in one instance was **15,000**.
- The maximum percentage laid off was **100%**, meaning some companies completely shut down.

### Companies with Entire Workforce Laid Off
- **288** companies had a 100% layoff rate.
- The company with the largest total layoff in this category was **Katerra (2,434 employees laid off)**.

### Companies with the Highest Total Layoffs
| Company     | Total Laid Off |
|------------|---------------|
| Amazon     | 27,840        |
| Meta       | 21,000        |
| Intel      | 16,057        |
| Microsoft  | 14,708        |
| Tesla      | 14,500        |
| Cisco      | 14,300        |
| Google     | 13,472        |
| Dell       | 12,650        |
| Salesforce | 11,140        |
| SAP        | 11,000        |

### Industries with the Highest Total Layoffs
| Industry       | Total Laid Off |
|---------------|---------------|
| Retail        | 71,703        |
| Consumer      | 71,046        |
| Other         | 61,912        |
| Transportation| 60,548        |
| Hardware      | 54,870        |

### Countries with the Highest Total Layoffs
| Country         | Total Laid Off |
|---------------|---------------|
| United States  | 455,331       |
| India         | 56,469        |
| Germany       | 28,572        |
| United Kingdom| 20,090        |
| Netherlands   | 19,005        |

### Dates with the Highest Total Layoffs
| Date        | Total Laid Off |
|------------|---------------|
| 2023-01-04 | 16,171        |
| 2024-08-01 | 15,180        |
| 2022-11-16 | 14,926        |
| 2023-01-20 | 14,682        |
| 2024-04-15 | 14,000        |

### Total Layoffs by Year
| Year | Total Laid Off |
|------|---------------|
| 2024 | 149,006       |
| 2023 | 264,220       |
| 2022 | 164,319       |
| 2021 | 15,823        |
| 2020 | 80,998        |

- **2023 saw the highest number of layoffs overall.**
- The **high layoff numbers in 2020** may be due to COVID-19 lockdowns.

### Layoffs by Company Stage
| Stage     | Total Laid Off |
|----------|---------------|
| Post-IPO | 375,102       |

- **Post-IPO companies** had the highest total layoffs.

### Top Layoff Companies by Year
| Year | Company   | Total Laid Off |
|------|----------|---------------|
| 2020 | Uber     | *Highest*      |
| 2021 | Bytedance| *Highest*      |
| 2022 | Meta     | *Highest*      |
| 2023 | Amazon   | *Highest*      |
| 2024 | Intel    | *Highest*      |

## Methodology
This analysis was conducted using MySQL queries, without the use of data visualization tools. The queries include:
- Aggregations (SUM, MAX, MIN)
- Grouping and ordering (GROUP BY, ORDER BY)
- Window functions (DENSE_RANK for ranking companies by year)
- CTEs (Common Table Expressions) for rolling totals and rankings

## Conclusion
This EDA provides insights into layoff trends across industries, countries, and years, revealing significant events such as mass layoffs in large corporations and post-COVID-19 effects. The data suggests that layoffs peaked in **2023**, with **Amazon, Meta, and Intel** being the most affected companies.

## Future Work
- **Data Visualization:** Using Tableau or Power BI to create charts and graphs for better insights.
- **Predictive Analysis:** Applying machine learning techniques to forecast future layoffs.
- **Deeper Industry-Specific Analysis:** Investigating layoffs based on business performance.

## How to Use This Project
1. Clone the repository.
2. Load the dataset into MySQL.
3. Run the provided SQL queries to explore the dataset.
