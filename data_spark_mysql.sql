create database data_spark;

select * from customers;
select * from exchangerates; 
select * from products;
select * from sales;
select * from stores;

--  1.Total Sales by Store
SELECT StoreKey, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY StoreKey
ORDER BY TotalSales DESC;

-- 2.Top 5 Products by Sales
SELECT p.Product_Name, SUM(s.Quantity) AS TotalSales
FROM products p
JOIN sales s ON p.ProductKey = s.ProductKey
GROUP BY p.Product_Name
ORDER BY TotalSales DESC
LIMIT 5;

-- 3.Monthly sales trends
SELECT DATE_FORMAT(Order_date, '%Y-%m') AS Month, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY Month
ORDER BY Month;

-- 4.Average Sales Per Customer
SELECT c.CustomerKey, AVG(s.Quantity) AS AvgSales
FROM sales s
JOIN customers c ON s.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey
ORDER BY AvgSales DESC;

-- 5.Region-Wise Sales Performance
SELECT s.State, SUM(sa.Quantity) AS TotalSales
FROM stores s
JOIN sales sa ON s.StoreKey = sa.StoreKey
GROUP BY s.State
ORDER BY TotalSales DESC;

-- 6.Sales Contribution by Product Category
SELECT p.Category, SUM(s.Quantity) AS TotalSales
FROM products p
JOIN sales s ON p.ProductKey = s.ProductKey
GROUP BY p.Category
ORDER BY TotalSales DESC;

-- 7.Growth Rate of Stores Based on Opening Date
SELECT st.StoreKey,(SUM(sa.Quantity) / DATEDIFF(CURDATE(), MIN(st.Open_Date))) AS DailyAverageSales
FROM stores st
JOIN sales sa ON st.StoreKey = sa.StoreKey
GROUP BY st.StoreKey
ORDER BY DailyAverageSales DESC;

-- 8.Exchange Rate Impact on Sales
SELECT e.Date, e.Exchange, SUM(s.Quantity) AS TotalSales
FROM exchangerates e
JOIN sales s ON DATE(e.Date) = DATE(s.Order_Date)
GROUP BY e.Date, e.Exchange
ORDER BY e.Date;

-- 9.Most Frequent Customers
SELECT CustomerKey, COUNT(Order_Number) AS TotalPurchases
FROM sales
GROUP BY CustomerKey
ORDER BY TotalPurchases DESC
LIMIT 10;

-- 10.Revenue by Store Size
SELECT st.StoreKey, st.Square_Meters, SUM(sa.Quantity) AS TotalSales
FROM stores st
JOIN sales sa ON st.StoreKey = sa.StoreKey
GROUP BY st.StoreKey, st.Square_Meters
ORDER BY TotalSales DESC;














