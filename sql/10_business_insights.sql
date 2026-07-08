/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 10 - Business Insights
Author  : Vijay Rami Reddy

Objective:
Get  advanced business insights using CTEs,
Window Functions, Ranking, and Trend Analysis.
===========================================================
*/




--1. Top 10 Customers by Lifetime Value
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales),2) AS lifetime_value,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_rank
FROM retail.orders
GROUP BY customer_id, customer_name
LIMIT 10;


--2. Top 10 Products by Revenue
SELECT
    product_name,
    ROUND(SUM(sales),2) AS revenue,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS product_rank
FROM retail.orders
GROUP BY product_name
LIMIT 10;


--3. Monthly Sales Growth (LAG)
WITH monthly_sales AS
(
SELECT
order_year,
order_month,
SUM(sales) AS sales
FROM retail.orders
GROUP BY order_year,order_month
)
SELECT
*,
ROUND(
sales-
LAG(sales) OVER(
ORDER BY order_year,order_month
),2) AS growth
FROM monthly_sales;


--4. Running Total Sales
SELECT
order_year,
order_month,
ROUND(SUM(sales),2) AS monthly_sales,
ROUND(
SUM(SUM(sales))
OVER(
ORDER BY order_year,order_month
),2
) AS cumulative_sales
FROM retail.orders
GROUP BY order_year,order_month;

--5. Top 10 Loss Orders
SELECT
order_id,
ROUND(SUM(profit),2) AS loss
FROM retail.orders
GROUP BY order_id
HAVING SUM(profit)<0
ORDER BY loss
LIMIT 10;



--6. High Revenue, Low Profit Products
SELECT
product_name,
ROUND(SUM(sales),2) revenue,
ROUND(SUM(profit),2) profit
FROM retail.orders
GROUP BY product_name
HAVING
SUM(sales)>10000
AND
SUM(profit)<1000
ORDER BY revenue DESC;


--7. Market Share %
SELECT
market,
ROUND(
SUM(sales)*100/
SUM(SUM(sales))
OVER(),
2
) AS market_share
FROM retail.orders
GROUP BY market
ORDER BY market_share DESC;


--8. Category Contribution
SELECT
category,
ROUND(
SUM(sales),2
) revenue,
ROUND(
SUM(sales)*100/
SUM(SUM(sales))
OVER(),
2
) contribution
FROM retail.orders
GROUP BY category;


--9. Pareto Analysis (80/20)
WITH customer_sales AS
(
SELECT
customer_name,
SUM(sales) sales
FROM retail.orders
GROUP BY customer_name
)
SELECT
customer_name,
sales,
ROUND(
SUM(sales)
OVER(
ORDER BY sales DESC
)
*100/
SUM(sales)
OVER(),
2
) cumulative_percentage
FROM customer_sales;


--10. Revenue Quartiles
SELECT
customer_name,
SUM(sales) revenue,
NTILE(4)
OVER(
ORDER BY SUM(sales) DESC
) revenue_quartile
FROM retail.orders
GROUP BY customer_name;


--11. Best Selling Month
SELECT
month_name,
ROUND(SUM(sales),2) revenue
FROM retail.orders
GROUP BY month_name
ORDER BY revenue DESC
LIMIT 1;


--12. Most Profitable Month
SELECT
month_name,
ROUND(SUM(profit),2) profit
FROM retail.orders
GROUP BY month_name
ORDER BY profit DESC
LIMIT 1;


--13. Customer Segmentation
SELECT
customer_name,
SUM(sales) revenue,
CASE
WHEN SUM(sales)>=20000
THEN 'Platinum'
WHEN SUM(sales)>=10000
THEN 'Gold'
WHEN SUM(sales)>=5000
THEN 'Silver'
ELSE 'Bronze'
END customer_segment
FROM retail.orders
GROUP BY customer_name;


--14. Product Performance Classification
SELECT
product_name,
SUM(sales) revenue,
SUM(profit) profit,
CASE
WHEN SUM(profit)>5000
THEN 'High Performer'
WHEN SUM(profit)>1000
THEN 'Medium Performer'
ELSE 'Low Performer'
END performance
FROM retail.orders
GROUP BY product_name;


--15. Discount Impact
SELECT
discount_category,
ROUND(AVG(profit),2) avg_profit,
ROUND(AVG(sales),2) avg_sales
FROM retail.orders
GROUP BY discount_category;


--16. Top Markets by Profit Margin
SELECT
market,
ROUND(
SUM(profit)/SUM(sales)*100,
2
) margin
FROM retail.orders
GROUP BY market
ORDER BY margin DESC;


--17. Top 10 Cities by Profit Margin
SELECT
city,
ROUND(
SUM(profit)/SUM(sales)*100,
2
) margin
FROM retail.orders
GROUP BY city
HAVING SUM(sales)>5000
ORDER BY margin DESC
LIMIT 10;


--18. Best Shipping Mode
SELECT
ship_mode,
ROUND(AVG(profit),2) avg_profit,
ROUND(AVG(delivery_days),2) avg_days
FROM retail.orders
GROUP BY ship_mode
ORDER BY avg_profit DESC;


--19. Year-over-Year Growth
WITH yearly_sales AS
(
SELECT
order_year,
SUM(sales) sales
FROM retail.orders
GROUP BY order_year
)
SELECT
order_year,
sales,
ROUND(
(sales-
LAG(sales)
OVER(ORDER BY order_year))
*100/
LAG(sales)
OVER(ORDER BY order_year),
2
) growth_percentage
FROM yearly_sales;


--20. Executive Recommendations Dataset
SELECT
market,
category,
ROUND(SUM(sales),2) sales,
ROUND(SUM(profit),2) profit,
ROUND(SUM(profit)/SUM(sales)*100,2) margin,
COUNT(DISTINCT customer_id) customers
FROM retail.orders
GROUP BY
market,
category
ORDER BY sales DESC;
