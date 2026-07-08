-- =====================================================
-- Project : Global Retail Intelligence Platform
-- File    : 01_database_setup.sql
-- Author  : Vijaya Rami Reddy
-- =====================================================

-- Create Schema
CREATE SCHEMA IF NOT EXISTS retail;

-- Drop table if it already exists
DROP TABLE IF EXISTS retail.orders;

-- Create Orders Table
CREATE TABLE retail.orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(30),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(150),
    country VARCHAR(100),
    region VARCHAR(100),
    market VARCHAR(100),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(100),
    product_name TEXT,
    sales NUMERIC(12,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(12,2),
    shipping_cost NUMERIC(12,2),
    order_priority VARCHAR(30),
    delivery_days INT,
    order_year INT,
    order_month INT,
    month_name VARCHAR(20),
    quarter INT,
    weekday VARCHAR(20),
    profit_margin NUMERIC(10,2),
    is_loss_order VARCHAR(5),
    discount_category VARCHAR(20)
);