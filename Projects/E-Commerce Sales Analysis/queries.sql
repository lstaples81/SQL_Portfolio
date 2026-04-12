-- =========================================
-- E-COMMERCE SALES ANALYSIS
-- =========================================

-- 1. Total revenue by customer
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;


-- 2. Top 10 customers
SELECT TOP 10
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;


-- 3. Revenue by product category
SELECT 
    p.category,
    SUM(oi.quantity * oi.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- 4. Monthly sales trend
SELECT 
    FORMAT(o.order_date, 'yyyy-MM') AS sales_month,
    SUM(oi.quantity * oi.price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY sales_month;


-- 5. Customer segmentation (CASE)
SELECT 
    c.customer_id,
    SUM(oi.quantity * oi.price) AS total_spent,
    CASE 
        WHEN SUM(oi.quantity * oi.price) >= 1000 THEN 'High Value'
        WHEN SUM(oi.quantity * oi.price) >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id;