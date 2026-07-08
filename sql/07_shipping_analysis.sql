/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 07 - Shipping Analysis
Author  : Vijay Ram

Objective:
Analyze shipping performance, delivery efficiency,
shipping costs, and order priorities.
===========================================================
*/

--1.Total Shipping Cost
SELECT
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders;


--2. Average Shipping Cost
SELECT
ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM retail.orders;


--3. Shipping Cost by Ship Mode
SELECT
ship_mode,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY ship_mode
ORDER BY total_shipping_cost DESC;



--4. Average Shipping Cost by Ship Mode
SELECT
ship_mode,
ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM retail.orders
GROUP BY ship_mode
ORDER BY avg_shipping_cost DESC;


--5. Orders by Ship Mode
SELECT
ship_mode,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY ship_mode
ORDER BY total_orders DESC;


--6. Average Delivery Days by Ship Mode
SELECT
ship_mode,
ROUND(AVG(delivery_days),2) AS avg_delivery_days
FROM retail.orders
GROUP BY ship_mode
ORDER BY avg_delivery_days;


--7. Shipping Cost by Market
SELECT
market,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY market
ORDER BY total_shipping_cost DESC;


--8. Average Delivery Days by Market
SELECT
market,
ROUND(AVG(delivery_days),2) AS avg_delivery_days
FROM retail.orders
GROUP BY market
ORDER BY avg_delivery_days;


--9. Shipping Cost by Region
SELECT
region,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY region
ORDER BY total_shipping_cost DESC;


--10. Shipping Cost by Category
SELECT
category,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY category
ORDER BY total_shipping_cost DESC;



--11. Shipping Cost by Segment
SELECT
segment,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY segment
ORDER BY total_shipping_cost DESC;


--12. Orders by Order Priority
SELECT
order_priority,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY order_priority
ORDER BY total_orders DESC;


--13. Shipping Cost by Order Priority
SELECT
order_priority,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY order_priority
ORDER BY total_shipping_cost DESC;


--14. Average Delivery Days by Order Priority
SELECT
order_priority,
ROUND(AVG(delivery_days),2) AS avg_delivery_days
FROM retail.orders
GROUP BY order_priority
ORDER BY avg_delivery_days;


--15. Top 10 Orders with Highest Shipping Cost
SELECT
order_id,
ROUND(SUM(shipping_cost),2) AS shipping_cost
FROM retail.orders
GROUP BY order_id
ORDER BY shipping_cost DESC
LIMIT 10;


--16. Top 10 Countries by Shipping Cost
SELECT
country,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY country
ORDER BY total_shipping_cost DESC
LIMIT 10;


--17. Top 10 Cities by Shipping Cost
SELECT
city,
ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail.orders
GROUP BY city
ORDER BY total_shipping_cost DESC
LIMIT 10;


--18. Delivery Days Distribution
SELECT
delivery_days,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY delivery_days
ORDER BY delivery_days;


--19. Shipping Cost per Order
SELECT
ROUND(
SUM(shipping_cost) /
COUNT(DISTINCT order_id),
2
) AS avg_shipping_cost_per_order
FROM retail.orders;


--20. Shipping Cost as Percentage of Sales
SELECT
ROUND(
SUM(shipping_cost) * 100 /
SUM(sales),
2
) AS shipping_cost_percentage
FROM retail.orders;


/* Business Questions Answered

This module helps answer:

Which shipping mode is the most expensive?
Which shipping mode is the fastest?
Which markets incur the highest shipping costs?
How do shipping costs vary by category and customer segment?
Which orders have exceptionally high shipping costs?
What percentage of total sales is spent on shipping?

*/