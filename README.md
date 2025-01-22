## Marketing and Product Performance.
### OVERVIEW

The project is on a dataset from 10000 rows of data from marketing campaigns.

The dataset contains 17 columns:

•	ID columns: Campaign ID, Customer ID, Product ID

•	Campaign Performance: Budgets, clicks, conversions, ROI, and revenue generated.

•	Product Details: Units sold, discount levels, and bundle pricing.

•	Customer Insights: Subscription tiers, lengths, satisfaction ratings.

•	Promotional Context: Flash sales, discount levels, and common keyword themes. 

### DATA SOURCE

Kaggle- [Marketing and Product Performance Dataset](https://www.kaggle.com/datasets/imranalishahh/marketing-and-product-performance-dataset/data)

### QUESTIONS

The dashboard answers the following business questions:

1.	How does the budget vs revenue change based on subscription tier?
2.	How do clicks and conversions vary based on subscription tier?
3.	What is the relationship between budget and return on investment(ROI)?
4.	Is the conversion rate influenced by subscription tier or length of subscription?
5.	Do the campaign keywords influence sales and how does the Cost Per Action vary by keyword?
6.	Do discount levels influence purchase behavior?
7.	What is the relationship between discount levels and the rating of products?
8.	Does the customer subscription tier influence campaign success(revenue generated)?

### PRELIMINARY PROCESSING.

This was done in MySQL to get summary statistics from the different columns.

The ROI(Return on investment) column has values ranging from 0 to 5.

![SQL RoI](https://github.com/user-attachments/assets/9c306b06-5e7b-4d55-a672-0294880d4198)

The discount levels column has discounts ranging from 10% to 69%.

![SQL discount](https://github.com/user-attachments/assets/ad36f638-c5f9-405b-8d28-a7fb5d5e5e4e)

Customer rating post refund has values of 1 to 4 stars.

![SQL Rating](https://github.com/user-attachments/assets/a87d1bf4-ef66-4b0e-8572-2609a400ad8b)

There are 4 distinct keywords for the campaigns: affordable, innovative, stylish, and durable.

![SQL Campaign](https://github.com/user-attachments/assets/d45210ac-4f2a-4fe8-bf82-cdd3036840e8)

#### PROCESS

I loaded the CSV file into MySQL to do preliminary data checks for duplicates and ensure the data was clean.

I did some summary statistics on the columns before loading the data into Microsoft Power BI to create visualizations.

In Power BI, I calculated some measures and hid unnecessary columns for my analysis.

The measures were created using DAX: 

•	Total budget
````
Total Budget = SUM(marketing_and_product_performance[Budget])
````
•	Total revenue
````
Total Revenue = SUM(marketing_and_product_performance[Revenue_Generated])
````
•	Total Clicks
````
Total Clicks = SUM(marketing_and_product_performance[Clicks])
````
•	Total Conversions
````
Total Conversions = SUM(marketing_and_product_performance[Conversions])
````
•	Conversion rate
````
Conversion Rate = DIVIDE(marketing_and_product_performance[Total Conversions],marketing_and_product_performance[Total Clicks])
````
•	Cost Per Click
````
Cost Per Click = [Total Budget]/[Total Clicks]
````
•	Cost Per Action
````
Cost Per Action = [Total Budget]/[Total Conversions]
````

•	Total units sold
````
Total Units Sold = SUM(marketing_and_product_performance[Units_Sold])
````
•	Average ROI(return on Investment)
````
Avg. ROI = AVERAGE(marketing_and_product_performance[ROI])
````

I calculated three columns using DAX, namely: Discount buckets, ROI buckets, and Subscription buckets.

•	Discount buckets DAX :
````
Discount Buckets = 
SWITCH(
    TRUE(),
    'marketing_and_product_performance'[Discount_Level]>= 10 && 'marketing_and_product_performance'[Discount_Level]< 20, "10-19%",
    'marketing_and_product_performance'[Discount_Level]>= 20 && 'marketing_and_product_performance'[Discount_Level] < 30, "20-29%",
    'marketing_and_product_performance'[Discount_Level]>= 30 && 'marketing_and_product_performance'[Discount_Level]< 40, "30-39%",
    'marketing_and_product_performance'[Discount_Level]>= 40 && 'marketing_and_product_performance'[Discount_Level] < 50, "40-49%",
    'marketing_and_product_performance'[Discount_Level]>= 50 && 'marketing_and_product_performance'[Discount_Level] < 60, "50-59%",
    'marketing_and_product_performance'[Discount_Level]>= 60 && 'marketing_and_product_performance'[Discount_Level] < 70, "60-69%",
    "Other"
)

````

•	ROI buckets DAX :
````
ROI Buckets = 
SWITCH(
    TRUE(),
    'marketing_and_product_performance'[ROI] >= 0 && 'marketing_and_product_performance'[ROI] <= 1, "0-1",
    'marketing_and_product_performance'[ROI] > 1 && 'marketing_and_product_performance'[ROI] <= 2, "1-2",
    'marketing_and_product_performance'[ROI] > 2 && 'marketing_and_product_performance'[ROI] <= 3, "2-3",
    'marketing_and_product_performance'[ROI] > 3 && 'marketing_and_product_performance'[ROI] <= 4, "3-4",
    'marketing_and_product_performance'[ROI] > 4 && 'marketing_and_product_performance'[ROI] <= 5, "4-5",
    "Other"
)

````

•	Subscription length buckets :
````
Subscription Bucket = 
SWITCH(
    TRUE(),
    'marketing_and_product_performance'[Subscription_Length]>= 1  && 'marketing_and_product_performance'[Subscription_Length]<= 7, "1-7",
    'marketing_and_product_performance'[Subscription_Length]>= 8  && 'marketing_and_product_performance'[Subscription_Length]<= 14, "8-14",
    'marketing_and_product_performance'[Subscription_Length]>= 15 && 'marketing_and_product_performance'[Subscription_Length]<= 21, "15-21",
    'marketing_and_product_performance'[Subscription_Length]>= 22 && 'marketing_and_product_performance'[Subscription_Length]<= 28, "22-28",
    'marketing_and_product_performance'[Subscription_Length]>= 29 && 'marketing_and_product_performance'[Subscription_Length]<= 35, "29-35",
    "Other"
)
````

I created visuals based on the business questions to represent the insights.

The KPIs are on the top row of the dashboard and all visuals are dynamic.

I included a slicer to filter the charts by subscription tier.

The histogram at the bottom right contains a drill-down feature to view the rating at a granular level based on each discount bucket.

### DASHBOARD

![Marketing dashboard](https://github.com/user-attachments/assets/2920fe79-de20-48c0-ac4e-d0e5e70ad3a9)

### FINDINGS

There is a 1:2 relationship between the budget used and revenue generated and it also varies by subscription tier.
There are three tiers, the basic tier being the top revenue generator and the premium tier least.

The clicks and conversions are also influenced by the subscription tier with the basic tier having a conversion rate
of 20.62%, standard at 19.88%, and premium at 19.82%.
The premium tier has the lowest CPC(Cost Per Click) while the basic tier has the lowest CPA(Cost Per Action).
A low CPC indicates little pay for a lot of traffic although a higher one for a niche audience isn’t a problem. 
A low CPA indicates a campaign that is well targeted hence low cost to get desired action.

The budget and ROI are conversely related, with the 4-5 ROI bucket having the highest budget of $58M.
The average ROI from the campaigns is 2.76 so with other factors considered, anything below that could be classified as poorly performing.

The longer the level of subscription, the higher the conversion rate among different subscription tiers.
Subscribers between 22- 28 months have the highest rate at 20.48% but the longest-length subscribers(29-35) have a lower rate(19.86%). 
This trend could be due to established trust but also that beyond a certain level, they have acquired most products hence a lower conversion rate.

There were four campaign keywords: affordable, innovative, stylish, and durable.
They seem to influence sales with “affordable” and “innovative” being responsible for 51% of the sales.
The word innovative has the lowest cost per action(CPA) at $49 while stylish and affordable have the highest at $51.
Although the difference isn’t large, a low CPA is a good indicator the campaign has nailed targeting, messaging, and strategy. 
This varies per subscription tier and different targeting is effective.

Peak sales were attained at discount levels of 20-29% and 30-39% (and declined with increasing discount levels. 
There could be a suspicion of poor quality at very high and very low discounts hence the declining sales observed. 
This observation is true for the basic and premium tiers but the standard tier has peak sales at the 40-49% discount level.

Product rating at most discount levels is 2, however, the 40-49% bucket has the highest number of 4-star ratings while 60-69% has a high number of 1-star ratings. 
It could relate to value for money spent. This could be investigated further as discount isn’t the only factor influencing rating, other factors such as
delivery promptness and aftercare services and customer service could play a role. The campaign keywords could also influence rating if the description doesn’t match the product.

[Marketing and Product Performance Analysis video](https://youtu.be/ONSyVQcWinY)


