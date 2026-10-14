

-- E-COMMERCE SALES ANALYTICS PROJECT
-- SQL BUSINESS ANALYSIS
-- Database: ecommerce_analytics.db

-- ========================================
-- QUERY 1: TOP 5 PRODUCT CATEGORIES
-- ========================================

SELECT
    category_english,
    COUNT(*) AS total_items,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS merchandise_value,
    ROUND(AVG(price), 2) AS avg_item_price
FROM category_sales
GROUP BY category_english
ORDER BY merchandise_value DESC
LIMIT 5;


-- ========================================
-- QUERY 2: DELIVERY AND CUSTOMER SATISFACTION
-- ========================================

SELECT
    CASE
        WHEN late_delivery = 1 THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,

    COUNT(*) AS total_orders,

    ROUND(AVG(avg_review_score), 2) AS avg_review_score,

    SUM(
        CASE
            WHEN avg_review_score <= 2 THEN 1
            ELSE 0
        END
    ) AS low_rated_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN avg_review_score <= 2 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS low_rating_pct

FROM delivery_reviews
WHERE avg_review_score IS NOT NULL

GROUP BY
    CASE
        WHEN late_delivery = 1 THEN 'Late'
        ELSE 'On Time'
    END

ORDER BY delivery_status;
