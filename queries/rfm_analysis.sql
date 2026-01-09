SELECT  oc.customer_unique_id,
        SUM(oop.payment_value) AS Monetary,
        COUNT(DISTINCT oo.order_id) AS Frequency,
        DATEDIFF((SELECT MAX(order_purchase_timestamp) FROM olist_orders WHERE order_status = 'delivered'), MAX(oo.order_purchase_timestamp)) AS Recency
        FROM olist_orders oo
    JOIN olist_order_payments oop ON oo.order_id = oop.order_id COLLATE utf8mb4_general_ci
    JOIN olist_customers oc ON oc.customer_id = oo.customer_id COLLATE utf8mb4_general_ci
    WHERE oo.order_status = 'delivered'
    GROUP BY oc.customer_unique_id;
