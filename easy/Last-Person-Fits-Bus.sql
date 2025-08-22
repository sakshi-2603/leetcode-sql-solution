SELECT person_name
FROM (
    SELECT 
        person_name,
        SUM(weight) OVER (ORDER BY turn) AS running_weight,
        turn
    FROM Queue
) t
WHERE running_weight <= 1000
ORDER BY turn DESC
LIMIT 1;
