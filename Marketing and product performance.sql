
-- DATA EXPLORATION 10000 unique campaigns
SELECT
DISTINCT campaign_ID
FROM marketing_and_product_performance; 

-- Descriptive statistics on budget
SELECT
MAX(budget) AS Highest_spend,
MIN(budget) AS Lowest_spend,
ROUND(AVG(Budget),2) AS Avg_spend,
ROUND(SUM(Budget),2) AS Total_budget
FROM marketing_and_product_performance;

-- Descriptive statistics on revenue
SELECT
MAX(Revenue_Generated) AS Highest_revenue,
MIN(Revenue_Generated) AS Lowest_revenue,
ROUND(AVG(Revenue_Generated),2) AS Avg_revenue,
ROUND(SUM(Revenue_Generated),2) AS Total_revenue
FROM marketing_and_product_performance;

-- Descriptive statistics on ROI
SELECT
MAX(ROI) AS Highest_ROI,
MIN(ROI) AS Lowest_ROI,
ROUND(AVG(ROI),2) AS Avg_ROI
FROM marketing_and_product_performance;

-- Descriptive statistics on clicks
SELECT
MAX(Clicks) AS Highest_clicks,
MIN(Clicks) AS Lowest_clicks,
ROUND(AVG(Clicks)) AS Avg_clicks,
ROUND(SUM(Clicks),2) AS Total_clicks
FROM marketing_and_product_performance;

-- Descriptive statistics on conversions
SELECT 
    MAX(Conversions) AS Highest_conversions,
    MIN(Conversions) AS Lowest_conversions,
    ROUND(AVG(Conversions)) AS Avg_conversions,
    ROUND(SUM(Conversions), 2) AS Total_conversions
FROM
    marketing_and_product_performance;

-- Calculating conversion rate = 20.10%
SELECT
	ROUND((SUM(conversions)/SUM(clicks)) * 100,2)
FROM marketing_and_product_performance;

-- Count of customers per subscription tier
SELECT 
    Subscription_Tier,
    COUNT(Subscription_Tier) AS customers_number
FROM
    marketing_and_product_performance
GROUP BY Subscription_Tier
ORDER BY customers_number DESC;

-- Suscription length in months 1-35
SELECT 
DISTINCT Subscription_length
FROM
    marketing_and_product_performance
ORDER BY Subscription_Length;

-- Count of customers by subscription length
SELECT 
    Subscription_Length,
    COUNT(Subscription_Length) AS customers
FROM
    marketing_and_product_performance
GROUP BY  Subscription_Length
ORDER BY customers DESC;

-- Exploration of discount
SELECT 
MAX(Discount_Level) AS Highest_disc,
MIN(Discount_Level) AS Lowest_disc
FROM
    marketing_and_product_performance;
    
-- Descriptive statistics on conversions
SELECT 
    MAX(Conversions) AS Highest_units_sold,
    MIN(Conversions) AS Lowest_units_sold,
    ROUND(SUM(Conversions), 2) AS Total_units_sold
FROM
    marketing_and_product_performance;
    
-- Descriptive statistics on bundle price
SELECT 
    MAX(Bundle_Price) AS Highest_bundle_price,
    MIN(Bundle_Price) AS Lowest_bundle_price,
    ROUND(AVG(Bundle_Price),2) AS Avg_bundle_price,
    ROUND(SUM(Bundle_Price), 2) AS Total_budle_price
FROM
    marketing_and_product_performance;
    
-- Campaign keyword use
SELECT 
Common_Keywords,
COUNT(Common_Keywords) AS keyword_instances
FROM marketing_and_product_performance
GROUP BY Common_Keywords
ORDER BY keyword_instances DESC;

SELECT
Customer_Satisfaction_Post_Refund AS Customer_rating,
COUNT(Customer_Satisfaction_Post_Refund) AS Customers
FROM marketing_and_product_performance
GROUP BY Customer_Satisfaction_Post_Refund
ORDER BY Customers DESC;



