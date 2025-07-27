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
