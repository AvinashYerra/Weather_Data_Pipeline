-- 1. What is the average temperature recorded each day?
SELECT
    DATE(timestamp) AS date,
    AVG(temperature) AS avg_temperature
FROM
    weather
GROUP BY
    DATE(timestamp)
ORDER BY
    date;

-- 2. Which city had the highest recorded temperature, and when?
SELECT
    city,
    timestamp,
    temperature
FROM
    weather
ORDER BY
    temperature DESC
LIMIT 1;

-- 3. What is the average humidity for each city?
SELECT
    city,
    AVG(humidity) AS avg_humidity
FROM
    weather
GROUP BY
    city
ORDER BY
    avg_humidity DESC;

-- 4. How does temperature vary throughout the day?
SELECT
    EXTRACT(HOUR FROM timestamp) AS hour,
    AVG(temperature) AS avg_temperature
FROM
    weather
GROUP BY
    hour
ORDER BY
    hour;

-- 5. What are the most common weather conditions recorded?
SELECT
    description,
    COUNT(*) AS occurrence
FROM
    weather
GROUP BY
    description
ORDER BY
    occurrence DESC;

-- 6. How many rainy days were recorded in each month?
SELECT
    EXTRACT(YEAR FROM timestamp) AS year,
    EXTRACT(MONTH FROM timestamp) AS month,
    COUNT(DISTINCT DATE(timestamp)) AS rainy_days
FROM
    weather
WHERE
    description ILIKE '%rain%'
GROUP BY
    year, month
ORDER BY
    year, month;

-- 7. What is the highest and lowest temperature recorded in each city?
SELECT
    city,
    MAX(temperature) AS max_temperature,
    MIN(temperature) AS min_temperature
FROM
    weather
GROUP BY
    city
ORDER BY
    city;

-- 8. Which city experienced the highest average humidity last month?
SELECT
    city,
    AVG(humidity) AS avg_humidity
FROM
    weather
WHERE
    timestamp >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
    AND timestamp < DATE_TRUNC('month', CURRENT_DATE)
GROUP BY
    city
ORDER BY
    avg_humidity DESC
LIMIT 1;

-- 9. What is the average temperature difference between consecutive days?
SELECT
    AVG(temp_diff) AS avg_temp_difference
FROM (
    SELECT
        DATE(timestamp) AS date,
        temperature - LAG(temperature) OVER (ORDER BY DATE(timestamp)) AS temp_diff
    FROM
        weather
) subquery
WHERE
    temp_diff IS NOT NULL;

-- 10. How does humidity correlate with temperature?
SELECT
    CORR(temperature, humidity) AS temp_humidity_correlation
FROM
    weather;
