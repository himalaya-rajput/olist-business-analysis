WITH total_leads AS (
    SELECT COUNT(DISTINCT mql_id) AS total_leads
    FROM olist_marketing_leads
),
closed_deals AS (
    SELECT COUNT(DISTINCT mql_id) AS closed_deals
    FROM olist_closed_deals
),
active_sellers AS (
    SELECT COUNT(DISTINCT ocd.seller_id) AS active_sellers
    FROM olist_closed_deals ocd
    JOIN olist_order_items ooi
        ON ocd.seller_id COLLATE utf8mb4_unicode_ci
         = ooi.seller_id COLLATE utf8mb4_unicode_ci
    JOIN olist_orders oo
    ON oo.order_id COLLATE utf8mb4_unicode_ci
     = ooi.order_id COLLATE utf8mb4_unicode_ci
    WHERE oo.order_status = 'delivered'
)

SELECT
    tl.total_leads,
    cd.closed_deals,
    a.active_sellers,

    (cd.closed_deals * 100.0 / tl.total_leads) AS lead2deal_conv_rate,
    (a.active_sellers * 100.0 / cd.closed_deals) AS deal2active_seller_conv_rate,
    (a.active_sellers * 100.0 / tl.total_leads) AS overall_conversion
FROM total_leads tl
CROSS JOIN closed_deals cd
CROSS JOIN active_sellers a;
