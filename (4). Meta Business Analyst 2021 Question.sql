/* Step 1: Create the table to store the data */
CREATE TABLE facebook_web_log (
    user_id INT,
    timestamp TIMESTAMP,
    action VARCHAR(50)
);

/* Step 2: Insert sample data into the table */
INSERT INTO facebook_web_log (user_id, timestamp, action) VALUES
(0, '2019-04-25 13:30:15', 'page_load'),
(0, '2019-04-25 13:30:18', 'page_load'),
(0, '2019-04-25 13:30:40', 'scroll_down'),
(0, '2019-04-25 13:30:45', 'scroll_up'),
(0, '2019-04-25 13:31:10', 'scroll_down'),
(0, '2019-04-25 13:31:25', 'scroll_down'),
(0, '2019-04-25 13:31:40', 'page_exit'),
(1, '2019-04-25 13:40:00', 'page_load'),
(1, '2019-04-25 13:40:10', 'scroll_down'),
(1, '2019-04-25 13:40:15', 'scroll_down'),
(1, '2019-04-25 13:40:20', 'scroll_down'),
(1, '2019-04-25 13:40:25', 'scroll_down'),
(1, '2019-04-25 13:40:30', 'scroll_down'),
(1, '2019-04-25 13:40:35', 'page_exit'),
(2, '2019-04-25 13:41:21', 'page_load'),
(2, '2019-04-25 13:41:30', 'scroll_down'),
(2, '2019-04-25 13:41:35', 'scroll_down'),
(2, '2019-04-25 13:41:40', 'scroll_up'),
(1, '2019-04-26 11:15:00', 'page_load'),
(1, '2019-04-26 11:15:10', 'scroll_down'),
(1, '2019-04-26 11:15:20', 'scroll_down'),
(1, '2019-04-26 11:15:25', 'scroll_up'),
(1, '2019-04-26 11:15:35', 'page_exit'),
(0, '2019-04-28 14:30:15', 'page_load'),
(0, '2019-04-28 14:30:10', 'page_load'),
(0, '2019-04-28 13:30:40', 'scroll_down'),
(0, '2019-04-28 15:31:40', 'page_exit');

/*
    Problem Statement:
    Meta wants to calculate each user's average session time. A session is defined as the time difference 
    between a 'page_load' and a 'page_exit'. Each user is assumed to have only one session per day.
    If there are multiple 'page_load' or 'page_exit' events on the same day, only the latest 'page_load' 
    and the earliest 'page_exit' should be considered, ensuring the 'page_load' occurs before the 'page_exit'.
    The goal is to calculate the average session time for each user across all days. 
    Output should include the user_id and their average session time in seconds.
*/

/* Step 3: Calculate average session time for each user */
WITH User_Sessions AS (
    SELECT 
        user_id, 
        DATE(timestamp) AS session_date,
        MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS latest_page_load,
        MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS earliest_page_exit
    FROM facebook_web_log
    GROUP BY user_id, DATE(timestamp)
    HAVING MAX(CASE WHEN action = 'page_load' THEN timestamp END) < 
           MIN(CASE WHEN action = 'page_exit' THEN timestamp END) -- Ensure valid session
)
SELECT 
    user_id,
    AVG(EXTRACT(EPOCH FROM (earliest_page_exit - latest_page_load))) AS average_session_time_seconds
FROM User_Sessions
GROUP BY user_id;
