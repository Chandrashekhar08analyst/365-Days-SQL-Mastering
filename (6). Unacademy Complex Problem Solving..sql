-- Step 1: Create Tables and insert value in it.

-- Create the Person table
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(50),
    Score INT
);

-- Insert values into the Person table
INSERT INTO Person (PersonID, Name, Score) VALUES
(1, 'Alice', 85),
(2, 'Bob', 90),
(3, 'Charlie', 75),
(4, 'David', 95),
(5, 'Eve', 80);

-- Create the Friend table
CREATE TABLE Friend (
    PersonID INT,
    FriendID INT,
    PRIMARY KEY (PersonID, FriendID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (FriendID) REFERENCES Person(PersonID)
);

-- Insert values into the Friend table
INSERT INTO Friend (PersonID, FriendID) VALUES
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 4),
(4, 5),
(5, 1);

-- Step 2: Problem Statement.
/* 
💡 Problem Statement
A Unacademy user is defined as a high achiever who is not only committed to their 
own learning but also connected with friends who excel in their academic journey.
To identify these standout individuals, we are focusing on users who 
are part of a high-performance network of friends.

🟢 Objective
Write a query to find the person ID, name, number of friends, 
and sum of marks of persons who have friends with a total score greater than 100.  
*/

-- Step 3: Query for achive the goal.
WITH Person_Friends_Score AS (
SELECT f.personid AS PersonID, SUM(p.score) AS Total_Friend_Score, 
	COUNT(f.friendid) AS Total_Friends
FROM Person AS p 
INNER JOIN Friend AS f ON f.FriendID = p.PersonID
GROUP BY f.personid
ORDER BY PersonID
)
SELECT pf.PersonID, p.name AS PersonName,
pf.Total_Friends, pf.Total_Friend_Score
FROM Person_Friends_Score AS pf 
INNER JOIN Person AS p ON pf.PersonID = p.PersonID
WHERE pf.Total_Friend_Score > 100;
