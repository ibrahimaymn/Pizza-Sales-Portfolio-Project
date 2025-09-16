-- KPIs
--	Total Sales
	SELECT  
		SUM(total_price) AS total_sales
	FROM 
		pizza_sales
--	Avg Order Value
	SELECT 
		SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
	FROM 
		pizza_sales
--	Total Pizzas Sold
	SELECT 
		SUM(quantity) AS total_pizzas_sold
	FROM 
		pizza_sales
--	Total Orders
	SELECT
		COUNT(DISTINCT order_id) AS total_orders
	FROM
		pizza_sales
--	Avg Pizzas per Order
	SELECT 
		SUM(quantity) / COUNT(DISTINCT order_id) AS avg_pizzas_per_order
	FROM 
		pizza_sales

-- Charts
--	Daily Trend for Total Orders
	SELECT 
		Day,
		COUNT(DISTINCT order_id) AS total_orders
	FROM (SELECT 
		order_id,
		DATENAME(WEEKDAY, order_date) AS Day,
		DATEPART(WEEKDAY, order_date) AS Daynum
	FROM pizza_sales) order_by_day
	GROUP BY 
		Day,
		Daynum
	ORDER BY
		Daynum
--	Monthly Trend for Total Orders
	SELECT 
		DATENAME(Month, order_date) AS Month,
		COUNT(DISTINCT order_id) AS total_orders
	FROM 
		pizza_sales
	GROUP BY 
		DATENAME(Month, order_date),
		MONTH(order_date)
	ORDER By
		MONTH(order_date)
--	Percentage of Sales by Pizza Category
	SELECT 
		pizza_category,
		SUM(total_price) AS total_sales,
		ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100 , 2) AS sales_percentage
	FROM 
		pizza_sales
	GROUP BY 
		pizza_category
--	Percentage of Sales by Pizza Size
	SELECT	
		pizza_size,
		SUM(total_price) AS total_sales,
		ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100 , 2) AS sales_percentage
	FROM 
		pizza_sales
	GROUP BY 
		pizza_size
--	Total Pizzas Sold by Pizza Category
	SELECT 
		pizza_category,
		SUM(quantity) AS pizzas_sold
	FROM
		pizza_sales
	GROUP BY
		pizza_category
--	Best 5 Sellers by Sales, Total Quantity
	SELECT TOP 5
		pizza_name,
		SUM(total_price) AS total_sales
	FROM 
		pizza_sales
	GROUP BY 
		pizza_name
	ORDER BY 
		SUM(total_price) DESC

	SELECT TOP 5
		pizza_name,
		SUM(quantity) AS pizzas_sold
	FROM 
		pizza_sales
	GROUP BY 
		pizza_name
	ORDER BY 
		SUM(quantity) DESC

--	Worst 5 Sellers by Sales, Total Quantity
	SELECT TOP 5
		pizza_name,
		SUM(total_price) AS total_sales
	FROM 
		pizza_sales
	GROUP BY 
		pizza_name
	ORDER BY 
		SUM(total_price) 

	SELECT TOP 5
		pizza_name,
		SUM(quantity) AS pizzas_sold
	FROM 
		pizza_sales
	GROUP BY 
		pizza_name
	ORDER BY 
		SUM(quantity)  