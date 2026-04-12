-- =========================================
-- OPERATIONS KPI ANALYSIS
-- =========================================

-- 1. Order status breakdown
SELECT 
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;


-- 2. Completion rate KPI
SELECT 
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) 
    AS completion_rate
FROM orders;


-- 3. Average processing time
SELECT 
    AVG(DATEDIFF(MINUTE, start_time, end_time)) AS avg_processing_time
FROM order_processing;


-- 4. Regional performance
SELECT 
    region,
    COUNT(*) AS total_orders
FROM orders
GROUP BY region
ORDER BY total_orders DESC;


-- 5. Delayed orders
SELECT 
    order_id,
    DATEDIFF(MINUTE, start_time, end_time) AS processing_time
FROM order_processing
WHERE DATEDIFF(MINUTE, start_time, end_time) > 30;


-- 6. Daily performance trend
SELECT 
    CAST(order_date AS DATE) AS order_day,
    COUNT(*) AS total_orders
FROM orders
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day;


-- 7. KPI status flag
SELECT 
    order_id,
    CASE 
        WHEN status = 'Completed' THEN 'Good'
        WHEN status = 'Cancelled' THEN 'Bad'
        ELSE 'Pending'
    END AS kpi_status
FROM orders;