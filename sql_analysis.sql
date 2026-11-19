-- 1. Customer and Orders - INNER JOIN
USE onlinestore;

SELECT
    o.order_id,
    c.cust_id,
    c.f_name,
    c.l_name,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN customer c
ON o.cust_id = c.cust_id;

-- 2. Category-wise Revenue - GROUP BY
USE onlinestore;

SELECT
    c.category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
INNER JOIN product p
    ON oi.product_id = p.product_id
INNER JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- 3. Payment Status Analysis - COUNT()
USE onlinestore;

SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payment
GROUP BY payment_status
ORDER BY total_payments DESC;


-- 4. Customer-wise Orders - HAVING
USE onlinestore;

SELECT
    cust_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY cust_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;


-- 5. Above Average Orders - SUBQUERY
USE onlinestore;

SELECT
    order_id,
    cust_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY total_amount DESC;


-- 6. Order Value Classification - CASE
USE onlinestore;

SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 100000 THEN 'High Value'
        WHEN total_amount >= 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM orders
ORDER BY total_amount DESC;


-- 7. Month-wise Sales - DATE_FORMAT
USE onlinestore;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;


-- 8. Customer and Orders - LEFT JOIN
USE onlinestore;

SELECT
    c.cust_id,
    c.f_name,
    c.l_name,
    o.order_id,
    o.total_amount
FROM customer c
LEFT JOIN orders o
    ON c.cust_id = o.cust_id
ORDER BY c.cust_id;
