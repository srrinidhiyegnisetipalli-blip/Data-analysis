-- Customer Shopping Behavior Analysis
-- SQL dialect: PostgreSQL-compatible
-- Dataset: customer_shopping_behavior.csv
-- Rows: 3900
-- Purpose: Clean, validate, and analyse customer purchasing behaviour.

DROP TABLE IF EXISTS customer_shopping_behavior;

CREATE TABLE customer_shopping_behavior (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(20),
    item_purchased VARCHAR(100),
    category VARCHAR(50),
    purchase_amount_usd NUMERIC(10,2),
    location VARCHAR(100),
    size VARCHAR(10),
    color VARCHAR(50),
    season VARCHAR(20),
    review_rating NUMERIC(3,1),
    subscription_status VARCHAR(10),
    shipping_type VARCHAR(50),
    discount_applied VARCHAR(10),
    promo_code_used VARCHAR(10),
    previous_purchases INT,
    payment_method VARCHAR(50),
    frequency_of_purchases VARCHAR(50)
);

-- =========================================================
-- 1. DATA QUALITY CHECKS
-- =========================================================

-- Row count and duplicate customer IDs
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids
FROM customer_shopping_behavior;

-- Missing-value check for review ratings
SELECT
    COUNT(*) AS total_rows,
    COUNT(review_rating) AS available_ratings,
    COUNT(*) - COUNT(review_rating) AS missing_ratings
FROM customer_shopping_behavior;

-- =========================================================
-- 2. OVERALL KPIs
-- =========================================================

SELECT
    COUNT(*) AS total_customers,
    ROUND(SUM(purchase_amount_usd), 2) AS total_revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(review_rating), 2) AS avg_review_rating,
    ROUND(100.0 * SUM(CASE WHEN subscription_status = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_pct
FROM customer_shopping_behavior;

-- =========================================================
-- 3. CATEGORY PERFORMANCE
-- Business question: Which product categories generate the most revenue?
-- =========================================================

SELECT
    category,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(100.0 * SUM(purchase_amount_usd) / SUM(SUM(purchase_amount_usd)) OVER (), 2) AS revenue_share_pct
FROM customer_shopping_behavior
GROUP BY category
ORDER BY revenue DESC;

-- =========================================================
-- 4. TOP PRODUCTS BY REVENUE
-- Business question: Which individual items contribute the most revenue?
-- =========================================================

SELECT
    item_purchased,
    COUNT(*) AS purchases,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY item_purchased
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- 5. CUSTOMER AGE SEGMENT ANALYSIS
-- Business question: Which age groups contribute the most revenue?
-- =========================================================

WITH age_segments AS (
    SELECT
        *,
        CASE
            WHEN age < 25 THEN '18-24'
            WHEN age < 35 THEN '25-34'
            WHEN age < 45 THEN '35-44'
            WHEN age < 55 THEN '45-54'
            ELSE '55+'
        END AS age_group
    FROM customer_shopping_behavior
)
SELECT
    age_group,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM age_segments
GROUP BY age_group
ORDER BY revenue DESC;

-- =========================================================
-- 6. SUBSCRIBER VS NON-SUBSCRIBER BEHAVIOUR
-- Business question: Do subscribers spend more than non-subscribers?
-- =========================================================

SELECT
    subscription_status,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_shopping_behavior
GROUP BY subscription_status
ORDER BY revenue DESC;

-- =========================================================
-- 7. DISCOUNT IMPACT
-- Business question: Are discounted purchases associated with higher spend?
-- =========================================================

SELECT
    discount_applied,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_shopping_behavior
GROUP BY discount_applied
ORDER BY revenue DESC;

-- =========================================================
-- 8. PURCHASE FREQUENCY ANALYSIS
-- Business question: Which purchase-frequency groups contribute most revenue?
-- =========================================================

SELECT
    frequency_of_purchases,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY frequency_of_purchases
ORDER BY revenue DESC;

-- =========================================================
-- 9. SHIPPING TYPE PERFORMANCE
-- Business question: Which shipping options are most associated with revenue?
-- =========================================================

SELECT
    shipping_type,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY shipping_type
ORDER BY revenue DESC;

-- =========================================================
-- 10. SEASONAL PERFORMANCE
-- Business question: How does customer spend vary by season?
-- =========================================================

SELECT
    season,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(review_rating), 2) AS avg_rating
FROM customer_shopping_behavior
GROUP BY season
ORDER BY revenue DESC;

-- =========================================================
-- 11. TOP LOCATIONS BY REVENUE
-- Business question: Which locations generate the highest revenue?
-- =========================================================

SELECT
    location,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY location
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- 12. CUSTOMER VALUE SEGMENT
-- Business question: How many customers fall into low, medium, and high purchase-value groups?
-- =========================================================

WITH value_segments AS (
    SELECT
        customer_id,
        purchase_amount_usd,
        CASE
            WHEN purchase_amount_usd < 40 THEN 'Low Value'
            WHEN purchase_amount_usd < 70 THEN 'Medium Value'
            ELSE 'High Value'
        END AS value_segment
    FROM customer_shopping_behavior
)
SELECT
    value_segment,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount_usd), 2) AS revenue,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM value_segments
GROUP BY value_segment
ORDER BY revenue DESC;

-- =========================================================
-- 13. RANK CATEGORIES WITHIN EACH SEASON
-- Demonstrates window functions.
-- =========================================================

WITH seasonal_category_revenue AS (
    SELECT
        season,
        category,
        SUM(purchase_amount_usd) AS revenue
    FROM customer_shopping_behavior
    GROUP BY season, category
)
SELECT
    season,
    category,
    ROUND(revenue, 2) AS revenue,
    DENSE_RANK() OVER (
        PARTITION BY season
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM seasonal_category_revenue
ORDER BY season, revenue_rank;

-- =========================================================
-- 14. HIGH-VALUE REPEAT CUSTOMERS
-- Business question: Which records show both strong purchase history and high current spend?
-- =========================================================

SELECT
    customer_id,
    age,
    category,
    purchase_amount_usd,
    previous_purchases,
    subscription_status,
    frequency_of_purchases
FROM customer_shopping_behavior
WHERE purchase_amount_usd >= 70
  AND previous_purchases >= 30
ORDER BY purchase_amount_usd DESC, previous_purchases DESC;
