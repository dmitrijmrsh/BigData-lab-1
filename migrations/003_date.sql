-- Заполняем измерение year
INSERT INTO snowflake.year(year_number)
SELECT extract(YEAR FROM product_release_date)
FROM mock.mock_data
UNION
SELECT extract(YEAR FROM product_expiry_date)
FROM mock.mock_data
UNION
SELECT extract(YEAR FROM sale_date)
FROM mock.mock_data ON CONFLICT DO NOTHING;

-- Заполняем измерение month
INSERT INTO snowflake.month(month_number)
SELECT extract(MONTH FROM product_release_date)
FROM mock.mock_data
UNION
SELECT extract(MONTH FROM product_expiry_date)
FROM mock.mock_data
UNION
SELECT extract(MONTH FROM sale_date)
FROM mock.mock_data ON CONFLICT DO NOTHING;

-- Заполняем измерение day
INSERT INTO snowflake.day(day_number)
SELECT extract(DAY FROM product_release_date)
FROM mock.mock_data
UNION
SELECT extract(DAY FROM product_expiry_date)
FROM mock.mock_data
UNION
SELECT extract(DAY FROM sale_date)
FROM mock.mock_data ON CONFLICT DO NOTHING;

-- Заполняем измерение date
INSERT INTO snowflake.date(date, day_id, month_id, year_id)
SELECT product_release_date,
       d.id,
       m.id,
       y.id
FROM mock.mock_data
         LEFT JOIN snowflake.day d ON d.day_number = extract(DAY FROM product_release_date)
         LEFT JOIN snowflake.month m ON m.month_number = extract(MONTH FROM product_release_date)
         LEFT JOIN snowflake.year y on y.year_number = extract(YEAR FROM product_release_date)
UNION
SELECT product_expiry_date,
       d.id,
       m.id,
       y.id
FROM mock.mock_data
         LEFT JOIN snowflake.day d ON d.day_number = extract(DAY FROM product_expiry_date)
         LEFT JOIN snowflake.month m ON m.month_number = extract(MONTH FROM product_expiry_date)
         LEFT JOIN snowflake.year y on y.year_number = extract(YEAR FROM product_expiry_date)
UNION
SELECT sale_date,
       d.id,
       m.id,
       y.id
FROM mock.mock_data
         LEFT JOIN snowflake.day d ON d.day_number = extract(DAY FROM sale_date)
         LEFT JOIN snowflake.month m ON m.month_number = extract(MONTH FROM sale_date)
         LEFT JOIN snowflake.year y on y.year_number = extract(YEAR FROM sale_date)

ON CONFLICT(day_id, month_id, year_id) DO NOTHING;