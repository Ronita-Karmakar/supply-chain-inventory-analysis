CREATE DATABASE supply_chain;
USE supply_chain;

CREATE TABLE supply_chain_data (
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(100),
    Category VARCHAR(100),
    Supplier_Name VARCHAR(100),
    Order_Date DATE,
    Delivery_Date DATE,
    Stock_Quantity INT,
    Reorder_Level INT,
    Units_Sold INT,
    Purchase_Cost DECIMAL(10,2),
    Selling_Price DECIMAL(10,2),
    Warehouse_Location VARCHAR(100),
    Shipping_Time_Days INT
);

SELECT COUNT(*) AS total_records
FROM supply_chain_data;

-- Total Units Sold
SELECT 
    SUM(Units_Sold) AS total_units_sold
FROM supply_chain_data;

-- Total Revenue
SELECT
    SUM(Units_Sold * Selling_Price) AS total_revenue
FROM supply_chain_data;

-- Total Cost
SELECT
    SUM(Units_Sold * Purchase_Cost) AS total_cost
FROM supply_chain_data;

-- Total Profit
SELECT
    SUM(
        Units_Sold * (Selling_Price - Purchase_Cost)
    ) AS total_profit
FROM supply_chain_data;

-- Profit Margin
SELECT
    ROUND(
        SUM(Units_Sold * (Selling_Price - Purchase_Cost))
        / SUM(Units_Sold * Selling_Price) * 100,
        2
    ) AS profit_margin_percentage
FROM supply_chain_data;

-- Average Shipping Time
SELECT
    ROUND(AVG(Shipping_Time_Days), 2) AS avg_shipping_time
FROM supply_chain_data;

-- Inventory Status
SELECT
    Product_ID,
    Product_Name,
    Stock_Quantity,
    Reorder_Level,
    CASE
        WHEN Stock_Quantity = 0 THEN 'Out of Stock'
        WHEN Stock_Quantity <= Reorder_Level THEN 'Understock'
        ELSE 'Overstock'
    END AS Inventory_Status
FROM supply_chain_data;

-- Count inventory status
SELECT
    CASE
        WHEN Stock_Quantity = 0 THEN 'Out of Stock'
        WHEN Stock_Quantity <= Reorder_Level THEN 'Understock'
        ELSE 'Overstock'
    END AS Inventory_Status,
    COUNT(*) AS record_count
FROM supply_chain_data
GROUP BY Inventory_Status;

-- Which products are frequently out of stock?
SELECT
    Product_Name,
    COUNT(*) AS out_of_stock_records
FROM supply_chain_data
WHERE Stock_Quantity = 0
GROUP BY Product_Name
ORDER BY out_of_stock_records DESC;

-- Products frequently understocked
SELECT
    Product_Name,
    COUNT(*) AS understock_records
FROM supply_chain_data
WHERE Stock_Quantity <= Reorder_Level
  AND Stock_Quantity > 0
GROUP BY Product_Name
ORDER BY understock_records DESC;

-- Overstocked products
SELECT
    Product_Name,
    COUNT(*) AS overstock_records
FROM supply_chain_data
WHERE Stock_Quantity > Reorder_Level
GROUP BY Product_Name
ORDER BY overstock_records DESC;

-- Fast-moving products
SELECT
    Product_Name,
    SUM(Units_Sold) AS total_units_sold
FROM supply_chain_data
GROUP BY Product_Name
ORDER BY total_units_sold DESC;

-- Slow-moving products
SELECT
    Product_Name,
    SUM(Units_Sold) AS total_units_sold
FROM supply_chain_data
GROUP BY Product_Name
ORDER BY total_units_sold ASC;

-- Which suppliers have the highest delivery times?
SELECT
    Supplier_Name,
    ROUND(AVG(Shipping_Time_Days), 2) AS avg_shipping_days
FROM supply_chain_data
GROUP BY Supplier_Name
ORDER BY avg_shipping_days DESC;

-- Which products generate the highest profit?
SELECT
    Product_Name,
    SUM(Units_Sold) AS total_units_sold,
    ROUND(SUM(Units_Sold * Selling_Price), 2) AS total_revenue,
    ROUND(
        SUM(Units_Sold * (Selling_Price - Purchase_Cost)),
        2
    ) AS total_profit
FROM supply_chain_data
GROUP BY Product_Name
ORDER BY total_profit DESC;

-- Category analysis
SELECT
    Category,
    SUM(Units_Sold) AS units_sold,
    ROUND(SUM(Units_Sold * Selling_Price), 2) AS revenue,
    ROUND(
        SUM(Units_Sold * (Selling_Price - Purchase_Cost)),
        2
    ) AS profit
FROM supply_chain_data
GROUP BY Category
ORDER BY profit DESC;

-- Warehouse analysis
SELECT
    Warehouse_Location,
    SUM(Stock_Quantity) AS total_stock,
    SUM(Units_Sold) AS units_sold,
    ROUND(SUM(Units_Sold * Selling_Price), 2) AS revenue,
    ROUND(
        SUM(Units_Sold * (Selling_Price - Purchase_Cost)),
        2
    ) AS profit
FROM supply_chain_data
GROUP BY Warehouse_Location
ORDER BY revenue DESC;

-- Delivery performance
SELECT
    CASE
        WHEN Shipping_Time_Days <= 3 THEN 'Fast'
        WHEN Shipping_Time_Days <= 7 THEN 'Normal'
        ELSE 'Long Delivery'
    END AS Delivery_Performance,
    COUNT(*) AS records
FROM supply_chain_data
GROUP BY Delivery_Performance
ORDER BY records DESC;

-- What is the impact of delivery delays on sales?
SELECT
    CASE
        WHEN Shipping_Time_Days <= 3 THEN 'Fast'
        WHEN Shipping_Time_Days <= 7 THEN 'Normal'
        ELSE 'Long Delivery'
    END AS Delivery_Performance,

    COUNT(*) AS orders,

    SUM(Units_Sold) AS total_units_sold,

    ROUND(AVG(Units_Sold), 2) AS avg_units_sold,

    ROUND(
        SUM(Units_Sold * Selling_Price),
        2
    ) AS total_revenue,

    ROUND(
        AVG(Shipping_Time_Days),
        2
    ) AS avg_shipping_days

FROM supply_chain_data

GROUP BY Delivery_Performance

ORDER BY avg_shipping_days;


