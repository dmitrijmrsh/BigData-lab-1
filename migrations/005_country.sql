-- Заполняем измерение country
INSERT INTO snowflake.country(country_name)
SELECT customer_country
FROM mock.mock_data
UNION
SELECT seller_country
FROM mock.mock_data
UNION
SELECT store_country
FROM mock.mock_data
UNION
SELECT supplier_country
FROM mock.mock_data
UNION
SELECT seller_country
FROM mock.mock_data
ON CONFLICT (country_name) DO NOTHING;