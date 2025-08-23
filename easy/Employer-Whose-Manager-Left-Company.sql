-- LeetCode 615. Find Employees Whose Manager Left the Company

SELECT employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND e.manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;
