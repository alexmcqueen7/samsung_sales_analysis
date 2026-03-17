SELECT
    region,
    customer_age_group,
    SUM(CASE WHEN is_5g THEN units_sold ELSE 0 END) AS units_5g,
    SUM(units_sold) AS total_units_sold,
    ROUND(100 * SUM(CASE WHEN is_5g THEN units_sold ELSE 0 END) / SUM(units_sold), 1) AS pct_units_5g,
    ROUND(SUM(CASE WHEN is_5g THEN revenue ELSE 0 END), 2) AS revenue_5g,
    ROUND(SUM(revenue), 2) AS total_revenue,
    CONCAT(ROUND(100 * SUM(CASE WHEN is_5g THEN revenue ELSE 0 END) / NULLIF(SUM(revenue), 0), 1), '%')
        AS pct_revenue_5g,
    ROUND(SUM(CASE WHEN is_5g THEN revenue ELSE 0 END) / NULLIF(SUM(CASE WHEN is_5g THEN units_sold ELSE 0 END), 0), 2) AS revenue_per_5g_unit
FROM `samsung-sales-project.samsung_sales.sales_clean`
GROUP BY region, customer_age_group
ORDER BY region, customer_age_group; 