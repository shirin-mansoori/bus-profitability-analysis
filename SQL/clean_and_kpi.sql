---------------------------Handling Missing values-------------------------------
WITH cleaned_records AS (
    SELECT 
        [DATE],
        COALESCE(LUGGAGE,0) AS LUGGAGE,                 --replacing nulls in LUGGAGE column with 0
        COALESCE(DIESEL,0) AS DIESEL,
        COALESCE(MAINTENANCE,0) AS MAINTENANCE,
        COALESCE(LABOUR,0) AS LABOUR,
        COALESCE(COLLECTED,0) AS COLLECTED,
        COALESCE(OTHER_EXPENSES,0) AS OTHER_EXPENSES,
        PASSENGER_REVENUE,
        GROSS_INCOME,
        (TOTAL_EXPENSES - COALESCE(COLLECTED,0)) AS TOTAL_EXPENSES_ADJ,
        (NET_INCOME + COALESCE(COLLECTED,0)) AS INCOME
    FROM bus_daily_records
),
------------------------------------aggregating based on months and calculating KPIs-----------------------------------
monthly_agg AS (
    SELECT
        FORMAT([DATE], 'yyyy-MM') AS Month,
        COUNT(*) AS Days_Operated,
        SUM(LUGGAGE) AS Luggage,
        SUM(GROSS_INCOME) AS Gross_Income,
        SUM(DIESEL) AS Diesel,
        SUM(MAINTENANCE) AS Maintenance,
        SUM(TOTAL_EXPENSES_ADJ) AS Total_Expenses,
        SUM(INCOME) AS Income,
        SUM(COLLECTED) AS Collected,
        SUM(LABOUR) AS Labour,
        SUM(OTHER_EXPENSES) AS Other_Expenses
    FROM cleaned_records
    GROUP BY FORMAT([DATE], 'yyyy-MM')
)
SELECT
    Month,
    Days_Operated,
    Gross_Income,
    Collected,
    Income,
    Gross_Income - Income - Total_Expenses AS [Check],
    ROUND(Income * 1.0 / NULLIF(Gross_Income,0), 2) AS Net_Profit_Margin,
    ROUND((Gross_Income - Diesel) * 1.0 / NULLIF(Gross_Income,0), 2) AS Gross_Margin_Ex_Fuel,
    ROUND(Diesel * 1.0 / NULLIF(190 * Days_Operated, 0), 2) AS Fuel_Cost_Per_KM,
    ROUND(Maintenance * 100.0 / NULLIF(Total_Expenses,0), 2) AS Maintenance_Exp_Share,
    ROUND(Diesel*100.0/NULLIF(Total_Expenses,0),2) AS Fuel_Exp_Share,
    ROUND(Labour*100.0/NULLIF(Total_Expenses,0),2) AS Labour_Exp_Share,
    ROUND(Other_Expenses*100.0/NULLIF(Total_Expenses,0),2) AS Other_Exp_Share,
    ROUND(Total_Expenses*100.0/NULLIF(Gross_income,0),2) AS Exp_Revenue_Share,
    Total_Expenses,
    ROUND(Luggage * 1.0 / NULLIF(Gross_Income,0), 2) AS Luggage_Revenue_Share
FROM monthly_agg
ORDER BY Month;