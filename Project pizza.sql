select * from pizza_sales;

select sum(total_price) as Total_Revenue from pizza_sales;

select sum(total_price)/ count(distinct order_id) as AVG_ORDER_VALUE from pizza_sales; 

select sum(quantity) as total_pizza_sold from pizza_sales;

select count(distinct order_id) as total_order from pizza_sales;

select CAST(cast(sum(quantity) AS DECIMAL(10,2))/ count(distinct order_id) AS DECIMAL(10,2)) as AVG_PIZZ_PER_ORDER from pizza_sales; 

-- 1.Daily Trend
SELECT TO_CHAR(order_date, 'Day') AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day;

-- 2.Hourly Trend
SELECT 
    EXTRACT(HOUR FROM order_time) AS order_hours, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hours;

-- 3.Sales Percentage
SELECT 
    pizza_category, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT 
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT ASC;

/*(In this query we also added the sales number & extracting from month )
SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE EXTRACT(MONTH FROM order_date) = 1) AS PCT
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category;   */

-- 4.Pizza Size
 SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
	CAST( SUM(total_price)* 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT 
FROM pizza_sales
--WHERE EXTRACT(QUARTER FROM order_date) = 1
GROUP BY pizza_size
ORDER BY PCT ASC;

-- 5.Total Pizza Sold By Pizza Catregory
SELECT PIZZA_CATEGORY, SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales GROUP BY pizza_category;

-- 6.Top 5 Best Seller by Total Pizza Sold
SELECT pizza_name, SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales GROUP BY pizza_name ORDER BY Total_pizza_sold DESC LIMIT 5;

-- 7.Bottom 5 Worst Sellers by Total Pizza Sold
SELECT pizza_name,
SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales 
GROUP BY pizza_name ORDER BY Total_pizza_sold ASC LIMIT 5 ;

select * from pizza_sales;