-- Novacart Key Performance Indicators

SELECT
	'Total Revenue' AS measure_name,
	ROUND(SUM(net_revenue_usd), 2) AS measure_value
FROM [event]
UNION ALL
SELECT
	'Average Order Value', SUM(net_revenue_usd) / COUNT(DISTINCT event_id)
FROM [event]
UNION ALL
SELECT 
	'Total Transactions', COUNT(DISTINCT [event_id])
FROM [event]
UNION ALL
SELECT
	'Total Customers', COUNT(DISTINCT [customer_id])
FROM [dbo].[customer]
UNION ALL
SELECT
	'Subscription Revenue %', ROUND(SUM( CASE
		WHEN p.is_subscription = 1 THEN e.net_revenue_usd END )
		/ SUM(net_revenue_usd), 2)
FROM [event] e
LEFT JOIN [product] p
	ON e.product_id = p.product_id


-- Establishing referential integrity between transactional and dimension tables
ALTER TABLE [event]
	ADD CONSTRAINT FK_event_product FOREIGN KEY (product_id) REFERENCES [product](product_id);
ALTER TABLE [event]
	ADD CONSTRAINT FK_event_customer FOREIGN KEY (customer_id) REFERENCES [customer](customer_id);

-- Key Metrics 
-- Assessing the revenue mix between subscription-based and one-time purchases
SELECT
	CASE 
		WHEN  p.[is_subscription] = 1 THEN 'Subscription' 
		ELSE 'One-Time'
	END AS subscription_type,
	ROUND(SUM(e.net_revenue_usd),2) AS total_revenue,
	ROUND(
		SUM(e.net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event]),
		2
		) AS perc_total
FROM [dbo].[event] e
LEFT JOIN [product] p
	ON e.product_id = p.product_id
GROUP BY 
	CASE p.[is_subscription]
		WHEN  1 THEN 'Subscription'
		ELSE 'One-Time'
	END
ORDER BY total_revenue DESC;

/* Revenue concentration analysis
This section evaluates whether revenue is broadly diversified or disproportionately driven by a limited
set of products, customer segments, or regions—highlighting potential concentration risk and dependency. */

-- Revenue contribution by product category
SELECT
	p.category,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue,
	CEILING(
		SUM(e.net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event])
		) AS perc_total
FROM [event] e
LEFT JOIN [product] p
	ON e.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Revenue contribution by customer segment
SELECT
	c.segment,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue,
	CEILING(
		SUM(e.net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event])
		) AS perc_total
FROM [event] e
LEFT JOIN customer c
	ON e.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_revenue DESC;

-- Regional impact on revenue
SELECT
	region,
	ROUND(SUM(net_revenue_usd), 2) total_revenue,
	CEILING(
		SUM(net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event])
		) AS perc_total
FROM [event]
GROUP BY region
ORDER BY total_revenue DESC;

/* Customer value assessment
This analysis identifies high-value customer groups by examining revenue contribution
across customer segments and acquisition channels. */

-- Contribution of acquisition channels to revenue
SELECT
	c.acquisition_channel,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue,
	CEILING(
		SUM(e.net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event])
		) AS perc_total
FROM [event] e
LEFT JOIN customer c
	ON e.customer_id = c.customer_id
GROUP BY c.acquisition_channel
ORDER BY total_revenue DESC;

-- Impacts of age_band on revenue
SELECT
	c.age_band,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue,
	CEILING(
		SUM(e.net_revenue_usd)  * 100 / 
		(SELECT SUM(net_revenue_usd) FROM [event])
		) AS perc_total
FROM [event] e
LEFT JOIN customer c
	ON e.customer_id = c.customer_id
GROUP BY c.age_band
ORDER BY total_revenue DESC;


/* Revenue leakage analysis
This section evaluates the impact of refunds and discounts on overall performance
and identifies whether revenue leakage is concentrated across specific products,
regions, or customer segments. */

-- Impacts of refunds and discounts on customer segment performance
SELECT
	c.segment,
	SUM(CASE 
		WHEN e.is_refunded = 1 THEN 1
		ELSE 0 END
	) AS refunds,
	ROUND(SUM(e.discount_local), 2) discounts,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue
FROM [event] e
LEFT JOIN customer c
	ON e.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_revenue DESC;

-- Impacts of refunds and discounts on product performance
SELECT
	p.category,
	SUM(CASE 
		WHEN e.is_refunded = 1 THEN 1
		ELSE 0 END
	) AS refunds,
	ROUND(SUM(e.discount_local), 2) discounts,
	ROUND(SUM(e.net_revenue_usd), 2) total_revenue
FROM [event] e
LEFT JOIN [product] p
	ON e.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Impacts of refunds and discounts on regional performance
SELECT
	region,
	SUM(CASE 
		WHEN is_refunded = 1 THEN 1
		ELSE 0 END
	) AS refunds,
	ROUND(SUM(discount_local), 2) discounts,
	ROUND(SUM(net_revenue_usd), 2) total_revenue
FROM [event] 
GROUP BY region
ORDER BY total_revenue DESC;

/* Revenue stability and seasonality analysis
This analysis examines revenue trends over time, with particular emphasis on
the stability and predictability of subscription-based revenue compared to one-time purchases. */

-- How stable and predictable is our revenue base?
SELECT
    YEAR(e.event_date) AS year,
    MONTH(e.event_date) AS month_number,
    DATENAME(MONTH, e.event_date) AS month_name,
    CASE 
        WHEN p.is_subscription = 1 THEN 'Subscription'
        ELSE 'One-Time'
    END AS revenue_type,
    ROUND(SUM(e.net_revenue_usd), 2) AS total_revenue
FROM [event] e
LEFT JOIN product p
    ON e.product_id = p.product_id
GROUP BY
    YEAR(e.event_date),
    MONTH(e.event_date),
    DATENAME(MONTH, e.event_date),
    p.is_subscription
ORDER BY year, month_number;

