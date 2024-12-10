-- Step 1: Create Tables

/* Create customer_contracts table */
CREATE TABLE customer_contracts (
    customer_id INT,
    product_id INT,
    amount INT
);

/* Create products table */
CREATE TABLE products (
    product_id INT,
    product_category VARCHAR(50),
    product_name VARCHAR(50)
);

-- Step 2: Problem Statement and Objective

/*
💡 Problem Statement
A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

🟢 Objective
The goal is to write a query that identifies the customer IDs of Supercloud customers—those who have made at least one purchase in each product category.
*/

-- Step 3: SQL Query

WITH Supercloud_Customer AS (
    SELECT c.customer_id, 
           COUNT(DISTINCT p.product_category) AS Total_Category_Products
    FROM customer_contracts AS c
    INNER JOIN products AS p ON c.product_id = p.product_id
    GROUP BY c.customer_id
)
SELECT 
    customer_id
FROM Supercloud_Customer 
WHERE Total_Category_Products = (SELECT COUNT(DISTINCT product_category) FROM products);
