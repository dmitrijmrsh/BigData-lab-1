-- Заполняем измерение store_location
INSERT INTO snowflake.store_location(store_location_name)
SELECT md.store_location
FROM mock.mock_data md ON CONFLICT DO NOTHING;

-- Заполняем измерение store_state
INSERT INTO snowflake.store_state(store_state_name)
SELECT md.store_state
FROM mock.mock_data md
WHERE md.store_state is not null
ON CONFLICT DO NOTHING;

-- Заполняем измерение store
INSERT INTO snowflake.store(store_name, store_location_id, store_city_id,
                            store_state_id, store_country_id,
                            store_phone, store_email)
SELECT md.store_name,
       sl.id,
       c.id,
       ss.id,
       cr.id,
       md.store_phone,
       md.store_email
FROM mock.mock_data md
         LEFT JOIN snowflake.country cr ON cr.country_name = md.store_country
         LEFT JOIN snowflake.store_location sl ON sl.store_location_name = md.store_location
         LEFT JOIN snowflake.city c ON c.city_name = md.store_city AND c.country_id = cr.id
         LEFT JOIN snowflake.store_state ss ON ss.store_state_name = md.store_state
ON CONFLICT DO NOTHING;