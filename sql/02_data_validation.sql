/*
===========================================================
Project : Global Retail Intelligence Platform
Module  : 02 - Data Validation
Author  : Vijay Rami Reddy

Objective:
Validate data quality before business analysis.
===========================================================
*/

--1.Total Records
-- Business Qns : How many records are avail for analysis ?
SELECT COUNT(*) AS total_records
FROM retail.orders;

-- Expected : 5129

-- 2.Total col's
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='retail'
AND table_name='orders';
--exp : 33
-- Businesss insight : Verifies the table structure matches the cleaned dataset


--3.Missing values
SELECT
COUNT(*) AS total_rows,
COUNT(order_id) AS order_id,
COUNT(customer_id) AS customer_id,
COUNT(product_id) AS product_id,
COUNT(sales) AS sales,
COUNT(profit) AS profit,
COUNT(country) AS country
FROM retail.orders;

--Expected : All counts should equal 51290
--Bi : Critical business col's contains no missing values.

--4.Duplicate Primary Keys
SELECT
row_id,
COUNT(*)
FROM retail.orders
GROUP BY row_id
HAVING COUNT(*) > 1;

--Expected
--No rows returned.
--Business Insight
--Confirms every transaction is uniquely identified.


--5.Duplicate Order IDs
SELECT
order_id,
COUNT(*)
FROM retail.orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

--Expected :Returns multiple rows.
-- Business Insight : This is expected because a single order can contain multiple products (multiple line items).


--6.Date Range
SELECT
MIN(order_date) AS first_order,
MAX(order_date) AS last_order
FROM retail.orders;

--Expected : 2012-01-01 2015-12-31
--Business Insight : The dataset covers four years of retail transactions.

--7.Orders by Year
SELECT
order_year,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY order_year
ORDER BY order_year;

--Business Insight : Shows yearly transaction volume and verifies every year has data.

--8.Distinct Customers
SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM retail.orders;

--Expected : Around 17,000+ unique customers.

--9.Distinct Products
SELECT
COUNT(DISTINCT product_id) AS total_products
FROM retail.orders;

--Expected: 3788


--10.Countries
SELECT
COUNT(DISTINCT country) AS total_countries
FROM retail.orders;

Expected: 165


--11.Markets
SELECT
market,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY market
ORDER BY total_orders DESC;

--This verifies that all markets are represented in the data.

--12. Categories
SELECT
category,
COUNT(*) AS total_orders
FROM retail.orders
GROUP BY category
ORDER BY total_orders DESC;

--Expected categories: Office Supplies, Technology, Furniture
