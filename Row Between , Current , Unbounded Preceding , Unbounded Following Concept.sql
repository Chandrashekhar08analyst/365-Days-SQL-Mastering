-- Calculate the cumulative sum (SUM) of sales_amount for each employee ordered by sales_date.
SELECT employee_name, sales_amount, sales_date,
SUM(sales_amount) OVER(ORDER BY sales_date 
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_Sum
FROM Sales_Data;

/* Find the rolling average (AVG) of the last 3 rows (including the current row)
of sales_amount for each employee ordered by sales_date.  */
SELECT sales_date, employee_name, sales_amount, 
ROUND(AVG(sales_amount )OVER(ORDER BY sales_date
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 0) AS Rolling_AVG
FROM Sales_Data;

/* Calculate the difference between the maximum (MAX) and minimum (MIN) sales
amount within each employee's sales history. */
SELECT Sales_date, Employee_name, Sales_amount,
MAX(sales_amount) OVER(PARTITION BY Employee_name ROWS BETWEEN 
	UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Max_Sales,
MIN(sales_amount) OVER(PARTITION BY Employee_name ROWS BETWEEN 
	UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Min_Sales
FROM Sales_Data;

/* Determine the rank (RANK()) of each sales record within the entire dataset,
based on sales_amount in descending order. */
SELECT * , 
RANK() OVER(ORDER BY Sales_Amount DESC) AS Rnk
FROM Sales_Data;

/* Find the total sales amount for each employee, considering all their rows
(UNBOUNDED PRECEDING to UNBOUNDED FOLLOWING) grouped by employee_name.  */
SELECT Sales_date, Employee_name, Sales_Amount, 
SUM(Sales_Amount) OVER(PARTITION BY Employee_Name
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)AS Total_Sales_Amount
FROM Sales_Data;


