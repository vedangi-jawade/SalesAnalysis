SELECT * FROM superstore_sales LIMIT 5;


-- Total Sales and Total profit yearly

SELECT DATE_TRUNC('year', order_date) AS year, 
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstore_sales
GROUP BY year
ORDER BY year ASC;

-- Total profits and Total sales quarterly

SELECT 
  date_part('year', order_date) AS year, 
  CASE 
    WHEN date_part('month', order_date) IN (1,2,3) THEN 'Q1'
    WHEN date_part('month', order_date) IN (4,5,6) THEN 'Q2'
    WHEN date_part('month', order_date) IN (7,8,9) THEN 'Q3'
    ELSE 'Q4'
  END AS quarter,
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit
FROM superstore_sales
GROUP BY year, quarter
ORDER BY year, quarter;

--Region generating highest profit
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profits
FROM superstore_sales
GROUP BY region
ORDER BY total_profits DESC;

--Profit margin per region
SELECT region, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM superstore_sales
GROUP BY region
ORDER BY profit_margin DESC;

-- City and state with the highest sales and profits
	
SELECT states, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profits, 
       ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY states
ORDER BY total_profits DESC
LIMIT 10;