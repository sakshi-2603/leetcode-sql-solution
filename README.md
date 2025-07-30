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

 

