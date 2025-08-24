# leetcode-sql-solution
This repository contains my personal SQL solutions to LeetCode problems, organized by difficulty and topic. Each solution includes a direct link to the problem, a description, and the SQL query used to solve it.


1757. Recyclable and Low Fat Products  
Problem Link: [LeetCode 1757](https://leetcode.com/problems/recyclable-and-low-fat-products/)
Description: Return the `product_id` of products that are both low fat (`low_fats = 'Y'`) and recyclable (`recyclable = 'Y'`).
Solution:
sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

0584. Find Customer Referee  
Problem Link : [LeetCode 584](https://leetcode.com/problems/find-customer-referee/)  
Description : Return the names of customers whose `referee_id` is not 2 or is NULL.  
Solution :
sql
SELECT name
FROM Customer
WHERE referee_id IS NULL OR referee_id != 2;

Solved Problems

Easy

595. Big Countries  
Problem Link: [LeetCode 595](https://leetcode.com/problems/big-countries/)
Description: Find countries that are considered big based on area (≥ 3,000,000) or population (≥ 25,000,000).  
Solution:
sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

1581. Customer Who Visited but Did Not Make Any Transactions  
Problem Link: [LeetCode 1581](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/)
Description:  
Find the number of times each customer visited the mall without making any transactions.
SQL Solution:
sql
SELECT v.customer_id, COUNT(*) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
  ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;

1068. Product Sales Analysis I  
Problem Link: [LeetCode 1068](https://leetcode.com/problems/product-sales-analysis-i/)
Description:  
Report the `product_name`, `year`, and `price` from the sales table by joining with product information.
SQL Solution:
sql
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p
  ON s.product_id = p.product_id;

1378. Replace Employee ID with The Unique Identifier  
Problem Link: [LeetCode 1378](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)
Description:  
  Report each employee's `unique_id` and `name`. If no `unique_id` exists, return `null`.
SQL Solution:
sql
SELECT euni.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI euni
  ON e.id = euni.id;

1683. Invalid Tweets  
Problem Link: [LeetCode 1683](https://leetcode.com/problems/invalid-tweets/)
Description:  
  Find `tweet_id` of tweets with content length strictly greater than 15 characters.
SQL Solution:
sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

1148. Article Views I  
Problem Link: [LeetCode 1148](https://leetcode.com/problems/article-views-i/)
Description:  
  Return authors who have viewed at least one of their own articles.
SQL Solution:
sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

SQL: Find Warmer Days Compared to Previous Day
This repository contains a SQL solution to find days where the temperature was higher than the previous day. This is a classic SQL question involving self joins.
Problem Statement
Given a `Weather` table, return the IDs of the days when the temperature was higher than the previous day.
Table: Weather
| Column Name | Type    |
|-------------|---------|
| id          | int     |
| recordDate  | date    |
| temperature | int     |
`id` is the primary key.
Each row contains the temperature of a specific date.
Example
Input:
| id | recordDate | temperature |
|----|------------|-------------|
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
Output:
| id |
|----|
| 2  |
| 4  |
Explanation:
On 2015-01-02, temperature rose from 10 → 25 (so include `id = 2`)
On 2015-01-04, temperature rose from 20 → 30 (so include `id = 4`)
SQL Solution (Using Self Join)
sql
SELECT W1.id
FROM Weather W1
JOIN Weather W2
  ON DATEDIFF(W1.recordDate, W2.recordDate) =

SQL: Average Processing Time Per Machine

This repository contains a SQL solution to calculate the average processing time per machine based on process start and end timestamps.
Problem Statement
You are given an `Activity` table that logs when processes on machines start and end. Your task is to compute the average processing time for each machine.
Table: Activity
| Column Name    | Type   |
|----------------|--------|
| machine_id     | int    |
| process_id     | int    |
| activity_type  | enum   |
| timestamp      | float  |

- `(machine_id, process_id, activity_type)` forms the primary key.
- `activity_type` is either `'start'` or `'end'`.
- `timestamp` is the time at which the activity occurred.
SQL Solution
```sql
SELECT
    machine_id,
    ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM (
    SELECT
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM Activity
    GROUP BY machine_id, process_id
) AS process_times
GROUP BY machine_id;

SQL: Employees with Bonus Less Than 1000

This SQL solution returns the names and bonus amounts of employees who either:
- Have a bonus less than 1000, or
- Do not have any bonus at all (`NULL`).

Tables
Employee Table

| Column Name | Type    |
|-------------|---------|
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |

Bonus Table
| Column Name | Type |
|-------------|------|
| empId       | int  |
| bonus       | int  |

Example
Input:
Employee
| empId | name   | supervisor | salary |
|-------|--------|------------|--------|
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |

Bonus
| empId | bonus |
|-------|-------|
| 2     | 500   |
| 4     | 2000  |

Expected Output:

| name  | bonus |
|-------|-------|
| Brad  | NULL  |
| John  | NULL  |
| Dan   | 500   |

Query Logic
- We use a `LEFT JOIN` to include all employees, even if they don’t have an entry in the Bonus table.
- The `WHERE` clause filters:
  - Employees with a bonus less than 1000.
  - Or employees whose bonus is `NULL`.

✅ SQL Query

```sql
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

Student Exam Attendance Count 📚📝
This repository contains the SQL solution to determine how many times each student attended each subject's exam based on three related tables: Students, Subjects, and Examinations.
Tables Description
`Students`
- `student_id` (INT) – Primary Key
- `student_name` (VARCHAR)
`Subjects`
- `subject_name` (VARCHAR) – Primary Key
`Examinations`
- `student_id` (INT)
- `subject_name` (VARCHAR)
- May contain duplicates. Represents attendance per exam.
Problem Statement
Return a table with the number of times each student attended each exam, even if the count is `0`. The result should be sorted by `student_id` and `subject_name`.
SQL Approach
- Use `CROSS JOIN` to generate all student-subject combinations.
- Use `LEFT JOIN` on the `Examinations` table to count how many times each pair appears.
- Use `GROUP BY` to aggregate the count.
- Use `ORDER BY` to sort results as required.
Sample Output Format

| student_id | student_name | subject_name | attended_exams |
|------------|---------------|--------------|----------------|
| 1          | Alice         | Math         | 3              |
| 1          | Alice         | Physics      | 2              |
| 1          | Alice         | Programming  | 1              |
| ...        | ...           | ...          | ...            |

Student Exam Attendance Count 📚📝
This repository contains the SQL solution to determine how many times each student attended each subject's exam based on three related tables: Students, Subjects, and Examinations.
Tables Description
`Students`
- `student_id` (INT) – Primary Key
- `student_name` (VARCHAR)
`Subjects`
- `subject_name` (VARCHAR) – Primary Key
`Examinations`
- `student_id` (INT)
- `subject_name` (VARCHAR)
- May contain duplicates. Represents attendance per exam.
Problem Statement
Return a table with the number of times each student attended each exam, even if the count is `0`. The result should be sorted by `student_id` and `subject_name`.
SQL Approach
- Use `CROSS JOIN` to generate all student-subject combinations.
- Use `LEFT JOIN` on the `Examinations` table to count how many times each pair appears.
- Use `GROUP BY` to aggregate the count.
- Use `ORDER BY` to sort results as required.
Sample Output Format

| student_id | student_name | subject_name | attended_exams |
|------------|---------------|--------------|----------------|
| 1          | Alice         | Math         | 3              |
| 1          | Alice         | Physics      | 2              |
| 1          | Alice         | Programming  | 1              |
| ...        | ...           | ...          | ...            |

 
570. Managers with at Least 5 Direct Reports 
This repository contains the SQL solution to find all managers who have at least five direct reports.
Table Description
`Employee`
- `id` (INT): Primary key
- `name` (VARCHAR): Name of the employee
- `department` (VARCHAR): Department the employee belongs to
- `managerId` (INT): The `id` of the employee's manager
Problem Statement
Write an SQL query to find names of employees who are managers with at least 5 direct reports. Return the result in any order.
SQL Logic



1934. Confirmation Rate ✅📩
This repository contains the SQL solution for calculating the confirmation rate for each user based on their signup and message confirmation history.
Table Descriptions
`Signups`
- `user_id` (INT) — Primary key, unique for each user
- `time_stamp` (DATETIME) — Signup time
`Confirmations`
- `user_id` (INT) — Foreign key to `Signups.user_id`
- `time_stamp` (DATETIME)
- `action` (ENUM: 'confirmed', 'timeout') — The result of the confirmation attempt
---


Odd ID Movies Not Boring

[LeetCode Problem](https://leetcode.com/problems/movies-with-an-odd-numbered-id/)  
Return all movies with an odd-numbered ID and a description not equal to 'boring'.  
Sort the result by rating in descending order.

Example:
Input:
Cinema table:
+----+------------+-------------+--------+
| id | movie | description | rating |
+----+------------+-------------+--------+
| 1 | War | great 3D | 8.9 |
| 2 | Science | fiction | 8.5 |
| 3 | irish | boring | 6.2 |
| 4 | Ice song | Fantacy | 8.6 |
| 5 | House card | Interesting | 9.1 |
+----+------------+-------------+--------+

Output:

+----+------------+-------------+--------+
| id | movie | description | rating |
+----+------------+-------------+--------+
| 5 | House card | Interesting | 9.1 |
| 1 | War | great 3D | 8.9 |
+----+------------+-------------+--------+


Average Selling Price per Product

[LeetCode Problem](https://leetcode.com/problems/average-selling-price/)  
For each product, calculate its average selling price, based on units sold and price during each period.  
If a product was never sold, its average selling price is 0.00
### 📊 Schema:

Table: Prices
+------------+------------+------------+--------+
| product_id | start_date | end_date | price |
+------------+------------+------------+--------+
| 1 | 2019-02-17 | 2019-02-28 | 5 |
| 1 | 2019-03-01 | 2019-03-22 | 20 |
| 2 | 2019-02-01 | 2019-02-20 | 15 |
| 2 | 2019-02-21 | 2019-03-31 | 30 |
+------------+------------+------------+--------+

UnitsSold :
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1 | 2019-02-25 | 100 |
| 1 | 2019-03-01 | 15 |
| 2 | 2019-02-10 | 200 |
| 2 | 2019-03-22 | 30 |
+------------+---------------+-------+

Output:
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1 | 6.96 |
| 2 | 16.96 |
+------------+---------------+

Average Employee Experience per Project

[LeetCode Problem](https://leetcode.com/problems/project-employees-i/)  
For each project, calculate the average experience (in years) of all employees working on it, rounded to 2 decimal places.
📊 Schema:
Project Table :
+-------------+-------------+
| project_id | employee_id |
+-------------+-------------+
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 2 | 1 |
| 2 | 4 |
+-------------+-------------+

Employee :
+-------------+--------+------------------+
| employee_id | name | experience_years |
+-------------+--------+------------------+
| 1 | Khaled | 3 |
| 2 | Ali | 2 |
| 3 | John | 1 |
| 4 | Doe | 2 |
+-------------+--------+------------------+

Output:
+-------------+---------------+
| project_id | average_years |
+-------------+---------------+
| 1 | 2.00 |
| 2 | 2.50 |
+-------------+---------------+

Contest Registration Percentage

[LeetCode Problem](https://leetcode.com/problems/percentage-of-users-attended-a-contest/)  
Calculate the percentage of users registered in each contest, rounded to 2 decimal places.
Schema:
Users Table
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6 | Alice |
| 2 | Bob |
| 7 | Alex |


Query Quality and Poor Query Percentage

This query analyzes the performance of database queries by calculating two key metrics:

- Quality: Average of the ratio `(rating / position)` for each `query_name`.
- Poor Query Percentage: The percentage of queries with `rating < 3` out of total queries for each `query_name`.
Table: Queries

| Column Name | Type    | Description                             |
|-------------|---------|-----------------------------------------|
| query_name  | varchar | Name of the query group                 |
| result      | varchar | Result or outcome of the query         |
| position    | int     | Rank of the result (1 to 500)          |
| rating      | int     | Rating of the result (1 to 5)          |

A query is considered poor if its rating is less than 3.
### 🧮 Formula Definitions:

- Quality = `AVG(rating / position)`
- Poor Query Percentage = `(COUNT(rating < 3) / COUNT(*)) * 100`

Both values are rounded to 2 decimal places.
📊 Example Input:

Queries Table:

| query_name | result           | position | rating |
|------------|------------------|----------|--------|
| Dog        | Golden Retriever | 1        | 5      |
| Dog        | German Shepherd  | 2        | 5      |
| Dog        | Mule             | 200      | 1      |
| Cat        | Shirazi          | 5        | 2      |
| Cat        | Siamese          | 3        | 3      |
| Cat        | Sphynx           | 7        | 4      |

✅ Output:

| query_name | quality | poor_query_percentage |
|------------|---------|------------------------|
| Dog        | 2.50    | 33.33                  |
| Cat        | 0.66    | 33.33                  |

💡 Explanation:

- Dog
  - Quality: `(5/1 + 5/2 + 1/200) / 3 = 2.50`
  - Poor queries: 1 (rating 1) out of 3 → `33.33%`

- Cat
  - Quality: `(2/5 + 3/3 + 4/7) / 3 = 0.66`
  - Poor queries: 1 (rating 2) out of 3 → `33.33%`
📌 SQL Query Used:
```sql
SELECT 
    query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;


SQL: Monthly Transactions I
This solution calculates monthly statistics on transactions per country, including:
- The total number of transactions
- The total amount of all transactions
- The number of approved transactions
- The total amount of approved transactions

Table: Transactions

| Column Name | Type    |
|-------------|---------|
| id          | int     |
| country     | varchar |
| state       | enum ["approved", "declined"] |
| amount      | int     |
| trans_date  | date    |

Example

Input:

| id  | country | state    | amount | trans_date |
|-----|---------|----------|--------|------------|
| 121 | US      | approved | 1000   | 2018-12-18 |
| 122 | US      | declined | 2000   | 2018-12-19 |
| 123 | US      | approved | 2000   | 2019-01-01 |
| 124 | DE      | approved | 2000   | 2019-01-07 |

Expected Output:

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|---------|---------|-------------|----------------|--------------------|-----------------------|
| 2018-12 | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01 | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01 | DE      | 1           | 1              | 2000               | 2000                  |

SQL Query

```sql
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;


1174. Immediate Food Delivery II
This SQL problem asks you to find the percentage of immediate orders among the first orders of all customers.
An order is considered **immediate** if the `order_date` equals the `customer_pref_delivery_date`.
Table: Delivery

| Column Name                 | Type    |
|----------------------------|---------|
| delivery_id                | int     |
| customer_id                | int     |
| order_date                 | date    |
| customer_pref_delivery_date| date    |

- `delivery_id` is the primary key.
- Each customer has exactly one **first order** (the order with the earliest `order_date`).
Example

Input:

| delivery_id | customer_id | order_date | customer_pref_delivery_date |
|-------------|-------------|------------|-----------------------------|
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |

Output:

| immediate_percentage |
|----------------------|
| 50.00                |

Explanation

- For each customer, identify their **first order** by `MIN(order_date)`.
- Check if the first order was **immediate** (same day delivery).
- Calculate the percentage of such immediate first orders, rounded to 2 decimal places.
SQL Query

```sql
SELECT 
    ROUND(
        SUM(order_date = customer_pref_delivery_date) * 100.0 / COUNT(*),
        2
    ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
);


550. Game Play Analysis IV
This problem tracks player login behavior to calculate how many players logged in **on the day after** their first login.
Table: Activity

| Column Name  | Type    |
|--------------|---------|
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |

- `(player_id, event_date)` is the primary key.
- Each row indicates a login and gameplay record on a specific date with a device.

Problem Statement

Write an SQL query to report the fraction of players that logged in again on the next day after their first login, rounded to 2 decimal places.
Example

Input

| player_id | device_id | event_date | games_played |
|-----------|-----------|------------|--------------|
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |

Output

| fraction |
|----------|
| 0.33     |

Explanation

- Player 1 logged in again on 2016-03-02, which is the next day after their first login (2016-03-01).
- Players 2 and 3 did not log in the day after their first login.
- So only 1 out of 3 players qualifies ⇒ `1/3 = 0.33`.

SQL Solution

```sql
SELECT 
    ROUND(COUNT(DISTINCT a.player_id) / COUNT(DISTINCT b.player_id), 2) AS fraction
FROM Activity a
JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) b
ON a.player_id = b.player_id 
AND a.event_date = DATE_ADD(b.first_login, INTERVAL 1 DAY);


Problem:
2356. Number of Unique Subjects Taught by Each Teacher

The goal is to determine how many distinct subjects each teacher teaches, regardless of the department. Each row in the Teacher table represents a subject taught by a teacher in a department. A subject taught in multiple departments should only be counted once per teacher.

Table Schema:
Table: Teacher

teacher_id (int): ID of the teacher.

subject_id (int): ID of the subject taught.

dept_id (int): ID of the department where the subject is taught.

Primary Key: (subject_id, dept_id)

Approach:
Use COUNT(DISTINCT subject_id) to count unique subjects taught by each teacher.

Group the result by teacher_id to get per-teacher counts.

Sample Input:
teacher_id	subject_id	dept_id
1           	2         	3
1	            2	          4
1           	3         	3
2	            1         	1
2           	2	          1
2           	3	          1
2           	4	          1

Sample Output:
teacher_id	cnt
1	           2
2	           4

Teacher 1 teaches subject 2 in two departments (counted once) and subject 3 → total = 2.
Teacher 2 teaches subjects 1, 2, 3, 4 → total = 4.


1141. User Activity for the Past 30 Days I

You are given a table Activity that logs user actions on a social media platform. Each row represents a specific action by a user on a specific day within a session. Your task is to calculate the number of unique users active per day, only for the last 30 days ending on 2019-07-27 (inclusive).

A user is considered active on a day if they performed any activity on that day.

Table Schema:
Table: Activity

user_id (int): ID of the user.

session_id (int): ID of the session (belongs to one user).

activity_date (date): Date of the activity.

activity_type (enum): One of ('open_session', 'end_session', 'scroll_down', 'send_message').

Duplicates may exist in the table.

Approach:
Filter only the rows where activity_date is within the last 30 days ending on 2019-07-27, i.e., between '2019-06-28' and '2019-07-27'.

Group the rows by activity_date.

Count the number of distinct user_ids for each date — this gives the number of active users for that day.

Sample Input:
user_id	session_id	activity_date	activity_type
1	1	2019-07-20	open_session
1	1	2019-07-20	scroll_down
1	1	2019-07-20	end_session
2	4	2019-07-20	open_session
2	4	2019-07-21	send_message
2	4	2019-07-21	end_session
3	2	2019-07-21	open_session
3	2	2019-07-21	send_message
3	2	2019-07-21	end_session
4	3	2019-06-25	open_session

Sample Output:
day	active_users
2019-07-20	2
2019-07-21	2

We ignore 2019-06-25 since it's not within the last 30 days.

Only dates with at least one active user are returned.


Problem:
1070. Product Sales Analysis III

The goal is to identify and return all sales that occurred in the first year each product was sold.

🧾 Table Schema:
Table: Sales

sale_id (int): Unique ID of the sale (with year as part of the composite primary key).
product_id (int): Foreign key representing the product.
year (int): The year in which the sale occurred.
quantity (int): Number of units sold.
price (int): Price per unit of the product.
Note: A product can appear multiple times per year or across years.

✅ Approach:
Find the first year each product_id appears in the Sales table using:

sql
SELECT product_id, MIN(year) AS first_year
Join this result back to the original Sales table on both product_id and year to retrieve:

All sales that happened in that first year for each product.

Return the result with columns:
product_id, first_year, quantity, price

🧪 Sample Input:
sale_id	product_id	year	quantity	price
1	       100	      2008	  10	    5000
2	       100	      2009	  12	    5000
7	       200	      2011	  15	    9000

✅ Sample Output:
product_id	first_year	quantity	price
100	         2008	        10	    5000
200	         2011	        15	    9000


596. Classes With at Least 5 Students

You are given a table called Courses with records of students and the classes they are enrolled in. The task is to find all classes that have at least 5 students enrolled.

🧾 Table Schema:
Table: Courses
student (varchar): Name or ID of the student.
class (varchar): Name or ID of the class.
The (student, class) pair is unique.

✅ Approach:
Group by class to aggregate all students per class.
Use HAVING COUNT(student) >= 5 to filter only those classes with 5 or more students.
Return only the class column.

🧪 Sample Input:
student	class
A	Math
B	English
C	Math
D	Biology
E	Math
F	Computer
G	Math
H	Math
I	Math

✅ Sample Output:
class
Math
Explanation:
Math has 6 students → included
Other classes have < 5 students → excluded


Problem:
Return a list of all users and the number of followers each user has, based on the Followers table.

Table Schema:
user_id: ID of the user being followed.
follower_id: ID of the follower.
Each row in the table indicates that follower_id is following user_id.

Approach:
Group the data by user_id.
Count how many times each user_id appears (i.e., how many followers they have).
Sort the result by user_id in ascending order as required.

Output Columns:
user_id: the user.
followers_count: how many followers that user has.


Problem:
From the MyNumbers table, return the largest number that appears only once. If there is no such number, return null.

Approach:
Group by num to count how many times each number appears.
Use HAVING COUNT(*) = 1 to filter for numbers that appear only once (i.e., single numbers).
Use MAX() on the result to get the largest single number.
If no such number exists, the query will return null.

Output Column:
num: the largest number that occurs exactly once in the table. Returns null if no such number exists.


Problem:
Identify customers who have bought all products listed in the Product table.

Approach:
Group by customer_id to aggregate the products each customer has purchased.
Use COUNT(DISTINCT product_key) to count how many unique products each customer bought.
Compare that count to the total number of products using a subquery:
(SELECT COUNT(*) FROM Product)
Return only the customer_ids where both counts match.

Why it works:
If a customer has bought every unique product in the Product table, the number of distinct products they've bought must equal the total number of products available.
Duplicates in the Customer table are ignored using COUNT(DISTINCT ...).

Output Column:
customer_id: IDs of customers who bought all the products.


Problem - LeetCode 1789: Primary Department for Each Employee
Difficulty: Easy
Link: LeetCode 1789

Description:
Each employee can belong to multiple departments and must set one as primary (denoted by primary_flag = 'Y'). If an employee belongs to only one department, the flag will be 'N', but that department is still considered their primary department by default.
Return a list of each employee and their primary department.

Example Input:
Employee table:

mathematical
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
📤 Example Output:
diff
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
Approach:
Case 1: For employees who have explicitly marked a department as primary (primary_flag = 'Y'), we select that department.
Case 2: For employees who belong to only one department, we select that department even if the flag is 'N'.
Combine both using OR condition in the query


Problem - LeetCode 610: Triangle Judgement
Difficulty: Easy
Link: LeetCode 610

Description:
Each row in the table contains three integers representing the lengths of three line segments.
We need to determine whether these three sides can form a valid triangle.

Triangle Condition:
To form a triangle, the sum of any two sides must be greater than the third side:
x + y > z
x + z > y
y + z > x

Example Input:
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Example Output:
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
Approach:
Use a CASE statement to evaluate the triangle inequality conditions.
If all three conditions hold true, return "Yes"; otherwise, return "No".
This approach works because the triangle inequality theorem is a necessary and sufficient condition for a triangle.

🗂️ LeetCode SQL – 180. Consecutive Numbers  

📌 Problem Statement  
Table: Logs  

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+

id is the primary key and auto-incremented.
Find all numbers that appear at least three times consecutively.
Return result in any order.

✅ Example
Input:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
Output:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |

💡 SQL Solution
🔹 Approach 1: Self-Join
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1
JOIN Logs l3 ON l1.id = l3.id - 2
WHERE l1.num = l2.num 
  AND l2.num = l3.num;

🔹 Approach 2: Window Function
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num,
           LAG(num,1) OVER (ORDER BY id) AS prev1,
           LAG(num,2) OVER (ORDER BY id) AS prev2
    FROM Logs
) t
WHERE num = prev1 AND num = prev2;
Key Learnings
Self-Join checks consecutive rows by comparing id, id+1, id+2.
Window Functions (LAG/LEAD) provide a cleaner solution.
Always use DISTINCT to avoid duplicates.


Problem:

Given a Products table with product price changes, find the price of each product on 2019-08-16.
If a product has no price changes before that date, its price is considered 10 by default.

Schema:
Products(product_id INT, new_price INT, change_date DATE)
(product_id, change_date) is the primary key.

Example Input:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Example Output:
+------------+-------+
| product_id | price |
+------------+-------+
| 1          | 35    |
| 2          | 50    |
| 3          | 10    |
+------------+-------+

Solution Explanation:
Select all distinct products.
For each product, find the latest price change on or before 2019-08-16.
Use COALESCE to assign 10 if no change exists.

Problem:
We have a queue of people waiting to board a bus. Each person has a weight, and they board in the order of turn. The bus has a weight limit of 1000 kg. We need to find the name of the last person who can board without exceeding the weight limit.

Schema:
Queue(person_id INT, person_name VARCHAR, weight INT, turn INT)
person_id and turn contain unique values from 1 to n.

Example Input:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+

Example Output:
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+

Solution Explanation:
Order by turn to process boarding in sequence.
Use SUM(weight) OVER (ORDER BY turn) to track cumulative weight.
Filter out anyone exceeding 1000 kg cumulative weight.
Select the last valid person (highest turn before exceeding the limit).


Problem:
Given a table Accounts with monthly income for each account, we need to count how many accounts fall into each salary category:
Low Salary: income < 20000
Average Salary: income between 20000 and 50000 (inclusive)
High Salary: income > 50000
We must return all three categories, even if the count is 0.

Schema:
Accounts(account_id INT, income INT)
account_id is the primary key.

Example Input:
+------------+--------+
| account_id | income |
+------------+--------+
| 10         | 50001  |
| 6          | 19999  |
| 5          | 20000  |
| 7          | 50000  |
| 1          | 72417  |
+------------+--------+

Example Output:
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| High Salary    | 2              |
| Low Salary     | 1              |
| Average Salary | 2              |
+----------------+----------------+

Solution Explanation:
CASE WHEN checks which category each account belongs to.
SUM() counts how many accounts are in each category.
UNION ALL ensures all three categories are returned in a single result.
>= and <= ensure boundary values (20000, 50000) are included correctly.


LeetCode SQL – Employees With Missing Manager  

Problem  
Given the `Employees` table:  text
+-------------+----------+
| employee_id | name     |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
employee_id is the primary key.
Some employees do not have a manager (manager_id is NULL).
If a manager leaves, their record is deleted, but employees still retain that manager_id.
Find employees whose salary < 30000 and whose manager has left the company.
Return result ordered by employee_id.
Example
+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | null       | 31000  |
| 13          | Emery     | null       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | null       | 50937  |
| 11          | Joziah    | 6          | 28485  |
Output:
+-------------+
| employee_id |
+-------------+
| 11          |
SQL Solution
SELECT employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND e.manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;
Key Points
Filter employees with salary < 30000.
Check manager_id exists but manager record is missing.
Use NOT IN with a subquery to find managers who have left.
📄 solution.sql
sql
LeetCode: Employees With Missing Manager
SELECT employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND e.manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;

🗂️ LeetCode SQL – 626. Exchange Seats  

📌 Problem  
Table: Seat  
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key.
IDs start from 1 and increase continuously.
Swap seats of every two consecutive students.
If the number of students is odd, leave the last one unchanged.
Return results ordered by id.

✅ Example
Input:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
Output:
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |

💡 SQL Solution
SELECT 
    CASE
        WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
🏆 Key Learnings
Use CASE to conditionally swap IDs.
Odd rows swap with the next, even rows swap with the previous.
Handle last odd ID carefully by leaving it unchanged.


🗂️ LeetCode SQL – 1341. Movie Rating  
📌 Problem  
Tables: Movies, Users, MovieRating
Movies(movie_id, title)
Users(user_id, name)
MovieRating(movie_id, user_id, rating, created_at)
Task
Find the user who rated the most movies (tie → lexicographically smallest).
Find the movie with the highest average rating in Feb 2020 (tie → lexicographically smallest).
Return the results in a single column called results.

✅ Example
Input:
Movies:
+-----------+-----------+
| movie_id  | title     |
+-----------+-----------+
| 1         | Avengers  |
| 2         | Frozen 2  |
| 3         | Joker     |

Users:
+---------+---------+
| user_id | name    |
+---------+---------+
| 1       | Daniel  |
| 2       | Monica  |
| 3       | Maria   |
| 4       | James   |

MovieRating:
+----------+---------+--------+------------+
| movie_id | user_id | rating | created_at |
+----------+---------+--------+------------+
| 1        | 1       | 3      | 2020-01-12 |
| 1        | 2       | 4      | 2020-02-11 |
| 1        | 3       | 2      | 2020-02-12 |
| 1        | 4       | 1      | 2020-01-01 |
| 2        | 1       | 5      | 2020-02-17 |
| 2        | 2       | 2      | 2020-02-01 |
| 2        | 3       | 2      | 2020-03-01 |
| 3        | 1       | 3      | 2020-02-22 |
| 3        | 2       | 4      | 2020-02-25 |

Output:
+----------+
| results  |
+----------+
| Daniel   |
| Frozen 2 |

💡 SQL Solution
SELECT results
FROM (
    SELECT u.name AS results
    FROM Users u
    JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC, u.name ASC
    LIMIT 1
) top_user

UNION ALL

SELECT results
FROM (
    SELECT m.title AS results
    FROM Movies m
    JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE mr.created_at >= '2020-02-01' AND mr.created_at < '2020-03-01'
    GROUP BY m.movie_id, m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
) top_movie;
🏆 Key Learnings
Use GROUP BY + ORDER BY + LIMIT to find top records.
Handle ties with lexicographical sorting.
Use subqueries with UNION ALL to combine multiple results into one table.
Filter dates using >= start AND < next month for precise monthly queries.


# 🍽️ LeetCode SQL – 1321. Restaurant Growth  
📌 Problem  
You are the restaurant owner and want to compute 7-day moving averages of customer spending.
Table: Customer
customer_id (int), name (varchar), visited_on (date), amount (int)
- `(customer_id, visited_on)` is the primary key.
- There is at least one customer every day.
- Output: For each day (starting from the 7th), show:
  - `visited_on`
  - `amount` (total spent in last 7 days)
  - `average_amount` (rounded to 2 decimals

Example
Input:
+-------------+---------+-------------+--------+
| customer_id | name | visited_on | amount |
+-------------+---------+-------------+--------+
| 1 | Jhon | 2019-01-01 | 100 |
| 2 | Daniel | 2019-01-02 | 110 |
| 3 | Jade | 2019-01-03 | 120 |
| 4 | Khaled | 2019-01-04 | 130 |
| 5 | Winston | 2019-01-05 | 110 |
| 6 | Elvis | 2019-01-06 | 140 |
| 7 | Anna | 2019-01-07 | 150 |
| 8 | Maria | 2019-01-08 | 80 |
| 9 | Jaze | 2019-01-09 | 110 |
| 1 | Jhon | 2019-01-10 | 130 |
| 3 | Jade | 2019-01-10 | 150 |

makefile

Output:
+-------------+--------+----------------+
| visited_on | amount | average_amount |
+-------------+--------+----------------+
| 2019-01-07 | 860 | 122.86 |
| 2019-01-08 | 840 | 120.00 |
| 2019-01-09 | 840 | 120.00 |
| 2019-01-10 | 1000 | 142.86 |

SQL Solution (Your Query)
```sql
SELECT
  d1.visited_on,
  SUM(d2.day_amount) AS amount,
  ROUND(SUM(d2.day_amount) / 7, 2) AS average_amount
FROM (
  SELECT visited_on, SUM(amount) AS day_amount
  FROM Customer
  GROUP BY visited_on
) AS d1
JOIN (
  SELECT visited_on, SUM(amount) AS day_amount
  FROM Customer
  GROUP BY visited_on
) AS d2
  ON d2.visited_on BETWEEN DATE_SUB(d1.visited_on, INTERVAL 6 DAY) AND d1.visited_on
GROUP BY d1.visited_on
HAVING COUNT(*) = 7
ORDER BY d1.visited_on;
🏆 Key Points
First aggregate by day using SUM(amount) per visited_on.
Self-join to include last 7 days using DATE_SUB.
Use HAVING COUNT(*) = 7 to ensure a full 7-day window.
Use ROUND(..., 2) to format decimals.


Problem:
Find the user with the most friends from the RequestAccepted table. A friendship exists if a user either sent or received a request.
Approach:
Select requester_id and accepter_id as id using UNION ALL to include both sent and received requests.
Group by id to count how many friends each user has.
Sort by friend count in descending order and return the top user.
Output:
Returns the id of the user with the most friends and their total num of friends.

Example:
Input:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |

Output:
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+

Problem :  585. Investments in 2016
This query solves the problem of finding the total investment value in 2016 (tiv_2016) for policyholders who meet two conditions:
Their 2015 investment (tiv_2015) matches with at least one other policyholder.
Their location (lat, lon) is unique.

Approach:
Use a subquery to find tiv_2015 values that appear more than once.
Use another subquery to find unique locations (lat, lon) that appear only once.
Filter records satisfying both conditions.
Sum their tiv_2016 and round to 2 decimal places.

Complexity:
Time Complexity: O(n) due to grouping and filtering.
Space Complexity: O(n) for subqueries.

Example:
Input:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |

Output:
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: PIDs 1 & 4 satisfy both conditions (tiv_2015 shared and unique location), so sum = 5 + 40 = 45.00.
