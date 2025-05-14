-- Заполняем измерение city
INSERT INTO snowflake.city(country_id, city_name)
SELECT c.id,supplier_city
FROM mock.mock_data LEFT JOIN snowflake.country c ON supplier_country = c.country_name
UNION
SELECT c.id,store_city
FROM mock.mock_data JOIN snowflake.country c ON store_country = c.country_name
ON CONFLICT (country_id, city_name) DO NOTHING;