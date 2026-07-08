/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 03 - Sales Analysis
Author  : Vijaya Rami Reddy

Objective:
Analyze revenue, sales trends, customer spending,
and business performance.
===========================================================
*/


--1. Total Sales Revenue
--Business Question : How much revenue has the company generated?

SELECT
ROUND(SUM(sales),2) AS total_sales
FROM retail.orders;


--2. Total Profit
SELECT
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders;


--3. Total Orders
SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM retail.orders;


--4. Average Order Value (AOV)
SELECT
ROUND(
SUM(sales)/
COUNT(DISTINCT order_id),
2
) AS average_order_value
FROM retail.orders;


--5. Average Profit per Order
SELECT
ROUND(
SUM(profit)/
COUNT(DISTINCT order_id),
2
) AS avg_profit_per_order
FROM retail.orders;


--6. Monthly Sales Trend
SELECT
order_year,
order_month,
ROUND(SUM(sales),2) AS sales
FROM retail.orders
GROUP BY
order_year,
order_month
ORDER BY
order_year,
order_month;


--7. Monthly Profit Trend
SELECT
order_year,
order_month,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY
order_year,
order_month
ORDER BY
order_year,
order_month;


--8. Yearly Revenue
SELECT
order_year,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY order_year
ORDER BY order_year;


--9. Yearly Profit
SELECT
order_year,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY order_year
ORDER BY order_year;


--10. Sales by Market
SELECT
market,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY market
ORDER BY revenue DESC;


--11. Sales by Region
SELECT
region,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY region
ORDER BY revenue DESC;


--12. Sales by Country (Top 10)
SELECT
country,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;


--13. Sales by State (Top 10)
SELECT
state,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY state
ORDER BY revenue DESC
LIMIT 10;


--14. Sales by City (Top 10)
SELECT
city,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY city
ORDER BY revenue DESC
LIMIT 10;



--15. Sales by Category
SELECT
category,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY category
ORDER BY revenue DESC;



--16. Sales by Sub Category
SELECT
sub_category,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY sub_category
ORDER BY revenue DESC;


--17. Sales by Segment
SELECT
segment,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY segment
ORDER BY revenue DESC;


--18. Sales by Ship Mode
SELECT
ship_mode,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY ship_mode
ORDER BY revenue DESC;


--19. Sales by Order Priority
SELECT
order_priority,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY order_priority
ORDER BY revenue DESC;


--20. Daily Average Sales
SELECT
ROUND(AVG(daily_sales),2) AS avg_daily_sales
FROM
(
SELECT
order_date,
SUM(sales) AS daily_sales
FROM retail.orders
GROUP BY order_date
)t;