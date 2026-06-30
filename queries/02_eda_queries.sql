SELECT
	MIN(order_purchase_timestamp) AS oldest_order,
	MAX(order_purchase_timestamp) AS earliest_order,
	COUNT(*) AS no_of_orders
FROM dbo.orders;

SELECT
	order_status,
	COUNT(*) AS count,
	CAST(COUNT(*) AS DECIMAL(10,2)) / SUM(COUNT(*)) OVER() * 100 AS pct
FROM dbo.orders
GROUP BY order_status
ORDER BY count DESC;

SELECT
	ROUND(SUM(payment_value), 2) AS payment_sum,
	ROUND(AVG(payment_value), 2) AS payment_avg,
	COUNT(DISTINCT order_id) AS paid_orders
FROM order_payments;

SELECT TOP 10
    t.product_category_name_english,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation AS t 
ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC;

SELECT TOP 10
	COUNT(o.order_id) AS no_of_orders,
	c.customer_state
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY customer_state
ORDER BY no_of_orders DESC;