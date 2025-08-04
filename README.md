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
Description : Return the names of customers whose `referee_id` is **not 2** or is **NULL**.  
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
Find the number of times each customer visited the mall **without making any transactions**.
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
This repository contains a SQL solution to find days where the temperature was higher than the previous day. This is a classic SQL question involving **self joins**.
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
Return all movies with an **odd-numbered ID** and a **description not equal to 'boring'**.  
Sort the result by **rating in descending order**.

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
For each product, calculate its **average selling price**, based on units sold and price during each period.  
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
For each project, calculate the **average experience (in years)** of all employees working on it, rounded to **2 decimal places**.
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
Calculate the **percentage of users registered in each contest**, rounded to 2 decimal places.
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
- Poor Query Percentage**: The percentage of queries with `rating < 3` out of total queries for each `query_name`.
Table: Queries

| Column Name | Type    | Description                             |
|-------------|---------|-----------------------------------------|
| query_name  | varchar | Name of the query group                 |
| result      | varchar | Result or outcome of the query         |
| position    | int     | Rank of the result (1 to 500)          |
| rating      | int     | Rating of the result (1 to 5)          |

A query is considered **poor** if its rating is less than 3.
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

- `(player_id, event_date)` is the **primary key**.
- Each row indicates a login and gameplay record on a specific date with a device.

Problem Statement

Write an SQL query to **report the fraction** of players that logged in **again** on the **next day** after their **first login**, rounded to 2 decimal places.
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

