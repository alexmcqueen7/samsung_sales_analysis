WITH discount AS (
    SELECT
        CASE
            WHEN discount_pct =0 THEN 'No discount'
            WHEN discount_pct >0 AND discount_pct <= 5 THEN '0-5%'
            WHEN discount_pct >5 and discount_pct <=10 THEN '5-10%'
            WHEN discount_pct >10 and discount_pct <= 15 THEN '10-15%'
            WHEN discount_pct >15 and discount_pct <=20 THEN '15-20%'
        END AS discount_band,
        region,
        category,
        ROUND(SUM(revenue),2) AS total_revenue,
        SUM(units_sold) AS total_units_sold,
        COUNT(DISTINCT sale_id) AS total_orders
    FROM `samsung_sales.sales_clean`
    GROUP BY region, discount_band, category
)

SELECT
    discount_band,
    region,
    category,
    total_revenue,
    total_units_sold,
    total_orders,
    ROUND(total_revenue / total_units_sold, 2) AS revenue_per_unit,
    CONCAT(ROUND(100* total_revenue / SUM(total_revenue) OVER (PARTITION BY region, category), 0), '%') AS revenue_share,
    RANK() OVER (PARTITION BY region, category ORDER BY total_revenue DESC) AS revenue_rank
FROM discount
ORDER BY region, category, revenue_rank;