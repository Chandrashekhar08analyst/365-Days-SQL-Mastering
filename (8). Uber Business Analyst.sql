-- Step 1: Create Table and Insert Data

-- Create the Transactions Table
CREATE TABLE Transactions (
    User_ID INT,
    Spend DECIMAL(10, 2),
    Transaction_Date TIMESTAMP
);

-- Insert Data into the Transactions Table
INSERT INTO Transactions (User_ID, Spend, Transaction_Date) VALUES
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00'),
(145, 45.30, '2022-02-28 12:00:00'),
(121, 22.20, '2022-04-01 12:00:00'),
(121, 67.90, '2022-04-03 12:00:00'),
(263, 156.00, '2022-04-11 12:00:00'),
(230, 78.30, '2022-06-14 12:00:00'),
(263, 68.12, '2022-07-11 12:00:00'),
(263, 100.00, '2022-07-12 12:00:00');

-- Step 2: Problem Statement
/*
💡 Problem Statement
Uber wants to understand customer behavior and retention patterns by analyzing
the transactional data of its users. Specifically, they aim to identify the 
characteristics of the third transaction made by each user, such as spend 
and transaction date. This will help them uncover deeper insights into
user engagement trends and spending behavior. By focusing on this stage of the customer
journey, Uber seeks to optimize retention strategies and enhance user experience.

🟢 Objective
Write a query to obtain the third transaction for every user, including 
details such as user ID, spend, and transaction date. This information will assist Uber in:
1. Identifying patterns of user engagement during early transactions.
2. Understanding spending behavior at this stage of the customer journey.
3. Designing targeted strategies to encourage continued app usage and customer loyalty.
*/

-- Step 3: Query to Achieve the Goal
WITH Third_Transaction AS (
    SELECT 
        User_ID, 
        Spend, 
        Transaction_Date,
        ROW_NUMBER() OVER(PARTITION BY User_ID ORDER BY Transaction_Date) AS rn 
    FROM Transactions
)
SELECT 
    User_ID, 
    Spend, 
    Transaction_Date
FROM Third_Transaction 
WHERE rn = 3;

-- Explanation of the Query
/*
1. ROW_NUMBER() Function:
   - This assigns a unique rank to each transaction of a user, ordered by Transaction_Date.
   - The PARTITION BY User_ID ensures the ranking is reset for each user.

2. Common Table Expression (CTE):
   - The Third_Transaction CTE calculates the rank (rn) of each transaction for every user.

3. Final Query:
   - Filters the transactions to return only those with rn = 3,
which corresponds to the third transaction for each user.
*/
