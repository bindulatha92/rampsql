SELECT 
    `date`,
    AVG(`total_amount`) OVER (
        ORDER BY `date`
        RANGE BETWEEN INTERVAL 2 DAY PRECEDING AND CURRENT ROW
    ) AS `rolling_3_day_avg`
FROM (
    SELECT 
        DATE(`transaction_time`) AS `date`, 
        SUM(`transaction_amount`) AS `total_amount`
    FROM 
        `transactions`
    WHERE 
        DATE(`transaction_time`) <= '2021-01-31'
    GROUP BY 
        DATE(`transaction_time`)
) AS daily_totals
WHERE `date` = '2021-01-31';
