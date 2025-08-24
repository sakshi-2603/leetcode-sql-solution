-- LeetCode 1321. Restaurant Growth
-- Author: Your Name
-- Approach: Using self-join on daily sums and filtering for 7-day windows

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
