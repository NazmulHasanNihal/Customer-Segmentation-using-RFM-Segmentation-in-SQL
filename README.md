# Customer Segmentation using RFM Segmentation in SQL
Customer segmentation using RFM analysis on Superstore Sales Data. Cleaned data, performed exploratory analysis, and segmented customers based on Recency, Frequency, and Monetary metrics in SQL. Visualized findings and shared insights.

## Creating Database
```mysql
CREATE DATABASE superstore_sales;
```

## Selecting Database
```mysql
USE superstore_sales
```
**This query will help to select necessary database we want between multiple databases**

## Creating Table in Database
```mysql
CREATE TABLE sales_data (
row_id INT,
order_priority VARCHAR(255),
discount DOUBLE,
unit_price DOUBLE,
shipping_cost DOUBLE,        
customer_id INT,            
customer_name VARCHAR(255), 
ship_mode VARCHAR(255),   
customer_segment VARCHAR(255),
product_category VARCHAR(255),
product_subcategory VARCHAR(255), 
product_container VARCHAR(255),
product_name VARCHAR(255), 
product_base_margin DOUBLE,
region VARCHAR(255),
manager VARCHAR(255),
state_or_province VARCHAR(255),
city VARCHAR(255),
postal_code INT,          
order_date DATE,          
ship_date DATE,           
profit DOUBLE,
quantity_ordered INT,     
sales DOUBLE,
order_id INT,             
return_status VARCHAR(255)
);
```
**This query for creating the table manually but bulk insertion is used for table creating and inputting the data.**
## Exploring the Data
### Basic Overview of the Table
```mysql
SELECT
    COUNT(*) AS TotalValues
FROM
    sales_data;
```
**Output:**
```text
+-----------+
|TotalValues|
+-----------+
|9426       |
+-----------+
```
**This will return the total number of entries in your `sales_data` table.**

### Columns Data Types
```mysql
DESCRIBE sales_data;
```
**Output:**
```text
+--------------------+------+----+---+-------+-----+
|Field               |Type  |Null|Key|Default|Extra|
+--------------------+------+----+---+-------+-----+
|row_id              |int   |YES |   |null   |     |
|order_priority      |text  |YES |   |null   |     |
|discount            |double|YES |   |null   |     |
|unit_price          |double|YES |   |null   |     |
|shipping_cost       |double|YES |   |null   |     |
|customer_id         |int   |YES |   |null   |     |
|customer_name       |text  |YES |   |null   |     |
|ship_mode           |text  |YES |   |null   |     |
|customer_segment    |text  |YES |   |null   |     |
|product_category    |text  |YES |   |null   |     |
|product_sub_category|text  |YES |   |null   |     |
|product_container   |text  |YES |   |null   |     |
|product_name        |text  |YES |   |null   |     |
|product_base_margin |text  |YES |   |null   |     |
|region              |text  |YES |   |null   |     |
|manager             |text  |YES |   |null   |     |
|state_or_province   |text  |YES |   |null   |     |
|city                |text  |YES |   |null   |     |
|postal_code         |text  |YES |   |null   |     |
|order_date          |text  |YES |   |null   |     |
|ship_date           |text  |YES |   |null   |     |
|profit              |text  |YES |   |null   |     |
|quantity_ordered_new|text  |YES |   |null   |     |
|sales               |text  |YES |   |null   |     |
|order_id            |text  |YES |   |null   |     |
|return_status       |text  |YES |   |null   |     |
+--------------------+------+----+---+-------+-----+

```
**This will provide meta-data about each column, such as its name, data type, whether it can be NULL, and any default values.**

### Summarizing Sales Data
```mysql
SELECT
    MIN(sales) AS MinSales,
    MAX(sales) AS MaxSales,
    AVG(sales) AS AvgSales,
    SUM(sales) AS TotalSales
FROM sales_data;
```
**Output:**
```text
+--------+--------+----------------+-----------------+
|MinSales|MaxSales|AvgSales        |TotalSales       |
+--------+--------+----------------+-----------------+
|1.32    |9984.85 |949.697596011036|8951849.540000025|
+--------+--------+----------------+-----------------+
```
**Getting basic statistics for the Sales column, such as minimum, maximum, average, and total sales.**

### Checking Unique Values in a Column
```mysql
SELECT 
    DISTINCT customer_segment
FROM 
    sales_data
```
**Output:**
```text
+----------------+
|customer_segment|
+----------------+
|Corporate       |
|Home Office     |
|Small Business  |
|Consumer        |
+----------------+
```
**Check how many unique values exist in a specific column, such as `customer_segment`.**

### Counting the Orders of per Customer 
```mysql
SELECT 
    customer_id, 
       COUNT(*) AS OrderCount
FROM 
    sales_data
GROUP BY 
    customer_id
ORDER BY 
    OrderCount DESC;
```
**Output:**
```text
+-----------+----------+
|customer_id|OrderCount|
+-----------+----------+
|1193       |27        |
|699        |26        |
|2491       |22        |
|2107       |22        |
|2882       |21        |
|308        |21        |
|3079       |20        |
|272        |19        |
|1999       |19        |
|1723       |18        |
+-----------+----------+
```
**This will give an idea of which customers are making the most orders. We extract top 10 results.**

### Average Sales by Product Category
```mysql
SELECT
    product_category,
    ROUND(AVG(sales), 2) AS AvgSales
FROM
    sales_data
GROUP BY
    product_category
ORDER BY
    AvgSales DESC;
```
**Output:**
```text
+----------------+--------+
|product_category|AvgSales|
+----------------+--------+
|Furniture       |1644.4  |
|Technology      |1520.32 |
|Office Supplies |435.87  |
+----------------+--------+
```
**This will help in understanding which categories generate the highest average sales.**

### Sales and Profit Comparison
```mysql
SELECT
    ROUND(SUM(sales), 2)
        AS TotalSales,
    ROUND(SUM(profit), 2)
        AS TotalProfit
FROM
    sales_data;
```
**Ouput:**
```text
+----------+-----------+
|TotalSales|TotalProfit|
+----------+-----------+
|8951849.54|1312442.4  |
+----------+-----------+
```
**The relationship between total sales and the profit generated.**

### Orders in Different Shipping Modes
```mysql
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
```
**Output:**
```text
+--------------+----------+
|ship_mode     |OrderCount|
+--------------+----------+
|Regular Air   |7036      |
|Delivery Truck|1283      |
|Express Air   |1107      |
+--------------+----------+
```
**This give insights of shipping methods are most commonly used.**

### Sales by Region
```mysql
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
```
**Output:**
```text
+-------+----------+
|region |TotalSales|
+-------+----------+
|Central|2540341.62|
|East   |2422804.68|
|West   |2391357.02|
|South  |1597346.22|
+-------+----------+
```
**This will provide the total sales by each region, helping us understand regional performance.**

### Sales and Profit by Customer Segment
```mysql
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
```
**Output:**
```text
+----------------+----------+-----------+
|customer_segment|TotalSales|TotalProfit|
+----------------+----------+-----------+
|Corporate       |3269391.07|505538.63  |
|Home Office     |2168952.03|283869.55  |
|Consumer        |1835215.22|206559.63  |
|Small Business  |1678291.22|316474.59  |
+----------------+----------+-----------+
```
**This helps us to evaluate the performance of different customer segments.**

### Top Customers by Sales
```mysql
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
```
**Output:**
```text
+-----------+----------+
|customer_id|TotalSales|
+-----------+----------+
|3075       |123745.62 |
|308        |89269.7   |
|2571       |86540.75  |
|2107       |83651.7   |
|553        |81296.39  |
|1733       |78243.6   |
|640        |69118     |
|1999       |61610.6   |
|2867       |61298.98  |
|349        |58947.41  |
+-----------+----------+
```
**Finding the top 10 customers who contributed the most to the sales**

### Count of Orders per Shipping Date
```mysql
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
```
**Output:**
```text
+----------------------+
|AvgOrdersShippedPerDay|
+----------------------+
|6.50                  |
+----------------------+
```
**This will help to understand how many orders are being shipped on Average in a specific day.**

### Total Sales by State or Province
```mysql
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
```
**Output:**
```text
+-----------------+----------+
|state_or_province|TotalSales|
+-----------------+----------+
|California       |1161639.06|
|New York         |839593.73 |
|Illinois         |667797.16 |
|Texas            |543089    |
|Washington       |508816.41 |
|Florida          |503609.51 |
|Michigan         |324593.62 |
|Pennsylvania     |297371.7  |
|Ohio             |290286.12 |
|Massachusetts    |228451.71 |
+-----------------+----------+
```
**This gives us an idea of which states or provinces have the highest sales.**

### Customer Segmentation by Frequency of Orders
```mysql
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
```
**Output:**
```text
+-----------+--------------+----------------+
|customer_id|OrderFrequency|FrequencySegment|
+-----------+--------------+----------------+
|1193       |27            |Very Frequent   |
|699        |26            |Very Frequent   |
|2491       |22            |Very Frequent   |
|2107       |22            |Very Frequent   |
|2882       |21            |Very Frequent   |
|308        |21            |Very Frequent   |
|3079       |20            |Very Frequent   |
|272        |19            |Very Frequent   |
|1999       |19            |Very Frequent   |
|1723       |18            |Very Frequent   |
+-----------+--------------+----------------+
```
**This helps to segment customers based on their order frequency.**

### Sales Distribution by Order Priority
```mysql
SELECT order_priority, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY order_priority;
```
**Output:**
```text
+--------------+----------+
|order_priority|TotalSales|
+--------------+----------+
|Not Specified |1766201.43|
|High          |2003067.78|
|Medium        |1612777.88|
|Low           |1901843.09|
|Critical      |1667834.55|
|Critical      |124.81    |
+--------------+----------+
```
**This shows how different order priorities by High and Low contribute to the total sales.**

## Data Cleaning
```mysql
SELECT
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS MissingOrderDate,
    SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS MissingShipDate,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS MissingProfit,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS MissingSales,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS MissingCustomerID,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS MissingCustomerName,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS MissingProductCategory
FROM sales_data;
```
**Output:**
```text
+----------------+---------------+-------------+------------+-----------------+-------------------+----------------------+
|MissingOrderDate|MissingShipDate|MissingProfit|MissingSales|MissingCustomerID|MissingCustomerName|MissingProductCategory|
+----------------+---------------+-------------+------------+-----------------+-------------------+----------------------+
|0               |0              |0            |0           |0                |0                  |0                     |
+----------------+---------------+-------------+------------+-----------------+-------------------+----------------------+
```
**This shows there is no missing values in the columns**

### Converting Order Date and Shipping Date Invalid Date Format
```mysql
SELECT DATE_ADD('1900-01-01', INTERVAL 41057 DAY) AS calculated_date;
```
**Output:**
```text
+---------------+
|calculated_date|
+---------------+
|2012-05-30     |
+---------------+
```
**This will help to convert `order_date` and `ship_date` to date format.**

>**Explanation of the Calculation:**
> * **Base Date: 1900-01-01**
> * **Days to Add: 41057**
> * **Resulting Date: 2022-05-01**

**Converting Order Date** 
```mysql
UPDATE sales_data
SET order_date = DATE_ADD('1900-01-01', INTERVAL order_date DAY)
WHERE order_date REGEXP '^[0-9]+$';  
```
**Converting Shipping Date**
```mysql
UPDATE sales_data
SET ship_date = DATE_ADD('1900-01-01', INTERVAL ship_date DAY)
WHERE ship_date REGEXP '^[0-9]+$';
```
**The `order_date` and `ship_data` was giving error for invalid date format to convert it into date format.This will help use convert the columns in date without any error.**

### Converting Other Columns with Proper Format
```mysql
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
```
**This will help to convert it columns proper necessary format.**

### Setting for Consistent Categories
```mysql
SET SQL_SAFE_UPDATES = 0; -- To disable safe updates
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
```
**Output:**
```text
+--------------+--------------+
|order_priority|priority_count|
+--------------+--------------+
|Low           |3807          |
|High          |3775          |
|Medium        |1844          |
+--------------+--------------+
```
**We Categorized into 3 main priority `High`, `Medium` and `Low` for easy analysis.**

### Data Integrity Checking
```mysql
UPDATE sales_data
SET ship_date = order_date
WHERE ship_date < order_date;
```
**Ensuring that `order_date` is not later than `ship_data`**

## Exploratory Data Analysis (EDA)

### Descriptive Statistics for Sales and Profit
```mysql
SELECT
    MIN(sales) AS MinSales,
    MAX(sales) AS MaxSales,
    AVG(sales) AS AvgSales,
    SUM(sales) AS TotalSales,
    MIN(profit) AS MinProfit,
    MAX(profit) AS MaxProfit,
    AVG(profit) AS AvgProfit,
    SUM(profit) AS TotalProfit
FROM sales_data;
```
**Output:**
```text
+--------+---------+--------+----------+---------+---------+---------+-----------+
|MinSales|MaxSales |AvgSales|TotalSales|MinProfit|MaxProfit|AvgProfit|TotalProfit|
+--------+---------+--------+----------+---------+---------+---------+-----------+
|1.32    |100119.16|949.7   |8951849.54|-16476.84|16332.41 |139.24   |1312442.4  |
+--------+---------+--------+----------+---------+---------+---------+-----------+
```
**Get basic statistics such as minimum, maximum, average, and sum for the `sales` and `profit` columns.**

### Distribution of Sales by Product Category
```mysql
SELECT product_category, ROUND(SUM(Sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_category
ORDER BY TotalSales DESC;
```
**Output:**
```text
+----------------+----------+
|product_category|TotalSales|
+----------------+----------+
|Technology      |3514982.03|
|Furniture       |3178623.74|
|Office Supplies |2258243.77|
+----------------+----------+
```
**Find the total sales for each `product_category` and see how sales are distributed among different categories.**

### Sales and Profit by Region
```mysql
SELECT region, ROUND(SUM(sales), 2) AS TotalSales, ROUND(SUM(profit), 2) AS TotalProfit
FROM sales_data
GROUP BY region
ORDER BY TotalSales DESC;
```
**Output:**
```text
+-------+----------+-----------+
|region |TotalSales|TotalProfit|
+-------+----------+-----------+
|Central|2540341.62|519825.57  |
|East   |2422804.68|377566.19  |
|West   |2391357.02|310849.45  |
|South  |1597346.22|104201.19  |
+-------+----------+-----------+
```
**Calculating the total `sales` and total `profit` by region**

### Average Sales by Order Priority
```mysql
SELECT order_priority, AVG(sales) AS AvgSales
FROM sales_data
GROUP BY order_priority
ORDER BY AvgSales DESC;
```
**Output:**
```text
+--------------+-----------------+
|order_priority|AvgSales         |
+--------------+-----------------+
|High          |972.4575205298033|
|Low           |963.5000052534799|
|Medium        |874.6083947939261|
+--------------+-----------------+
```
**Get the average sales for each `order_priority` level `High`, `Low`, `Medium`**

### Sales by Ship Mode
```mysql
SELECT ship_mode, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY ship_mode
ORDER BY TotalSales DESC;
```
**Output:**
```text
+--------------+----------+
|ship_mode     |TotalSales|
+--------------+----------+
|Regular Air   |4543577.18|
|Delivery Truck|3706516.02|
|Express Air   |701756.34 |
+--------------+----------+
```
**Finding sales distributed across different `ship_mode`**

### Customer Segmentation by Order Frequency
```mysql
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
```
**Output:**
```text
+----------------+-------------+
|FrequencySegment|CustomerCount|
+----------------+-------------+
|Frequent        |1228         |
|One-time        |897          |
|Very Frequent   |578          |
+----------------+-------------+
```
**Classifying customers by how often they place orders `One-time`, `Frequent`, `Very Frequent`)**

### Counting of Orders by Return Status
```mysql
SELECT return_status, COUNT(*) AS OrderCount
FROM sales_data
GROUP BY return_status;
```
**Output:**
```text
+-------------+----------+
|return_status|OrderCount|
+-------------+----------+
|Not Returned |9328      |
|Returned     |98        |
+-------------+----------+
```
**Getting the count of orders for each ReturnStatus to seeing how many orders were returned or not.**

### Sales by State or Province
```mysql
SELECT state_or_province, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY state_or_province
ORDER BY TotalSales DESC;
```
**Output:**
```text
+-----------------+----------+
|state_or_province|TotalSales|
+-----------------+----------+
|California       |1161639.06|
|New York         |839593.73 |
|Illinois         |667797.16 |
|Texas            |543089    |
|Washington       |508816.41 |
|Florida          |503609.51 |
|Michigan         |324593.62 |
|Pennsylvania     |297371.7  |
|Ohio             |290286.12 |
|Massachusetts    |228451.71 |
+-----------------+----------+
```
**Finding the total sales for each state or province**

### Average Sales by Customer Segment
```mysql
SELECT customer_segment, AVG(sales) AS AvgSales
FROM sales_data
GROUP BY customer_segment
ORDER BY AvgSales DESC;
```
**Output:**
```text
+----------------+-----------------+
|customer_segment|AvgSales         |
+----------------+-----------------+
|Consumer        |968.9626293558598|
|Corporate       |968.7084651851872|
|Home Office     |936.5077849740948|
|Small Business  |911.619348180336 |
+----------------+-----------------+
```
**Calculating the average sales for each customer segment**

### Total Sales by Product Sub-Category
```mysql
SELECT product_sub_category, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_sub_category
ORDER BY TotalSales DESC;
```
**Output:**
```text
+------------------------------+----------+
|product_sub_category          |TotalSales|
+------------------------------+----------+
|Office Machines               |1218656.59|
|Chairs & Chairmats            |1164584.16|
|Telephones and Communication  |1144272.98|
|Tables                        |1061921.06|
|Copiers and Fax               |661211.93 |
|Binders and Binder Accessories|638582.09 |
|Storage & Organization        |585704.91 |
|Bookcases                     |507494.49 |
|Computer Peripherals          |490840.53 |
|Appliances                    |456723.08 |
|Office Furnishings            |444624.03 |
|Paper                         |253600.31 |
|Envelopes                     |147921.03 |
|Pens & Art Supplies           |103169.81 |
|Scissors, Rulers and Trimmers |40428.87  |
|Labels                        |23449.9   |
|Rubber Bands                  |8663.77   |
+------------------------------+----------+
```
**Finding the total sales for each product sub-category**

### Average Sales by Product Container
```mysql
SELECT product_container, ROUND(AVG(sales), 2) AS AvgSales
FROM sales_data
GROUP BY product_container
ORDER BY AvgSales DESC;
```
**Output:**
```text
+-----------------+--------+
|product_container|AvgSales|
+-----------------+--------+
|Jumbo Drum       |3009.4  |
|Jumbo Box        |2698.04 |
|Large Box        |2598.49 |
|Medium Box       |1062.32 |
|Small Box        |637.53  |
|Small Pack       |302.88  |
|Wrap Bag         |139.13  |
+-----------------+--------+
```
**Calculating the average sales for each product container type**

### Finding the top 10 products based on sales
```mysql
SELECT product_name, ROUND(SUM(sales), 2) AS TotalSales
FROM sales_data
GROUP BY product_name
ORDER BY TotalSales DESC
LIMIT 10;
```
**Output:**
```text
+---------------------------------------------------------------------------+----------+
|product_name                                                               |TotalSales|
+---------------------------------------------------------------------------+----------+
|Global Troy™ Executive Leather Low-Back Tilter                             |194025.64 |
|Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish              |190195.15 |
|Canon imageCLASS 2200 Advanced Copier                                      |107697.73 |
|Canon PC1080F Personal Copier                                              |102932.77 |
|Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers                |102889.95 |
|Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind|102656.45 |
|Bretford CR8500 Series Meeting Room Furniture                              |101797.12 |
|Polycom ViewStation™ ISDN Videoconferencing Unit                           |92916.02  |
|Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables          |92208.46  |
|Sharp AL-1530CS Digital Copier                                             |86057.24  |
+---------------------------------------------------------------------------+----------+
```
**Finding the top 10 products based on sales**

## RFM Segmentation

### Calculating Recency, Frequency, and Monetary
```mysql
WITH RFM AS (
    SELECT
        customer_id,

        FLOOR(MIN(DATEDIFF(CURRENT_DATE, ship_date)) / 365) AS RecencybyYear,

        COUNT(order_id) AS Frequency,

        ROUND(SUM(sales), 2) AS Monetary
    FROM sales_data
    GROUP BY customer_id
)

SELECT * FROM RFM;
```
**Output:**
```text
+-----------+-------+---------+--------+
|customer_id|Recency|Frequency|Monetary|
+-----------+-------+---------+--------+
|2          |4649   |1        |5.9     |
|3          |4245   |6        |5014.28 |
|5          |4658   |2        |6476.1  |
|6          |4434   |4        |3332.31 |
|7          |4495   |1        |232.95  |
|8          |4439   |1        |705.47  |
|9          |4438   |1        |1794.27 |
|10         |4887   |1        |206.95  |
|11         |5301   |1        |211.15  |
|12         |4743   |1        |90.39   |
+-----------+-------+---------+--------+
```
**Calculating Recency, Frequency, and Monetary for each customer.**

### RFM Scoring System
```mysql
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
```
**Output:**
```text
+-----------+-------+---------+--------+------------+--------------+-------------+--------+
|customer_id|Recency|Frequency|Monetary|RecencyScore|FrequencyScore|MonetaryScore|RMFScore|
+-----------+-------+---------+--------+------------+--------------+-------------+--------+
|1340       |4092   |11       |11516.76|1           |5             |5            |11      |
|1778       |4118   |11       |8658.37 |1           |5             |5            |11      |
|1745       |4080   |16       |38105.95|1           |5             |5            |11      |
|272        |4088   |19       |34482.36|1           |5             |5            |11      |
|1796       |4081   |15       |19331.3 |1           |5             |5            |11      |
|2645       |4242   |10       |20268.54|1           |5             |5            |11      |
|2007       |4104   |12       |8049.95 |1           |5             |5            |11      |
|2382       |4206   |10       |26406.82|1           |5             |5            |11      |
|1682       |4088   |10       |14221.68|1           |5             |5            |11      |
|1821       |4230   |17       |18390.46|1           |5             |5            |11      |
+-----------+-------+---------+--------+------------+--------------+-------------+--------+
```
> **Assign a score from 1 to 5 for each factor:**
> * **`Recency`: More recent customers should have a higher score.**
> * **`Frequency`: More frequent customers should have a higher score.**
> * **`Monetary`: Higher monetary values (larger spenders) should have a higher score.**







