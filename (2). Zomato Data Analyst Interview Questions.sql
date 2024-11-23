-- Customer Table Creations:
CREATE TABLE customers ( 
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone_number VARCHAR(15),
    address VARCHAR(255) -- Nullable to represent unknown addresses
);

INSERT INTO customers (customer_name, email, phone_number, address)
VALUES
    ('Alice Johnson', 'alice.johnson@zomato.com', '9876543210', '123 Green Street, Delhi'),
    ('Bob Smith', 'bob.smith@zomato.com', '9123456789', NULL), -- Address unknown
    ('Charlie Brown', 'charlie.brown@zomato.com', '8765432190', '456 Blue Avenue, Mumbai'),
    ('Diana Ross', 'diana.ross@zomato.com', '8123456790', NULL), -- Address unknown
    ('Eve Taylor', 'eve.taylor@zomato.com', '9198765432', '789 Yellow Road, Bangalore');

-- Orders Table Creations:
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT REFERENCES customers(customer_id),
    restaurant_name VARCHAR(100) NOT NULL,
    revenue NUMERIC(10, 2) NOT NULL
);

INSERT INTO orders (order_date, customer_id, restaurant_name, revenue)
VALUES
    ('2024-11-01', 1, 'The Green Bowl', 450.00),
    ('2024-11-03', 1, 'Pizza Mania', 700.50),
    ('2024-11-10', 2, 'Sushi World', 1200.00),
    ('2024-11-12', 3, 'The Blue Plate', 350.75),
    ('2024-11-15', 1, 'Burger Barn', 500.00),
    ('2024-11-18', 4, 'Healthy Bites', 650.00),
    ('2024-11-18', 3, 'The Curry Pot', 800.25),
    ('2024-11-18', 5, 'The Yellow Chilli', 1000.00);

-- Restaurants Table Creations:
CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    rating NUMERIC(3, 1) NOT NULL
);

INSERT INTO restaurants (restaurant_name, city, rating)
VALUES
    ('The Green Bowl', 'Delhi', 4.5),
    ('Pizza Mania', 'Delhi', 4.0),
    ('Sushi World', 'Mumbai', 4.8),
    ('The Blue Plate', 'Mumbai', 4.2),
    ('Burger Barn', 'Bangalore', 3.9),
    ('Healthy Bites', 'Bangalore', 4.7),
    ('The Curry Pot', 'Bangalore', 4.3),
    ('The Yellow Chilli', 'Mumbai', 4.6);




/*                     Questions Solutions:

1. Find the Percentage of Shippable Orders
Determine the percentage of orders where the customer's address is known.   */
SELECT CONCAT(100*(SUM(CASE WHEN c.address IS NOT NULL THEN 1 ELSE 0 END))
	/COUNT(o.order_id), '%') AS Shipped_Order_Percentage
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id;

/*
2. Find the Top 5 Customers by Total Orders  */
SELECT c.customer_id, c.customer_name,
COUNT(o.order_id) AS Total_Orders
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.customer_name
ORDER BY Total_Orders DESC
LIMIT 5;

/* 
3. Find Customers Who Have Never Placed an Order  */
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

/*
4. Calculate the Total Revenue Earned by Zomato  */
SELECT SUM(Revenue) AS Total_Revenue
FROM orders;

/* 

5. List Orders Placed in the Last 7 Days    */
SELECT * FROM orders 
WHERE order_date >= CURRENT_DATE - INTERVAL '7 DAYS';

/* 
6. Find the Average Revenue Per Customer   */
SELECT c.customer_id , c.customer_name,
ROUND(AVG(o.revenue), 2) AS average_revenue 
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.customer_name
ORDER BY average_revenue DESC;

/*
7. Find Restaurants with Revenue Above the Average   */
WITH Restaurant_Revenue AS (
	SELECT Restaurant_Name, SUM(Revenue) AS Total_Revenue 
    FROM orders
	GROUP BY Restaurant_Name
)
SELECT Restaurant_Name, Total_Revenue
FROM Restaurant_Revenue
WHERE Total_Revenue > (SELECT AVG(Revenue) FROM Orders);

/*
8. Rank Restaurants by Total Revenue   */
SELECT Restaurant_Name, SUM(Revenue) AS Total_Revenue, 
DENSE_RANK() OVER(ORDER BY SUM(Revenue)) AS rnk
FROM orders
GROUP BY Restaurant_Name;

/* 
9. Count Orders Placed by Each Customer in Each City */
SELECT r.city, c.customer_id, c.customer_name,
       COUNT(o.order_id) AS Total_Orders
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN Restaurants AS r ON o.restaurant_name = r.restaurant_name
GROUP BY r.city, c.customer_id, c.customer_name;

/*
10. Identify Customers with Total Revenue Exceeding ₹2000  */
SELECT c.customer_id, c.customer_name, 
SUM(o.revenue) AS Total_Revenue
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.customer_name
HAVING SUM(o.revenue) > 2000;


