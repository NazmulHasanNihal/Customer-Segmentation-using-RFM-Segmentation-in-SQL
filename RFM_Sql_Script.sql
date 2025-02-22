-- Creating Database
CREATE DATABASE superstore_sales;

-- Using superstore_sales Database
USE superstore_sales;

-- Exploring Data

-- Basic Overview of the Table
SELECT
    COUNT(*) AS TotalValues
FROM
    sales_data;

-- Columns Data Types
DESCRIBE sales_data;

-- Summarizing Sales Data
SELECT
    MIN(sales) AS MinSales,
    MAX(sales) AS MaxSales,
    AVG(sales) AS AvgSales,
    SUM(sales) AS TotalSales
FROM sales_data;


-- Checking Unique Values in a Column
SELECT
    DISTINCT customer_segment
FROM
    sales_data;

-- Counting the Orders of per Customer
SELECT
    customer_id,
    COUNT(*) AS OrderCount
FROM
    sales_data
GROUP BY
    customer_id
ORDER BY
    OrderCount DESC
    LIMIT 10;

-- Average Sales by Product Category

SELECT
    product_category,
    ROUND(AVG(sales), 2) AS AvgSales
FROM
    sales_data
GROUP BY
    product_category
ORDER BY
    AvgSales DESC;


-- Sales and Profit Comparison
SELECT
    ROUND(SUM(sales), 2)
        AS TotalSales,
    ROUND(SUM(profit), 2)
        AS TotalProfit
FROM
    sales_data;


-- Orders in Different Ship Modes
SELECT
    ship_mode,
    COUNT(*)
        AS OrderCount
FROM
    sales_data
GROUP BY
    ship_mode
ORDER BY
    OrderCount DESC;


-- Sales by Region
SELECT
    region,
    ROUND(SUM(sales),2)
        AS TotalSales
FROM
    sales_data
GROUP BY
    region
ORDER BY
    TotalSales DESC;


-- Sales and Profit by Customer Segment
SELECT
    customer_segment,
    ROUND(SUM(sales), 2)
        AS TotalSales,
    ROUND(SUM(profit), 2)
        AS TotalProfit
FROM
    sales_data
GROUP BY
    customer_segment
ORDER BY
    TotalSales DESC;


-- Top Customers by Sales
SELECT
    customer_id,
    ROUND(SUM(Sales),2)
        AS TotalSales
FROM
    sales_data
GROUP BY
    customer_id
ORDER BY
    TotalSales DESC
    LIMIT 10;


-- Counting AVG Order Shipped Per Day
SELECT
    ROUND(AVG(OrdersShipped),2) AS AvgOrdersShippedPerDay
FROM (
         SELECT
             ship_date,
             COUNT(*) AS OrdersShipped
         FROM
             sales_data
         GROUP BY
             ship_date
     ) AS DailyOrders;


-- Total Sales by State or Province
SELECT
    state_or_province,
    ROUND(SUM(sales),2)
        AS TotalSales
FROM
    sales_data
GROUP BY
    state_or_province
ORDER BY
    TotalSales DESC
    LIMIT 10;


-- Customer Segmentation by Frequency of Orders
SELECT
    customer_id,
    COUNT(*) AS OrderFrequency,
    CASE
        WHEN COUNT(*) = 1 THEN 'One-time'
        WHEN COUNT(*) BETWEEN 2 AND 5 THEN 'Frequent'
        ELSE 'Very Frequent'
        END AS FrequencySegment
FROM sales_data
GROUP BY customer_id
ORDER BY OrderFrequency DESC
    LIMIT 10;


-- Sales Distribution by Order Priority
SELECT order_priority, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY order_priority;


-- Cleaning Data


-- Checking the Missing Values
SELECT
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS MissingOrderDate,
    SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS MissingShipDate,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS MissingProfit,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS MissingSales,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS MissingCustomerID,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS MissingCustomerName,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS MissingProductCategory
FROM sales_data;


-- Converting Order Date and Shipping Date Invalid Date Format

SELECT DATE_ADD('1900-01-01', INTERVAL 41057 DAY) AS calculated_date;

UPDATE sales_data
SET order_date = DATE_ADD('1900-01-01', INTERVAL order_date DAY)
WHERE order_date REGEXP '^[0-9]+$';

UPDATE sales_data
SET ship_date = DATE_ADD('1900-01-01', INTERVAL ship_date DAY)
WHERE ship_date REGEXP '^[0-9]+$';

-- Converting Other Columns with Proper Format
ALTER TABLE sales_data
    MODIFY COLUMN order_date DATE;
ALTER TABLE sales_data
    MODIFY COLUMN ship_date DATE;
ALTER TABLE sales_data
    MODIFY COLUMN return_status VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN order_id INTEGER;
ALTER TABLE sales_data
    MODIFY COLUMN sales DOUBLE;
ALTER TABLE sales_data
    MODIFY COLUMN quantity_ordered_new INTEGER;
ALTER TABLE sales_data
    MODIFY COLUMN profit DOUBLE;
ALTER TABLE sales_data
    MODIFY COLUMN postal_code INTEGER;
ALTER TABLE sales_data
    MODIFY COLUMN city VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN state_or_province VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN manager VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN region VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN product_base_margin DOUBLE;
ALTER TABLE sales_data
    MODIFY COLUMN quantity_ordered_new VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN product_name VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN product_container VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN product_sub_category VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN product_category VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN customer_segment VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN ship_mode VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN customer_name VARCHAR(255);
ALTER TABLE sales_data
    MODIFY COLUMN order_priority VARCHAR(255);

-- Setting for Consistent Categories
SET SQL_SAFE_UPDATES = 0;
UPDATE sales_data
SET order_priority = CASE
                         WHEN order_priority = 'Critical' THEN 'High'
                         WHEN order_priority = 'Critical ' THEN 'High'
                         WHEN order_priority = 'High' THEN 'High'
                         WHEN order_priority = 'Medium' THEN 'Medium'
                         WHEN order_priority = 'Low' THEN 'Low'
                         ELSE 'Low'
    END
WHERE order_priority IN ('Critical', 'Critical ', 'High', 'Medium', 'Low', 'Not Specified');



SELECT order_priority, COUNT(*) AS priority_count
FROM sales_data
GROUP BY order_priority;

-- Data Integrity Checking
UPDATE sales_data
SET ship_date = order_date
WHERE ship_date < order_date;

-- Exploratory Data Analysis (EDA)

-- Descriptive Statistics for Sales and Profit
SELECT
    ROUND(MIN(sales), 2) AS MinSales,
    ROUND(MAX(sales), 2) AS MaxSales,
    ROUND(AVG(sales), 2) AS AvgSales,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(MIN(profit), 2) AS MinProfit,
    ROUND(MAX(profit), 2) AS MaxProfit,
    ROUND(AVG(profit), 2) AS AvgProfit,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM sales_data;

-- Distribution of Sales by Product Category
SELECT product_category, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_category
ORDER BY TotalSales DESC;


-- Sales and Profit by Region
SELECT region, ROUND(SUM(sales), 2) AS TotalSales, ROUND(SUM(profit), 2) AS TotalProfit
FROM sales_data
GROUP BY region
ORDER BY TotalSales DESC;


-- Average Sales by Order Priority
SELECT order_priority, AVG(sales) AS AvgSales
FROM sales_data
GROUP BY order_priority
ORDER BY AvgSales DESC;


-- Sales by Ship Mode
SELECT ship_mode, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY ship_mode
ORDER BY TotalSales DESC;

-- Customer Segmentation by Order Frequency
SELECT
    FrequencySegment,
    COUNT(*) AS CustomerCount
FROM (
         SELECT
             customer_id,
             CASE
                 WHEN COUNT(*) = 1 THEN 'One-time'
                 WHEN COUNT(*) BETWEEN 2 AND 5 THEN 'Frequent'
                 ELSE 'Very Frequent'
                 END AS FrequencySegment
         FROM sales_data
         GROUP BY customer_id
     ) AS CustomerFrequency
GROUP BY FrequencySegment
ORDER BY CustomerCount DESC;

-- Count of Orders by Return Status
SELECT return_status, COUNT(*) AS OrderCount
FROM sales_data
GROUP BY return_status;

-- Sales by State or Province
SELECT state_or_province, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY state_or_province
ORDER BY TotalSales DESC;


-- Average Sales by Customer Segment
SELECT customer_segment, AVG(sales) AS AvgSales
FROM sales_data
GROUP BY customer_segment
ORDER BY AvgSales DESC;


-- Total Sales by Product Sub-Category
SELECT product_sub_category, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_sub_category
ORDER BY TotalSales DESC;


-- Average Sales by Product Container
SELECT product_container, ROUND(AVG(sales), 2) AS AvgSales
FROM sales_data
GROUP BY product_container
ORDER BY AvgSales DESC;

-- Finding the top 10 products based on sales
SELECT product_name, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_name
ORDER BY TotalSales DESC
    LIMIT 10;



-- RFM Segmentation

-- Creating a Common Table Expression (CTE) to calculate Recency, Frequency, and Monetary
WITH RFM AS (
    SELECT
        customer_id,

        MIN(DATEDIFF(CURRENT_DATE, ship_date)) AS Recency,

        COUNT(order_id) AS Frequency,

        ROUND(SUM(sales), 2) AS Monetary
    FROM sales_data
    GROUP BY customer_id
)

SELECT * FROM RFM;

-- RFM Scoring System

WITH RFM AS (
    SELECT
        customer_id,
        MIN(DATEDIFF(CURRENT_DATE, ship_date)) AS Recency,
        COUNT(order_id) AS Frequency,
        ROUND(SUM(Sales), 2) AS Monetary
    FROM sales_data
    GROUP BY customer_id
),
     RFM_Scored AS (
         SELECT
             customer_id,
             Recency,
             Frequency,
             Monetary,

             CASE
                 WHEN Recency <= 30 THEN 5
                 WHEN Recency <= 60 THEN 4
                 WHEN Recency <= 90 THEN 3
                 WHEN Recency <= 180 THEN 2
                 ELSE 1
                 END AS RecencyScore,

             CASE
                 WHEN Frequency >= 10 THEN 5
                 WHEN Frequency >= 7 THEN 4
                 WHEN Frequency >= 5 THEN 3
                 WHEN Frequency >= 3 THEN 2
                 ELSE 1
                 END AS FrequencyScore,

             CASE
                 WHEN Monetary >= 1000 THEN 5
                 WHEN Monetary >= 500 THEN 4
                 WHEN Monetary >= 200 THEN 3
                 WHEN Monetary >= 100 THEN 2
                 ELSE 1
                 END AS MonetaryScore
         FROM RFM
     )

SELECT
    customer_id,
    Recency,
    Frequency,
    Monetary,
    RecencyScore,
    FrequencyScore,
    MonetaryScore,
    (RecencyScore + FrequencyScore + MonetaryScore) AS RMFScore
FROM RFM_Scored
ORDER BY RMFScore DESC;














