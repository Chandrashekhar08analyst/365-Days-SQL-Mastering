-- Step 1: Create Tables and insert values

-- Create the Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    RegistrationDate DATE,
    Country VARCHAR(50),
    Age INT
);

-- Insert values into the Users table
INSERT INTO Users (UserID, Name, RegistrationDate, Country, Age) VALUES
(1, 'Alice', '2024-01-10', 'USA', 25),
(2, 'Bob', '2024-02-15', 'India', 30),
(3, 'Charlie', '2024-03-20', 'Canada', 22),
(4, 'David', '2024-04-25', 'UK', 28),
(5, 'Eve', '2024-05-30', 'Australia', 35);

-- Create the AppUsage table
CREATE TABLE AppUsage (
    UserID INT,
    LoginDate DATE,
    FeatureUsed VARCHAR(50),
    SessionDuration INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Insert values into the AppUsage table
INSERT INTO AppUsage (UserID, LoginDate, FeatureUsed, SessionDuration) VALUES
(1, '2024-06-01', 'Search', 120),
(1, '2024-06-02', 'Maps', 60),
(2, '2024-06-01', 'Photos', 150),
(2, '2024-06-02', 'Search', 90),
(3, '2024-06-03', 'Maps', 80),
(3, '2024-06-04', 'Photos', 100),
(4, '2024-06-05', 'Search', 110),
(5, '2024-06-06', 'Photos', 200);

-- Step 2: Problem Statement
/*
💡Problem Statement
Google is facing a challenge in understanding which app features, such as Search, Maps,
or Photos, are the most engaging for users in different countries. To address this, 
they want to analyze the total time spent by users on each feature across various regions. 
This analysis will help them identify popular features and focus on 
improving user experience for those features in specific countries.

🟢 Objective
Write a query to identify the most engaging app feature in each country by
calculating the total time spent by users on each feature.
This information will assist in improving features that are popular in
specific regions, ensuring a better user experience.
*/


-- -- Step 3: Query for achive the goal.
WITH Country_Feature_Duration AS(
SELECT u.Country, ua.FeatureUsed, 
SUM(sessionduration) AS Total_Duration
FROM Users AS u
INNER JOIN appusage AS ua ON u.userid = ua.userid
GROUP BY u.Country, ua.FeatureUsed
),
TOP1_Feature AS (
SELECT Country, FeatureUsed, Total_Duration,
DENSE_RANK() OVER(PARTITION BY Country ORDER BY Total_Duration DESC) AS drnk
FROM Country_Feature_Duration
)
SELECT Country, FeatureUsed, Total_Duration
FROM TOP1_Feature
WHERE drnk = 1;

-- 📱🎯 My Recommendation
/*
Focus on enhancing the most popular app features in each region 
through localized improvements and targeted marketing campaigns.
Regularly analyze user feedback and engagement data to refine features
and stay aligned with regional preferences.   
*/