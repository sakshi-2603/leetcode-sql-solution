select d.name as Department ,e.name as Employee,e.salary as Salary 
  from Employee e join Department d on e.departmentId = d.id 
  where 3 > ( select COUNT(distinct e2.salary) 
  FROM Employee e2 
  WHERE e2.departmentId = e.departmentId 
  AND e2.salary > e.salary ) 
  order by d.name,e.salary desc;
