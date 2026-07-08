/*This module ans:

Which products generate the highest revenue?
Which products generate the highest profit?
Which products are causing losses?
Which categories and sub-categories perform best?
Which products need management attention? */


/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 05 - Product Analysis
Author  : Vijay Ram

Objective:
Analyze product performance, category contribution,
profitability, and identify high and low performers.
===========================================================
*/


--1. Total Products
SELECT
COUNT(DISTINCT product_id) AS total_products
FROM retail.orders;


--2. Sales by Category
SELECT
category,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY category
ORDER BY revenue DESC;


--3. Profit by Category
SELECT
category,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY category
ORDER BY profit DESC;


--4. Sales by Sub-Category
SELECT
sub_category,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY sub_category
ORDER BY revenue DESC;



--5. Profit by Sub-Category
SELECT
sub_category,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY sub_category
ORDER BY profit DESC;



--6. Top 10 Products by Sales
SELECT
product_id,
product_name,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY product_id, product_name
ORDER BY revenue DESC
LIMIT 10;



--7. Top 10 Products by Profit
SELECT
product_id,
product_name,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY product_id, product_name
ORDER BY profit DESC
LIMIT 10;


--8. Top 10 Products by Quantity Sold
SELECT
product_id,
product_name,
SUM(quantity) AS total_quantity
FROM retail.orders
GROUP BY product_id, product_name
ORDER BY total_quantity DESC
LIMIT 10;



--9. Top 10 Loss-Making Products
SELECT
product_id,
product_name,
ROUND(SUM(profit),2) AS total_loss
FROM retail.orders
GROUP BY product_id, product_name
HAVING SUM(profit) < 0
ORDER BY total_loss
LIMIT 10;


--10. Products with Highest Discount
SELECT
product_name,
MAX(discount) AS highest_discount
FROM retail.orders
GROUP BY product_name
ORDER BY highest_discount DESC
LIMIT 10;



--11. Average Profit Margin by Category
SELECT
category,
ROUND(AVG(profit_margin),2) AS avg_profit_margin
FROM retail.orders
GROUP BY category
ORDER BY avg_profit_margin DESC;


--12. Average Profit Margin by Sub-Category
SELECT
sub_category,
ROUND(AVG(profit_margin),2) AS avg_profit_margin
FROM retail.orders
GROUP BY sub_category
ORDER BY avg_profit_margin DESC;


--13. Revenue Contribution by Category
SELECT
category,
ROUND(
SUM(sales) * 100 /
SUM(SUM(sales)) OVER (),
2
) AS revenue_percentage
FROM retail.orders
GROUP BY category
ORDER BY revenue_percentage DESC;


--14. Revenue Contribution by Sub-Category
SELECT
sub_category,
ROUND(
SUM(sales) * 100 /
SUM(SUM(sales)) OVER (),
2
) AS revenue_percentage
FROM retail.orders
GROUP BY sub_category
ORDER BY revenue_percentage DESC;


--15. Products Sold in Multiple Markets
SELECT
product_name,
COUNT(DISTINCT market) AS markets
FROM retail.orders
GROUP BY product_name
ORDER BY markets DESC
LIMIT 20;



--16. Products with Negative Profit Margin
SELECT
product_name,
ROUND(SUM(profit),2) AS total_profit
FROM retail.orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;


--17. Average Selling Price per Product
SELECT
product_name,
ROUND(
SUM(sales) / SUM(quantity),
2
) AS avg_selling_price
FROM retail.orders
GROUP BY product_name
ORDER BY avg_selling_price DESC
LIMIT 20;



--18. Product Ranking by Revenue
SELECT
product_name,
ROUND(SUM(sales),2) AS revenue,
RANK() OVER (
ORDER BY SUM(sales) DESC
) AS product_rank
FROM retail.orders
GROUP BY product_name;


--19. Products Never Sold at a Discount
SELECT
product_name
FROM retail.orders
GROUP BY product_name
HAVING MAX(discount) = 0;


--20. High Revenue but Low Profit Products
SELECT
product_name,
ROUND(SUM(sales),2) AS revenue,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY product_name
HAVING SUM(sales) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(sales) AS total_sales
        FROM retail.orders
        GROUP BY product_name
    ) t
)
AND SUM(profit) < (
    SELECT AVG(total_profit)
    FROM (
        SELECT SUM(profit) AS total_profit
        FROM retail.orders
        GROUP BY product_name
    ) t
)
ORDER BY revenue DESC;
