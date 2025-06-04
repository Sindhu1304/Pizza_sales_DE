USE pizza_sales_db;

SELECT * FROM pizza_orders;

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_orders;

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_orders;

SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Average_Order_Value
FROM pizza_orders;

SELECT pizza_name, SUM(quantity) AS Total_Sold
FROM pizza_orders
GROUP BY pizza_name
ORDER BY Total_Sold DESC
LIMIT 5;

SELECT pizza_category, SUM(total_price) AS Category_Revenue
FROM pizza_orders
GROUP BY pizza_category
ORDER BY Category_Revenue DESC;

SELECT pizza_size, SUM(total_price) AS Size_Revenue
FROM pizza_orders
GROUP BY pizza_size
ORDER BY Size_Revenue DESC;


SELECT order_date, SUM(total_price) AS Daily_Revenue
FROM pizza_orders
GROUP BY order_date
ORDER BY order_date;

-- 8. Hourly Sales Trend
SELECT HOUR(order_time) AS Hour, SUM(total_price) AS Hourly_Revenue
FROM pizza_orders
GROUP BY HOUR(order_time)
ORDER BY Hour;

-- 9. Most Profitable Pizza
SELECT pizza_name, SUM(total_price) AS Revenue
FROM pizza_orders
GROUP BY pizza_name
ORDER BY Revenue DESC
LIMIT 1;

-- 10. Least Ordered Pizza
SELECT pizza_name, SUM(quantity) AS Total_Ordered
FROM pizza_orders
GROUP BY pizza_name
ORDER BY Total_Ordered ASC
LIMIT 1;
