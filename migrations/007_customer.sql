-- Заполняем измерение postal_code
INSERT INTO snowflake.postal_code(postal_code)
SELECT md.customer_postal_code
FROM mock.mock_data md
WHERE md.customer_postal_code IS NOT NULL
UNION
SELECT md.seller_postal_code
FROM mock.mock_data md
WHERE md.seller_postal_code IS NOT NULL
ON CONFLICT DO NOTHING;

-- Заполняем измерение customer
INSERT INTO snowflake.customer(customer_first_name, customer_last_name,
                               customer_age, customer_email,
                               customer_country_id, customer_postal_code_id)
SELECT md.customer_first_name,
       md.customer_last_name,
       md.customer_age,
       md.customer_email,
       c.id,
       pc.id
FROM mock.mock_data md
         LEFT JOIN snowflake.country c ON md.customer_country = c.country_name
         LEFT JOIN snowflake.postal_code pc ON md.customer_postal_code = pc.postal_code
ON CONFLICT DO NOTHING;