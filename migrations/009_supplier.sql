-- Заполняем измерение supplier_address
INSERT INTO snowflake.supplier_address(supplier_address)
SELECT md.supplier_address
FROM mock.mock_data md
WHERE md.supplier_address IS NOT NULL
ON CONFLICT DO NOTHING;

-- Заполняем измерение supplier
INSERT INTO snowflake.supplier(supplier_name, supplier_contact, supplier_email,
                                 supplier_phone, supplier_address_id,
                                 supplier_city_id, supplier_country_id)
SELECT md.supplier_name,
       md.supplier_contact,
       md.supplier_email,
       md.supplier_phone,
       sa.id,
       c.id,
       co.id
FROM mock.mock_data md
         LEFT JOIN snowflake.supplier_address sa ON sa.supplier_address = md.supplier_address
         LEFT JOIN snowflake.country co ON co.country_name = md.supplier_country
         LEFT JOIN snowflake.city c ON c.city_name = md.supplier_city AND c.country_id = co.id
ON CONFLICT DO NOTHING;