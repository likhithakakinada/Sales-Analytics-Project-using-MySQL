-- croma India product wise sales report for fiscal year 2021

SELECT 
    date,f.product_code,product,variant,sold_quantity,
    gross_price,
    ROUND(sold_quantity * gross_price,2) as gross_price_total
FROM fact_sales_monthly f
JOIN dim_product p 
ON f.product_code = p.product_code 
JOIN fact_gross_price g 
ON 
    f.product_code = g.product_code and get_fiscal_year(f.date)=g.fiscal_year
WHERE 
    customer_code = 90002002 and 
    get_fiscal_year(date) = 2021 
ORDER BY date desc;

-- Gross monthly total sales report for croma

SELECT
     f.date, 
     SUM(ROUND(sold_quantity * gross_price,2)) as gross_price_total
FROM fact_sales_monthly f 
JOIN fact_gross_price g 
ON 
     f.product_code = g.product_code and get_fiscal_year(f.date)=g.fiscal_year
WHERE 
    customer_code = 90002002
GROUP BY f.date
ORDER BY date desc;

-- Yearly Sales report for Croma India

SELECT
	get_fiscal_year(f.date) as FY,
    SUM(ROUND(sold_quantity * gross_price,2)) as gross_price_total
FROM fact_sales_monthly f
JOIN fact_gross_price g 
ON 
     f.product_code = g.product_code and get_fiscal_year(f.date)=g.fiscal_year
WHERE 
    customer_code = 90002002
GROUP BY FY;

-- Market Badge

SELECT 
	sum(sold_quantity) as total_sold_quantity
FROM dim_customer c
JOIN fact_sales_monthly s
ON
    c.customer_code = s.customer_code
WHERE market = "India" and get_fiscal_year(s.date) = 2020
GROUP BY 
    market;
    
 
-- Top Markets by Net Sales
SELECT
    market, ROUND(sum(net_sales)/1000000,2) as sales_millions
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY market
ORDER BY sales_millions DESC
LIMIT 5;

-- Net Sales Global Market Share %

WITH CTE1 as 
(SELECT
	customer, 
	ROUND(sum(net_sales)/1000000,2) as sales_millions
FROM net_sales s
JOIN dim_customer c
	ON s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021
GROUP BY customer)

SELECT 
	*,
    sales_millions*100/sum(sales_millions) over() as pct 
FROM CTE1
ORDER BY sales_millions DESC;

-- Net Sales % Share by Region

WITH CTE1 AS
(SELECT
	c.customer, c.region,
	ROUND(sum(net_sales)/1000000,2) as sales_millions
FROM net_sales s
JOIN dim_customer c
	ON s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021
GROUP BY c.customer, c.region )

SELECT 
	*,
    sales_millions*100/sum(sales_millions) over(partition by region) as pct 
FROM CTE1 
ORDER BY region ASC, pct DESC;


-- get top n products in each division by their quantity sold

with cte1 as
(SELECT
	p.division,
    p.product,
    sum(sold_quantity) as total_qty
FROM
	fact_sales_monthly s
JOIN
	dim_product p
ON p.product_code = s.product_code
WHERE fiscal_year = 2021
group by p.product, p.division),

 cte2 as (SELECT
	* ,
    dense_rank() over(partition by division order by total_qty desc) as drnk
FROM cte1 ) 
SELECT * FROM cte2 WHERE drnk<=3;


-- Forecast Accuracy for all customers for a given FY

CREATE TABLE fact_act_est
(
	SELECT
		s.*, f.forecast_quantity
	FROM fact_sales_monthly s
	LEFT JOIN fact_forecast_monthly f
	USING (date, product_code, customer_code)

	UNION

	SELECT
		s.*, f.forecast_quantity
	FROM fact_sales_monthly s
	RIGHT JOIN fact_forecast_monthly f
	USING (date, product_code, customer_code)
);

SELECT 	* FROM fact_act_est;
UPDATE fact_act_est
SET sold_quantity = 0
WHERE sold_quantity IS NULL;
