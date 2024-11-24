-- Create the table for Tesla
CREATE TABLE tesla_products (
    year INT,
    company_name VARCHAR(50),
    product_name VARCHAR(100)
);

-- Insert Sample data for Tesla
INSERT INTO tesla_products (year, company_name, product_name) VALUES
(2019, 'Toyota', 'Avalon'),
(2019, 'Toyota', 'Camry'),
(2020, 'Toyota', 'Corolla'),
(2019, 'Honda', 'Accord'),
(2019, 'Honda', 'Passport'),
(2019, 'Honda', 'CR-V'),
(2020, 'Honda', 'Pilot'),
(2019, 'Honda', 'Civic'),
(2020, 'Chevrolet', 'Trailblazer'),
(2020, 'Chevrolet', 'Trax'),
(2019, 'Chevrolet', 'Traverse'),
(2020, 'Chevrolet', 'Blazer'),
(2019, 'Ford', 'Figo'),
(2020, 'Ford', 'Aspire'),
(2019, 'Ford', 'Endeavour'),
(2020, 'Jeep', 'Wrangler'),
(2020, 'Jeep', 'Cherokee'),
(2020, 'Jeep', 'Compass'),
(2019, 'Jeep', 'Renegade'),
(2019, 'Jeep', 'Gladiator');

/* Count the net difference between the number of products companies launched in 2020
and the number of products launched in the previous year. 
Your output should include the names of the companies and 
the net difference in products released for 2020 compared to last year.                 */

WITH New_Product_2020 AS (
    SELECT company_name, 
           COUNT(product_name) AS Total_Product_Launch1
    FROM tesla_products
    WHERE year = 2020
    GROUP BY company_name
),
New_Product_2019 AS (
    SELECT company_name, 
           COUNT(product_name) AS Total_Product_Launch2
    FROM tesla_products
    WHERE year = 2019
    GROUP BY company_name
)
SELECT n1.company_name,
       (n1.Total_Product_Launch1 - n2.Total_Product_Launch2) AS Product_Difference
FROM New_Product_2020 AS n1
JOIN New_Product_2019 AS n2 ON n1.company_name = n2.company_name;