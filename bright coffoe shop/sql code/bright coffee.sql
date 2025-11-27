SELECT
  transaction_date,
  DAYNAME(transaction_date) AS day_name,
  CASE 
    WHEN DAYNAME(transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  MONTHNAME(transaction_date) AS month_name,

  CASE 
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '6am-11am Morning'
    WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN '12pm-16pm Afternoon'
    WHEN transaction_time >= '17:00:00' THEN '17pm-23pm Evening'
    ELSE 'Night'
  END AS time_of_day,
  DATE_TRUNC('hour', transaction_time) AS hour_interval, --  Hour only
  

  store_location,
  product_category,
  product_detail,
  product_type,

  COUNT(DISTINCT transaction_id) AS number_sales,
  SUM(transaction_qty) AS total_units_sold,
  SUM(transaction_qty * unit_price) AS total_revenue,
  AVG(unit_price * transaction_qty) AS avg_revenue_per_sale,
   MIN (TRANSACTION_TIME)AS opening_time,
   MAX(transaction_time)AS closing_time,

FROM "BRIGHT_COFFEE"."PUBLIC"."BRIGHT_LEARN_SALES"
GROUP BY ALL;
