Customer Shopping Behavior Analysis

Project Overview

This project analyses customer shopping behaviour using Excel, SQL and Power BI to identify purchasing patterns, customer segments, category performance and behavioural trends that can support retail decision-making.

The dataset contains 3,900 customer records across product, demographic, subscription, shipping, discount, payment and purchase-frequency attributes.

Business Objective

The analysis focuses on answering practical retail questions such as:

Which product categories generate the most revenue?

Which customer segments contribute the most value?

Do subscribers behave differently from non-subscribers?

How do discounts, shipping methods and purchase frequency relate to customer spend?

Which products and locations contribute the most revenue?

What customer groups should the business prioritise for retention and promotional activity?

Tools Used

Excel — data preparation, structured tables, helper columns, formula-based analysis, KPI summaries and charts.

SQL — data-quality checks, aggregations, segmentation, CTEs, CASE statements and window functions.

Power BI — interactive dashboard and visual business reporting.

Dataset

File: customer_shopping_behavior.csv

Key fields include:

Customer ID

Age and Gender

Item Purchased and Category

Purchase Amount

Location

Season

Review Rating

Subscription Status

Shipping Type

Discount Applied

Promo Code Used

Previous Purchases

Payment Method

Frequency of Purchases

Data Preparation

The dataset was reviewed for data types, completeness and consistency before analysis.

Total records: 3,900

Missing review ratings: 37

Missing ratings were retained as null values rather than deleting otherwise valid customer records.

Additional Excel helper fields were created for age groups, purchase-value bands and rating availability.

Key KPIs

KPI

Result

Total Customers

3,900

Total Revenue

$233,081

Average Purchase Amount

$59.76

Average Review Rating

3.75

Subscription Rate

27.0%

Discount Usage Rate

43.0%

SQL Analysis

The SQL analysis answers multiple business questions and demonstrates:

GROUP BY and aggregate functions

CASE WHEN

Common Table Expressions (CTEs)

Conditional aggregation

Window functions using DENSE_RANK()

Customer segmentation

Revenue and behavioural analysis

The full query file is available in:

customer_shopping_behavior_analysis.sql

Key Findings

Clothing was the highest-revenue category, generating approximately $104,264 from 1,737 customers.

The 55+ age segment generated the highest revenue at approximately $69,590.

Subscribers represented approximately 27.0% of customers.

Subscribers generated $62,645 in revenue with an average purchase value of $59.49, compared with $59.87 for non-subscribers.

Customers receiving discounts generated $99,411 in revenue, while non-discounted purchases generated $133,670.

Free Shipping was the highest-revenue shipping method, contributing approximately $40,777.

The Every 3 Months purchase-frequency group generated the most revenue among frequency segments.

Fall recorded the highest seasonal revenue at approximately $60,018.

Business Recommendations

Prioritise high-performing categories
Maintain strong product availability and promotional visibility for the highest-revenue categories while investigating cross-sell opportunities with lower-performing categories.

Strengthen subscription conversion
Because only around 27.0% of customers are subscribed, targeted incentives could be tested to convert frequent non-subscribers into subscribers.

Target customers by behavioural segment
Use purchase frequency, previous-purchase history and purchase-value bands to distinguish high-value repeat customers from occasional shoppers.

Review discount effectiveness
Compare customer spend and repeat-purchase behaviour between discounted and non-discounted groups before expanding promotional activity.

Use category and seasonal patterns for campaign planning
Align merchandising and marketing activity with the strongest categories and seasonal demand patterns.

Power BI Dashboard

The Power BI dashboard presents the major KPIs and customer behaviour patterns visually, including:

Revenue and customer KPIs

Category performance

Customer segmentation

Subscription behaviour

Purchase-frequency analysis

Shipping and promotional patterns

Add your dashboard screenshot here:

![Power BI Dashboard](dashboard.png)

Repository Structure

Customer-Shopping-Behavior-Analysis/
│
├── customer_shopping_behavior.csv
├── Customer_Shopping_Behavior_Excel_Portfolio.xlsx
├── customer_shopping_behavior_analysis.sql
├── dashboard.png
└── README.md
