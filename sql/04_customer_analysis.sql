/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 04 - Customer Analysis
Author  : Vijay Ram

Objective:
Analyze customer behavior, spending patterns,
loyalty, and profitability.
===========================================================
*/

/* Business Goal

Answer questions like:

Who are our most valuable customers?
Which customer segment generates the most revenue?
How loyal are our customers?
Which customers are unprofitable ? */



--1. Total Customers
SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM retail.orders;


--2. Customers by Segment
SELECT
segment,
COUNT(DISTINCT customer_id) AS total_customers
FROM retail.orders
GROUP BY segment
ORDER BY total_customers DESC;


--3. Revenue by Segment
SELECT
segment,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY segment
ORDER BY revenue DESC;


--4. Profit by Segment
SELECT
segment,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY segment
ORDER BY profit DESC;


--5. Average Spending per Customer
SELECT
ROUND(
SUM(sales) /
COUNT(DISTINCT customer_id),
2
) AS avg_customer_spending
FROM retail.orders;


--6. Top 10 Customers by Revenue
SELECT
customer_id,
customer_name,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY
customer_id,
customer_name
ORDER BY revenue DESC
LIMIT 10;


--7. Top 10 Customers by Profit
SELECT
customer_id,
customer_name,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY
customer_id,
customer_name
ORDER BY profit DESC
LIMIT 10;


--8. Top 10 Customers by Orders
SELECT
customer_id,
customer_name,
COUNT(DISTINCT order_id) AS orders
FROM retail.orders
GROUP BY
customer_id,
customer_name
ORDER BY orders DESC
LIMIT 10;


--9. Customers with Negative Profit
SELECT
customer_id,
customer_name,
ROUND(SUM(profit),2) AS total_loss
FROM retail.orders
GROUP BY
customer_id,
customer_name
HAVING SUM(profit) < 0
ORDER BY total_loss;


--10. Repeat Customers
SELECT
COUNT(*) AS repeat_customers
FROM
(
SELECT
customer_id
FROM retail.orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1
)t;


--11. One-Time Customers
SELECT
COUNT(*) AS one_time_customers
FROM
(
SELECT
customer_id
FROM retail.orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)=1
)t;


--12. Customer Lifetime Value (CLV)
SELECT
customer_id,
customer_name,
ROUND(SUM(sales),2) AS lifetime_value
FROM retail.orders
GROUP BY
customer_id,
customer_name
ORDER BY lifetime_value DESC
LIMIT 20;


--13. Average Profit per Customer
SELECT
ROUND(
SUM(profit)/COUNT(DISTINCT customer_id),
2
) AS avg_profit_customer
FROM retail.orders;


--14. Customers by Country
SELECT
country,
COUNT(DISTINCT customer_id) AS customers
FROM retail.orders
GROUP BY country
ORDER BY customers DESC;



--15. Customers by Market
SELECT
market,
COUNT(DISTINCT customer_id) AS customers
FROM retail.orders
GROUP BY market
ORDER BY customers DESC;


--16. Top Customers by Profit Margin
SELECT
customer_id,
customer_name,
ROUND(AVG(pofit_margin),2) AS avg_margin
FROM retail.orders
GROUP BY
customer_id,
customer_name
ORDER BY avg_margin DESC
LIMIT 20;


--17. Segment Contribution (%)
SELECT
segment,
ROUND(
SUM(sales) * 100 /
(SUM(SUM(sales)) OVER()),
2
) AS revenue_percentage
FROM retail.orders
GROUP BY segment
ORDER BY revenue_percentage DESC;



--18. Average Orders per Customer
SELECT
ROUND(
COUNT(DISTINCT order_id)::numeric /
COUNT(DISTINCT customer_id),
2
) AS avg_orders_per_customer
FROM retail.orders;


--19. Customers Purchasing Multiple Categories
SELECT
customer_id,
customer_name,
COUNT(DISTINCT category) AS categories
FROM retail.orders
GROUP BY
customer_id,
customer_name
HAVING COUNT(DISTINCT category) > 1
ORDER BY categories DESC;


--20. Customer Ranking by Revenue
SELECT
customer_name,
ROUND(SUM(sales),2) AS revenue,
RANK() OVER(
ORDER BY SUM(sales) DESC
) AS customer_rank
FROM retail.orders
GROUP BY customer_name;
