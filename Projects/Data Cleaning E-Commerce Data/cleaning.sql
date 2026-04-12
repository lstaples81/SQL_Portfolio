-- =========================================
-- DATA CLEANING: E-COMMERCE DATASET
-- Tables: customers, orders, order_items
-- =========================================


-- =========================================
-- STEP 1: PREVIEW RAW DATA
-- =========================================

SELECT TOP 100 * FROM customers;
SELECT TOP 100 * FROM orders;
SELECT TOP 100 * FROM order_items;


-- =========================================
-- STEP 2: REMOVE DUPLICATE RECORDS
-- =========================================

-- Check duplicates in customers
SELECT 
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Remove duplicates (keep first)
WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY (SELECT NULL)
           ) AS row_num
    FROM customers
)
DELETE FROM duplicates
WHERE row_num > 1;


-- =========================================
-- STEP 3: HANDLE MISSING VALUES (NULLS)
-- =========================================

-- Check NULLs in key columns
SELECT 
    COUNT(*) AS total_orders,
    COUNT(customer_id) AS valid_customers,
    COUNT(order_date) AS valid_dates
FROM orders;

-- Remove orders with missing customer_id
DELETE FROM orders
WHERE customer_id IS NULL;

-- Replace NULL customer names
UPDATE customers
SET customer_name = 'Unknown'
WHERE customer_name IS NULL;


-- =========================================
-- STEP 4: CLEAN TEXT FIELDS (STANDARDIZATION)
-- =========================================

-- Trim spaces
UPDATE customers
SET customer_name = LTRIM(RTRIM(customer_name));

-- Standardize country names
UPDATE customers
SET country = 'USA'
WHERE country IN ('us', 'USA ', 'United States', 'america');

-- Fix order status values
UPDATE orders
SET status = 'Completed'
WHERE status IN ('complete', 'COMP', 'done');

UPDATE orders
SET status = 'Cancelled'
WHERE status IN ('cancel', 'CANCELLED', 'canceled');


-- =========================================
-- STEP 5: FIX DATA TYPES
-- =========================================

-- Ensure correct data types
ALTER TABLE orders
ALTER COLUMN order_date DATE;

ALTER TABLE order_items
ALTER COLUMN price DECIMAL(10,2);

ALTER TABLE order_items
ALTER COLUMN quantity INT;


-- =========================================
-- STEP 6: REMOVE INVALID DATA
-- =========================================

-- Remove negative or zero quantities
DELETE FROM order_items
WHERE quantity <= 0;

-- Remove negative prices
DELETE FROM order_items
WHERE price < 0;

-- Remove future order dates
DELETE FROM orders
WHERE order_date > GETDATE();


-- =========================================
-- STEP 7: STANDARDIZE CATEGORIES
-- =========================================

-- Standardize product categories (example)
UPDATE order_items
SET product_id = NULL
WHERE product_id = 0;


-- =========================================
-- STEP 8: CREATE CLEANED TABLES
-- =========================================

SELECT * INTO cleaned_customers FROM customers;
SELECT * INTO cleaned_orders FROM orders;
SELECT * INTO cleaned_order_items FROM order_items;


-- =========================================
-- STEP 9: VALIDATE CLEANED DATA
-- =========================================

-- Check row counts
SELECT COUNT(*) AS customers_count FROM cleaned_customers;
SELECT COUNT(*) AS orders_count FROM cleaned_orders;
SELECT COUNT(*) AS order_items_count FROM cleaned_order_items;

-- Check for remaining NULLs
SELECT * FROM cleaned_orders WHERE customer_id IS NULL;

-- Check distinct statuses
SELECT DISTINCT status FROM cleaned_orders;


-- =========================================
-- STEP 10: FINAL CLEAN DATA FOR ANALYSIS
-- =========================================

SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS revenue
FROM cleaned_orders o
JOIN cleaned_customers c ON o.customer_id = c.customer_id
JOIN cleaned_order_items oi ON o.order_id = oi.order_id;

