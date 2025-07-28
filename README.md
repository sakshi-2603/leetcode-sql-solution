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
