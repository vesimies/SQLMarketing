-- Number of the distinct campaigns
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;
-- Number of distinct sources
SELECT COUNT(DISTINCT utm_source)
FROM page_visits;
-- How they are related
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;
--Pages that are on the CoolTShirts website
SELECT DISTINCT(page_name)
FROM page_visits;
--How many first touches for each campaign?
WITH first_touch AS (
    SELECT user_id,
    MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_att AS (
  SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    )
SELECT ft_att.utm_campaign, ft_att.utm_source,
COUNT(*) AS first_touch_count
FROM ft_att
GROUP BY 1
ORDER BY 3 DESC;
--How many last touches for each campaign?
WITH last_touch AS (
    SELECT user_id,
    MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_att AS (
  SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    )
SELECT lt_att.utm_campaign, lt_att.utm_source,
COUNT(*) AS last_touch_count
FROM lt_att
GROUP BY 1
ORDER BY 3 DESC;
-- How many visitors purchase?
SELECT COUNT(*) AS all_who_purchase
FROM page_visits
WHERE page_name = '4 - purchase';
--How many visitors?
SELECT COUNT(DISTINCT user_id)
FROM page_visits;
--How many purchases from each campaign?
WITH last_touch AS (
    SELECT user_id,
    MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_att AS (
  SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    )
SELECT lt_att.utm_campaign, lt_att.utm_source,
COUNT(*) AS last_touch_count
FROM lt_att
GROUP BY 1
ORDER BY 3 DESC;