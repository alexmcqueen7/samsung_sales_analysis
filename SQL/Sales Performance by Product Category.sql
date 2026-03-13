WITH product_region AS (
    SELECT
        region,
        category,
        ROUND(SUM(revenue), 2) AS total_revenue,
        SUM(units_sold) AS total_units_sold,
        COUNT(DISTINCT sale_id) AS total_orders
    FROM samsung_sales.sales_clean
    GROUP BY region, category
),

ranked_products AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM product_region
)

SELECT
    region,
    category,
    total_revenue,
    total_units_sold,
    total_orders,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 5
ORDER BY region, revenue_rank;