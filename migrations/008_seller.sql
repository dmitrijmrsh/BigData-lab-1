-- Заполняем измерение seller
INSERT INTO snowflake.seller(seller_first_name, seller_last_name, seller_email,
                             seller_country_id, seller_postal_code_id)
SELECT md.seller_first_name,
       md.seller_last_name,
       md.seller_email,
       c.id,
       pc.id
FROM mock.mock_data md
         LEFT JOIN snowflake.country c ON c.country_name = md.seller_country
         LEFT JOIN snowflake.postal_code pc ON pc.postal_code = md.seller_postal_code
ON CONFLICT DO NOTHING;