## Marketing and Product Performance.
### OVERVIEW

This project analyzes a dataset containing 10,000 rows from various marketing campaigns. 
It includes 17 columns organized into the following categories:

•	ID columns: Campaign ID, Customer ID, Product ID

•	Campaign Performance: Budgets, Clicks, Conversions, ROI, and Revenue generated.

•	Product Details: Units sold, Discount levels, and Bundle pricing.

•	Customer Insights: Subscription tiers, Subscription length, Satisfaction rating.

•	Promotional Context: Flash sales, Discount Levels, and Common Campaign Keywords. 

### DATA SOURCE

Kaggle- [Marketing and Product Performance Dataset](https://www.kaggle.com/datasets/imranalishahh/marketing-and-product-performance-dataset/data)

### QUESTIONS

The dashboard answers the following business questions:

1. What campaign factors are most strongly correlated with high conversion rates across tiers?
2. Which subscription tier yields the highest ROI relative to budget allocations, and why does it outperform others?
3. How does subscription length influence conversion likelihood, and is there an optimal window for targeting renewal campaigns?
4. Which campaign keywords consistently yield low CPA while maintaining high conversions across tiers?
5. Can we predict conversion success using a combination of customer tier, subscription length, and keyword focus?
6. How do different discount bands affect customer ratings, and what does this say about perceived product value?
7. How should discount strategies vary by subscription tier to optimize both sales volume and satisfaction?
8. Is there a point where increasing discount levels negatively impacts sales due to perceived quality degradation?

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

The data was then imported into Microsoft Power BI for visualization.
I created dynamic visuals with calculated measures and grouping columns using DAX. 
Unnecessary columns were hidden to streamline analysis.

Key DAX Measures: 

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
•	ROI(return on Investment)
````
ROI = DIVIDE(([Total Revenue]-[Total Budget]),[Total Budget])
````

I calculated three columns using DAX, namely: Discount buckets, ROI buckets, and Subscription buckets.

•	Discount Bands:
````
Discount_Bands = 
    IF(marketing_and_product_performance[Discount_Level] >=60,"60-70%",
    IF(marketing_and_product_performance[Discount_Level] >=50,"50-59%",
    IF(marketing_and_product_performance[Discount_Level] >=40,"40-49%",
    IF(marketing_and_product_performance[Discount_Level] >=30,"30-39%",
    IF(marketing_and_product_performance[Discount_Level] >=20,"20-29%",
    IF(marketing_and_product_performance[Discount_Level] >=10,"10-19%",
"0-9%"
))))))
````

•	ROI buckets DAX :
````
ROI_Buckets = 
IF(marketing_and_product_performance[ROI] >=4,"Very High ROI",
IF(marketing_and_product_performance[ROI] >=3,"High ROI",
IF(marketing_and_product_performance[ROI] >=2,"Moderate ROI",
IF(marketing_and_product_performance[ROI] >=1,"Low ROI",
"Very Low ROI"
))))
````

•	Subscription length buckets :
````
Subscription_Buckets =
    IF(marketing_and_product_performance[Subscription_Length] >=24,"Over 2 Years",
        IF(marketing_and_product_performance[Subscription_Length] >=12,"Over 1 Year",
            "Under 1 Year"
            )
        )
````
•	Visual conditional formatting :
````
CF Blue = 
IF([Campaign_ID] =
    MAXX(
        ROWS,
        [Campaign_ID]
    ),
    "#358084","#90CDD0"
)
````
I created three reports: Campaing Performance, Product Performance and Customer Analysis to present metrics in a clear and granular manner.

### DASHBOARD

![Marketing dashboard](https://github.com/user-attachments/assets/2920fe79-de20-48c0-ac4e-d0e5e70ad3a9)

### Campaign Performance

#### Overview

Revenue vs. Budget: Campaigns generated $500M in revenue from a $253M budget, showcasing a strong return with an ROI of 98.07%.

Units Sold: Over 1.01 million units sold, signaling solid market demand across campaigns.

#### Efficiency Metrics
•	Cost per Conversion: Averaging at $50.63, providing a useful benchmark for future campaign planning.

•	Conversion Rate: Holding steady at 20.10%, indicating effective targeting and message penetration.

#### Keyword Performance Breakdown
•	Campaign messaging is well-balanced:

o	Innovative (25.35%) and Affordable (25.11%) slightly lead over Stylish (24.91%) and Durable (24.63%).

o	This suggests keywords are evenly weighted, with no bias.

#### Tier-Level Distribution
•	Campaign volumes are comparable across tiers:

o	Basic: 3.4K

o	Standard: 3.3K

o	Premium: 3.3K

o	This uniform distribution supports fair performance comparison by tier.

#### Subscription Duration Insights
o	Conversion breakdown:

o	Over 2 years: 1.7M

o	Over 1 year: 1.7M

o	Under 1 year: 1.5M

o	Indicates long-term subscriptions are performing just as well as shorter terms.

#### Campaign-Level Highlights
o	Individual campaign performance varies widely:

o	Some deliver higher revenue but lower conversion rates, e.g., CMP_7FVXZ with just 6.33%, while others like CMP_WXDTMN achieve 12.13%.

o	Useful for refining budget allocation and performance strategy.

### PRODUCT PERFORMANCE
#### Overview
•	Total Products: 10K with 1.01M units sold

•	Average Rating: 3 stars—suggests room for enhancement in product quality or user experience

•	Average Discount: 39%—aggressive promotional strategy with strong conversion outcomes
#### Subscription Tier Breakdown
•	Basic, Standard, and Premium tiers each sold ~330K units, reflecting an even distribution across tiers

•	Indicates product appeal is consistent regardless of tier pricing—valuable for scalable messaging

#### Subscription Period Trends
•	Sales volume remains balanced across:

o	Over 2 Years: 349K

o	Over 1 Year: 342K

o	Under 1 Year: 316K

•	Reinforces the notion that long-term and short-term subscribers are equally responsive to product offers

#### Keyword Performance (Campaign Messaging)
•	Top-performing keywords:

o	Affordable (258K units)

o	Innovative (256K)

o	Stylish (251K)

o	Durable (242K)

•	Insight: “Affordable” and “Innovative” messaging drives slightly better product movement—candidates for expanded copy or media emphasis

#### Product Rating Distribution
•	Fairly balanced across ratings 1–4 with no dominant peak

o	Ratings 2 and 4 slightly edge out others

•	Opportunity: Dig deeper into ratings feedback to elevate product design and user satisfaction

#### ROI Bucket Analysis
Takeaway: Moderate and low ROI products maintain higher conversion rates—suggests niche value even in lower-performance brackets

#### Discount Strategy Insights
•	Best-performing discount ranges: 

o	41–50% and 31–40% drove the highest ROI (~279%)

•	Lower discounts (11–20%) still sustained solid conversion (~20%)

•	Suggests elasticity in price sensitivity—possible to optimize margins without tanking conversion.

-----Dashboard----

### CUSTOMER ANALYSIS
#### Overview
•	10K customers contributed to $500M in revenue from a $253M budget

•	Conversion rate of 20.10% and Cost per conversion of $51 show strong campaign efficiency

#### Subscription Tier Analysis
•	Customer count evenly spread:

o	Basic: 3.4K

o	Standard: 3.3K

o	Premium: 3.3K

•	Conversion rates are tight: 

o	Basic leads at 20.62%

o	Standard at 19.88%

o	Premium at 19.80%

•	All tiers perform similarly, but the Basic tier has a slight advantage, which could guide micro-targeted messaging.

#### Subscription Period Trends
•	Customers by period:

o	Over 2 Years: 3.46K

o	Over 1 Year: 3.40K

o	Under 1 Year: 3.14K

•	Conversion rates: 

o	Over 1 Year: 33.84%

o	Over 2 Years: 33.38%

o	Under 1 Year: 32.78%

• Longer subscriptions slightly edge conversion—an opportunity to push retention campaigns.

#### Customer Insights
•	Varies by:

o	Discount Levels

o	Units Purchased

o	Product Ratings

o	Subscription Tenure

This granular view enables personalized engagement strategies—particularly high-value or high-rating customers.

### FINDINGS

##### Campaign Factors Correlated with High Conversion Rates

Keywords: Campaigns emphasizing “Innovative” and “Affordable” messaging seem to maintain strong conversion performance across tiers.

Subscription Tenure: Longer-tenure customers show marginally better conversion likelihood—especially those over 12 months.

Discount Bands: Moderate discounts (~30–40%) often align with better ratings and conversion, suggesting perceived value plays a role.

Subscription Tiers: Premium-tier campaigns show consistency in conversion, possibly due to better segmentation or messaging alignment.
 
##### Highest ROI Tier vs Budget Allocation

•	Premium Tier delivers the most ROI relative to budget due to:

o	Fewer campaigns overall, but more targeted messaging.

o	Higher price points allow stronger ROI per conversion.

o	Campaign keywords like “Stylish” and “Durable” here tap into value-driven sentiments.

##### Subscription Tenure & Conversion

•	Customers with >12 months subscription show slightly higher conversion rates (~33.84%) than newer users.

•	Optimal Targeting Window:

o	Consider running renewal campaigns around the 9–12 month mark.

o	This is when value perception and loyalty might peak, but complacency hasn’t set in.

##### Low CPA + High Conversion Keywords

•	“Affordable” and “Innovative” stand out:

o	Broad appeal across tiers.

o	Consistently contribute to lower cost per acquisition while maintaining performance.

##### Conversion Success Prediction

o	Combine Premium tier, tenure >12 months, and keywords like “Affordable” or “Stylish.”

o	Layer in medium discount bands (~30–40%) to model the likelihood of conversion with high ROI.

##### Discount Bands vs Customer Ratings

•	Steep discounts (e.g.,>50%) correlate with lower ratings in some cases.

o	Suggests perception of reduced product quality or mismatched expectations.

o	Lower ratings despite high units sold highlight a need to balance quantity with satisfaction.

##### Discount Strategies by Tier

•	Basic Tier:

o	Higher discounts may drive volume, but monitor satisfaction scores.

•	Standard Tier:

o	Moderate discounts with “Affordable” or “Innovative” keywords seem optimal.

•	Premium Tier:

o	Minimal discounts; focus on value messaging like “Stylish” or “Durable.” Maintain perceived exclusivity.

##### Discount Threshold vs Quality Perception

•	There appears to be an inflection point:

o	Discounts above 50% often trigger a dip in product ratings.

o	The value narrative starts breaking down, especially in Premium products.

#### RECOMMENDATIONS 
Messaging: Scale “Affordable” and “Innovative” in campaigns due to good conversion and ROI.

Pricing: Refine discount strategy to balance ROI,Conversion & volume.

Customer Retention: Target longer-tenure users with loyalty offers.

Product Development: Analyze mid-tier ratings for enhancement cues.

Tier Targeting: Explore budget vs tier upsell opportunities.
