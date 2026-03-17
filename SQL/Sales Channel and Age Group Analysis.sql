SELECT
    customer_age_group,
    sales_channel,
    ROUND(SUM(revenue), 2) AS total_revenue,
     SUM(units_sold) AS total_units_sold,
    CONCAT(ROUND(100 * SUM(revenue) / SUM(SUM(revenue)) OVER (PARTITION BY customer_age_group),
    1), '%') AS pct_of_age_group_revenue,
    RANK() OVER(PARTITION BY customer_age_group ORDER BY SUM(revenue) DESC) AS channel_revenue_rank
FROM `samsung-sales-project.samsung_sales.sales_clean`
GROUP BY customer_age_group, sales_channel
ORDER BY customer_age_group, total_revenue DESC