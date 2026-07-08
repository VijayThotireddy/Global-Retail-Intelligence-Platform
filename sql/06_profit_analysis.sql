/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 06 - Profit Analysis
Author  : Vijay Ram

Objective:
Analyze profitability across markets, products,
customers, discounts, and identify loss-making areas.
===========================================================
*/

--1. Total Profit
SELECT
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders;


--2. Overall Profit Margin (%)
SELECT
ROUND(
(SUM(profit) / SUM(sales)) * 100,
2
) AS overall_profit_margin
FROM retail.orders;


--3. Profit by Market
SELECT
market,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY market
ORDER BY total_profit DESC;


--4. Profit by Region
SELECT
region,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY region
ORDER BY total_profit DESC;


--5. Profit by Country (Top 10)
SELECT
country,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY country
ORDER BY total_profit DESC
LIMIT 10;


--6. Loss-Making Countries
SELECT
country,
ROUND(SUM(profit),2) AS total_loss
FROM retail.orders
GROUP BY country
HAVING SUM(profit) < 0
ORDER BY total_loss;


--7. Profit by Category
SELECT
category,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY category
ORDER BY total_profit DESC;


--8. Profit by Sub-Category
SELECT
sub_category,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY sub_category
ORDER BY total_profit DESC;



--9. Profit by Segment
SELECT
segment,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY segment
ORDER BY total_profit DESC;


--10. Profit by Ship Mode
SELECT
ship_mode,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY ship_mode
ORDER BY total_profit DESC;


--11. Discount vs Profit
SELECT
discount,
ROUND(AVG(profit),2) AS avg_profit
FROM retail.orders
GROUP BY discount
ORDER BY discount;


--12. Discount Category Performance
SELECT
discount_category,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY discount_category
ORDER BY total_profit DESC;


--13. Number of Loss Orders
SELECT
COUNT(*) AS loss_orders
FROM retail.orders
WHERE is_loss_order = 'Yes';



--14. Loss Orders by Category
SELECT
category,
COUNT(*) AS loss_orders
FROM retail.orders
WHERE is_loss_order = 'Yes'
GROUP BY category
ORDER BY loss_orders DESC;


--15. Average Profit Margin by Market
SELECT
market,
ROUND(AVG(profit_margin),2) AS avg_profit_margin
FROM retail.orders
GROUP BY market
ORDER BY avg_profit_margin DESC;


--16. Top 10 Most Profitable Products
SELECT
product_name,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;



--17. Top 10 Biggest Loss Products
SELECT
product_name,
ROUND(SUM(profit),2) AS total_loss
FROM retail.orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_loss
LIMIT 10;



--18. Monthly Profit Trend
SELECT
order_year,
order_month,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;



--19. Top 10 Highest Profit Orders
SELECT
order_id,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY order_id
ORDER BY total_profit DESC
LIMIT 10;


--20. Top 10 Biggest Loss Orders
SELECT
order_id,
ROUND(SUM(profit),2) AS total_loss
FROM retail.orders
GROUP BY order_id
HAVING SUM(profit) < 0
ORDER BY total_loss
LIMIT 10;


/*Business Questions Answered

This module answers questions such as:

What is the company's overall profit margin?
Which markets generate the highest profit?
Which countries and categories lose money?
How do discounts affect profitability?
Which products and orders create the biggest losses?
Which areas should management prioritize for profit improvement?
*/