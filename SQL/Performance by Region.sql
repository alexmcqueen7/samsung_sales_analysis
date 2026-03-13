-- Q1. Which regions and countries generate the most revenue, and how is this changing over time?

SELECT
    region,
    EXTRACT(YEAR FROM sale_date) AS year,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(units_sold), 2) AS total_units_sold,
    COUNT(sale_id) AS total_orders
FROM samsung_sales.sales_clean
GROUP BY region, year
ORDER BY region, year;
