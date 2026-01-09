select  oo.order_id,
        DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date) as delay_days,
        oor.review_score,
        CASE
        WHEN DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date) <= 0
            THEN 'On-time / Early'
        WHEN DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date) BETWEEN 1 AND 3
            THEN 'Slight Delay'
        WHEN DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date) BETWEEN 4 AND 3
            THEN 'Moderate Delay'
        ELSE 'Severe Delay'
    END AS delay_bucket
        from olist_orders oo
    join olist_order_reviews oor on oor.order_id = oo.order_id
        where order_status = 'delivered'
    and oo.order_delivered_customer_date is not null
    and oo.order_estimated_delivery_date is not null;
