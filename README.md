# Marketing Campaign Analysis

## Introduction

This project focuses on analysing a marketing campaign dataset to understand customer behaviour, 
campaign performance, and factors influencing customer acquisition. The dataset contains information 
regarding customer demographics, purchasing habits, product spend, and responses to multiple 
marketing campaigns. The aim is to conduct exploratory data analysis and hypothesis testing to 
uncover actionable insights that can improve future marketing strategies.

## Objectives

1. Clean and preprocess the raw marketing campaign dataset for analysis
2. Perform exploratory data analysis (EDA) to understand customer demographics and behaviour
3. Analyse product spend patterns across different customer segments
4. Evaluate campaign response rates by country, age group, and family structure
5. Conduct hypothesis testing to identify statistically significant differences between customer groups
6. Communicate findings through clear data visualisations

## Tools & Libraries

| Tool | Purpose |
|---|---|
| Python | Core programming language |
| Pandas | Data cleaning and manipulation |
| NumPy | Numerical operations and feature engineering |
| Matplotlib | Data visualisation |
| Seaborn | Statistical visualisation |
| SciPy | Hypothesis testing (T-test, Pearson correlation) |
| Jupyter Notebook | Development environment |

## Dataset Description

The dataset follows the 4 P's of marketing framework:

| Category | Columns | Description |
|---|---|---|
| People | year_birth, education, marital_status, income, kidhome, teenhome | Customer demographic information |
| Product | mnt_wines, mnt_fruits, mnt_meat_products, mnt_fish_products, mnt_sweet_products, mnt_gold_prods | Spend on each product category |
| Place | num_web_purchases, num_catalog_purchases, num_store_purchases, num_web_visits_month | Purchase channel information |
| Promotion | accepted_cmp1–5, response, complain | Campaign responses and outcomes |

## Methodology

### 1. Data Loading
- Loaded the raw CSV dataset into a Pandas DataFrame
- Normalised column names — stripped whitespace, converted to lowercase, replaced spaces with underscores

### 2. Data Cleaning
- Handled missing values in the `income` column by imputing with group mean (grouped by education and marital status)
- Converted `dt_customer` column to datetime format for date-based analysis
- Standardised categorical columns — `education` and `marital_status` stripped and title-cased
- Cleaned `income` column by removing currency symbols ($, commas) and converting to float

### 3. Outlier Removal
- Applied IQR method on the `income` column
- Removed records where income fell below Q1 − 1.5×IQR or above Q3 + 1.5×IQR

### 4. Feature Engineering
- Created `age` column — derived from `year_birth` using current year
- Created `total_kids` — sum of `kidhome` and `teenhome`
- Created `total_spend` — sum of all 6 product spend columns
- Created `total_purchases` — sum of web, catalog, and store purchases
- Created `has_children` — binary flag (1 if total_kids > 0, else 0)

### 5. Encoding
- Applied ordinal encoding to `education` column (Basic → 2N Cycle → Graduation → Master → PhD)
- Applied one-hot encoding to `marital_status` and `country` columns using pd.get_dummies()

### 6. Visualisations
- Age Distribution — histogram of customer age
- Income Boxplot — distribution of customer income
- Correlation Heatmap — numeric feature correlations
- Age vs Store Purchases — boxplot by number of store purchases
- Average Spend by Product — bar chart of mean spend per product category
- Age vs Campaign Response — boxplot comparing age across response groups
- Campaign Response by Country — bar chart of responses per country
- Children vs Spending — boxplot of total spend by number of children
- Complaints by Education — grouped bar chart of complaints by education level

### 7. Hypothesis Testing
- **T-test (Web Purchases with/without children):** Tested whether having children significantly affects web purchase behaviour
- **Pearson Correlation (Web vs Store Purchases):** Tested the relationship between web and store purchase frequency
- **T-test (US vs Non-US customers):** Tested whether US customers have significantly different total purchase volumes

## Results

- Wines and meat products are the highest spend categories — average spend of ~$300 and ~$150 respectively
- Customers aged 35–55 show the highest store purchase frequency
- Campaign response rates are highest in Spain (country_SP) compared to other countries
- Customers with children spend significantly less overall (p < 0.05 — statistically significant)
- T-test confirms web purchases are significantly different between customers with and without children (p = 0.0006)
- No strong correlation found between web and store purchases (Pearson r = 0.49, p = 7.04e-141)
- Graduation-level educated customers account for the highest volume of complaints (complain = 1)
- Income is positively correlated with total spend — higher income customers spend more across all product categories

## Project Structure

```
marketing-campaign-analysis/
│
├── data/
│   └── marketing_data.csv               # Raw dataset
│
├── notebook/
│   └── marketing_campaign_analysis.ipynb  # Full Jupyter Notebook
│
├── screenshots/
│   ├── age_distribution.png
│   ├── income_boxplot.png
│   ├── correlation_heatmap.png
│   ├── age_vs_store_purchases.png
│   ├── avg_spend_by_product.png
│   ├── age_vs_campaign_response.png
│   ├── campaign_response_by_country.png
│   ├── children_vs_spending.png
│   └── complaints_by_education.png
│
└── README.md
```


**Srinidhi Yegnisettipalli**  
Data Analyst | Python • SQL • Power BI  
[LinkedIn](#) | [GitHub](#)
