/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 09 - Executive KPIs
Author  : Vijay Ram

Objective:
create a  executive-level KPIs and summary metrics
for the Power BI dashboard.
===========================================================
*/


--1. Executive KPI Summary
SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(AVG(sales),2) AS avg_sales_per_record;


--2. Profit Margin
SELECT
ROUND(
(SUM(profit)/SUM(sales))*100,
2
) AS overall_profit_margin
FROM retail.orders;


--3. Average Order Value (AOV)
SELECT
ROUND(
SUM(sales)/COUNT(DISTINCT order_id),
2
) AS average_order_value
FROM retail.orders;


--4. Average Profit per Order
SELECT
ROUND(
SUM(profit)/COUNT(DISTINCT order_id),
2
) AS average_profit_per_order
FROM retail.orders;



--5. Average Shipping Cost per Order
SELECT
ROUND(
SUM(shipping_cost)/COUNT(DISTINCT order_id),
2
) AS avg_shipping_cost_per_order
FROM retail.orders;



--6. Average Delivery Days
SELECT
ROUND(
AVG(delivery_days),
2
) AS avg_delivery_days
FROM retail.orders;


--7. Total Loss Orders
SELECT
COUNT(*) AS loss_orders
FROM retail.orders
WHERE is_loss_order='Yes';



--8. Loss Order Percentage
SELECT
ROUND(
COUNT(*)*100.0/
(SELECT COUNT(*) FROM retail.orders),
2
) AS loss_order_percentage
FROM retail.orders
WHERE is_loss_order='Yes';


--9. Revenue by Year
SELECT
order_year,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY order_year
ORDER BY order_year;


--10. Profit by Year
SELECT
order_year,
ROUND(SUM(profit),2) AS profit
FROM retail.orders
GROUP BY order_year
ORDER BY order_year;


--11. Best Performing Market
SELECT
market,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY market
ORDER BY revenue DESC
LIMIT 1;


--12. Best Performing Category
SELECT
category,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;


--13. Best Customer
SELECT
customer_name,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 1;



--14. Best Product
SELECT
product_name,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 1;


--15. Best Country
SELECT
country,
ROUND(SUM(sales),2) AS revenue
FROM retail.orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 1;


--16. Sales vs Profit
SELECT
ROUND(SUM(sales),2) AS sales,
ROUND(SUM(profit),2) AS profit;


--17. Profitability Ratio
SELECT
ROUND(
SUM(profit)/SUM(sales),
4
) AS profitability_ratio
FROM retail.orders;


--18. Average Discount
SELECT
ROUND(
AVG(discount)*100,
2
) AS avg_discount_percentage
FROM retail.orders;


--19. Total Shipping Cost
SELECT
ROUND(
SUM(shipping_cost),
2
) AS total_shipping_cost
FROM retail.orders;


--20. Executive Dashboard Dataset
SELECT
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT customer_id) AS customers,
COUNT(DISTINCT product_id) AS products,
ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin,
ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value,
ROUND(AVG(delivery_days),2) AS average_delivery_days
FROM retail.orders;


/*KPIs we 'll Display in Power BI

These queries provides us the metrics for KPI cards such as:

Total Sales
Total Profit
Total Orders
 Total Customers
Total Products
Profit Margin %
Average Order Value
Average Delivery Days
Loss Orders
Total Shipping Cost


*/