-- Step 1: Create Tables and insert values

-- Create the sf_transactions table
CREATE TABLE sf_transactions (
    id INT PRIMARY KEY,
    created_at DATE,
    value INT,
    purchase_id INT
);

-- Insert sample data into sf_transactions
INSERT INTO sf_transactions (id, created_at, value, purchase_id) VALUES
(1, '2019-01-01', 172692, 43),
(2, '2019-01-05', 177194, 36),
(3, '2019-01-09', 109513, 30),
(4, '2019-01-13', 164911, 30),
(5, '2019-01-17', 198872, 39),
(6, '2019-01-21', 184853, 31),
(7, '2019-01-25', 186817, 26),
(8, '2019-01-29', 137784, 22),
(9, '2019-02-02', 140032, 25),
(10, '2019-02-06', 116948, 43),
(11, '2019-02-10', 162515, 25),
(12, '2019-02-14', 114256, 12),
(13, '2019-02-18', 197465, 48),
(14, '2019-02-22', 120741, 20),
(15, '2019-02-26', 100074, 49),
(16, '2019-03-02', 157548, 19),
(17, '2019-03-06', 105506, 16),
(18, '2019-03-10', 189351, 46),
(19, '2019-03-14', 191231, 29),
(20, '2019-03-18', 120575, 44),
(21, '2019-03-22', 151688, 47),
(22, '2019-03-26', 102327, 18),
(23, '2019-03-30', 156147, 25),
(24, '2019-04-03', 192530, 36),
(25, '2019-04-07', 154765, 42),
(26, '2019-04-11', 113336, 12),
(27, '2019-04-15', 129073, 50),
(28, '2019-04-19', 123477, 21),
(29, '2019-04-23', 182142, 31),
(30, '2019-04-27', 116546, 39),
(31, '2019-05-01', 174748, 26),
(32, '2019-05-05', 155693, 42),
(33, '2019-05-09', 103012, 25),
(34, '2019-05-13', 187960, 33),
(35, '2019-05-17', 101202, 18);

-- Step 2: Problem Statement
/*
💡 Problem Statement
Amazon wants to analyze revenue trends over time by calculating the month-over-month 
percentage change in revenue. This analysis will help them identify periods of growth 
or decline and make informed decisions for future strategies.

🟢 Objective
Write a query to calculate the month-over-month percentage change in revenue. 
The output should include the year-month (YYYY-MM) and percentage change, rounded to 
the 2nd decimal point, sorted in chronological order. The percentage change should 
be calculated from the 2nd month onward as:
((this month's revenue - last month's revenue) / last month's revenue) * 100
This information will help Amazon in understanding revenue patterns over time.
*/


-- -- Step 3: Query for achive the goal.
WITH Monthly_Difference AS (
SELECT TO_CHAR(created_at, 'YYYY-MM') AS Year_Month,
SUM(Value) AS Current_month_revenue
FROM sf_transactions
GROUP BY Year_Month
),
Previous_Month AS (
SELECT Year_Month, Current_month_revenue, 
LAG(Current_month_revenue) OVER(ORDER BY Year_Month) AS last_month_revenue
FROM Monthly_Difference
)
SELECT Year_Month, 
ROUND(((Current_month_revenue - last_month_revenue)/last_month_revenue)*100,2) AS MOM_Percentage
FROM Previous_Month;