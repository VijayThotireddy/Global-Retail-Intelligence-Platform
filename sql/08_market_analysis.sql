/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 08 - Market Analysis
Author  : Vijay Ram

Objective:
Analyze geographical performance across markets,
regions, countries, states, and cities to identify
growth opportunities and underperforming areas.
===========================================================
*/


--1. Sales by Market
SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY market
ORDER BY total_sales DESC;


--2. Profit by Market
SELECT
    market,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY market
ORDER BY total_profit DESC;


--3. Profit Margin by Market
SELECT
    market,
    ROUND((SUM(profit) / SUM(sales)) * 100,2) AS profit_margin
FROM retail.orders
GROUP BY market
ORDER BY profit_margin DESC;


--4. Sales by Region
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY region
ORDER BY total_sales DESC;


--5. Profit by Region
SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY region
ORDER BY total_profit DESC;



--6. Top 10 Countries by Sales
SELECT
    country,
    ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY country
ORDER BY total_sales DESC
LIMIT 10;


--7. Top 10 Countries by Profit
SELECT
    country,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY country
ORDER BY total_profit DESC
LIMIT 10;


--8. Bottom 10 Countries by Profit
SELECT
    country,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY country
ORDER BY total_profit
LIMIT 10;


--9. Top 10 States by Sales
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;


--10. Top 10 States by Profit
SELECT
    state,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;


--11. Top 10 Cities by Sales
SELECT
    city,
    ROUND(SUM(sales),2) AS total_sales
FROM retail.orders
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;


--12. Top 10 Cities by Profit
SELECT
    city,
    ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY city
ORDER BY total_profit DESC
LIMIT 10;


--13. Number of Customers by Market
SELECT
    market,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail.orders
GROUP BY market
ORDER BY total_customers DESC;


--14. Average Sales per Country
SELECT
    country,
    ROUND(AVG(sales),2) AS avg_sales
FROM retail.orders
GROUP BY country
ORDER BY avg_sales DESC
LIMIT 10;


--15. Average Profit per Country
SELECT
    country,
    ROUND(AVG(profit),2) AS avg_profit
FROM retail.orders
GROUP BY country
ORDER BY avg_profit DESC
LIMIT 10;


--16. Market Contribution to Total Sales
SELECT
    market,
    ROUND(
        SUM(sales) * 100 /
        SUM(SUM(sales)) OVER (),
    2) AS sales_percentage
FROM retail.orders
GROUP BY market
ORDER BY sales_percentage DESC;


--17. Market Contribution to Total Profit
SELECT
    market,
    ROUND(
        SUM(profit) * 100 /
        SUM(SUM(profit)) OVER (),
    2) AS profit_percentage
FROM retail.orders
GROUP BY market
ORDER BY profit_percentage DESC;


--18. Orders by Country
SELECT
    country,
    COUNT(DISTINCT order_id) AS total_orders
FROM retail.orders
GROUP BY country
ORDER BY total_orders DESC
LIMIT 10;


--19. Average Shipping Cost by Market
SELECT
    market,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM retail.orders
GROUP BY market
ORDER BY avg_shipping_cost DESC;



--20. Market Ranking by Sales
SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS market_rank
FROM retail.orders
GROUP BY market;




/* Business Questions Answered

This module helps answer:

Which market generates the most revenue?
Which market is the most profitable?
Which countries should receive more investment?
Which regions are underperforming?
Which cities drive the business?
Which markets have the highest customer base?
Which geographical areas have the best profit margins?
*/