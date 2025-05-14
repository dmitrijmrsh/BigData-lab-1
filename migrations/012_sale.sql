--Заполняем факт sale
INSERT INTO snowflake.sale (customer_id,
                            customer_pet_id,
                            seller_id,
                            sale_date_id,
                            sale_quantity,
                            sale_total_price,
                            store_id)
SELECT c.id,
       p.id,
       s.id,
       d.id,
       md.sale_quantity,
       md.sale_total_price,
       st.id
FROM mock.mock_data md
    LEFT JOIN snowflake.customer c ON
        c.customer_first_name = md.customer_first_name AND
        c.customer_last_name = md.customer_last_name AND
        c.customer_age = md.customer_age AND
        c.customer_email = md.customer_email
    LEFT JOIN snowflake.country cc ON cc.country_name = md.customer_country
    LEFT JOIN snowflake.postal_code cp ON cp.postal_code = md.customer_postal_code
    LEFT JOIN snowflake.pet_type pt ON pt.pet_type_name = md.customer_pet_type
    LEFT JOIN snowflake.pet_breed pb ON pb.pet_breed_name = md.customer_pet_breed AND pb.pet_type_id = pt.id
    LEFT JOIN snowflake.pet p ON p.pet_name = md.customer_pet_name AND p.pet_breed_id = pb.id AND p.pet_type_id = pt.id
    LEFT JOIN snowflake.seller s ON
        s.seller_first_name = md.seller_first_name AND
        s.seller_last_name = md.seller_last_name AND
        s.seller_email = md.seller_email
    LEFT JOIN snowflake.country sc ON sc.country_name = md.seller_country
    LEFT JOIN snowflake.postal_code sp ON sp.postal_code = md.seller_postal_code
    LEFT JOIN snowflake.date d ON
        d.day_id = (SELECT id FROM snowflake.day WHERE day_number = EXTRACT(DAY FROM md.sale_date)) AND
        d.month_id = (SELECT id FROM snowflake.month WHERE month_number = EXTRACT(MONTH FROM md.sale_date)) AND
        d.year_id = (SELECT id FROM snowflake.year WHERE year_number = EXTRACT(YEAR FROM md.sale_date))
    LEFT JOIN snowflake.store st ON
        st.store_name = md.store_name AND
        st.store_phone = md.store_phone AND
        st.store_email = md.store_email
    LEFT JOIN snowflake.store_location sl ON sl.store_location_name = md.store_location
    LEFT JOIN snowflake.country scountry ON scountry.country_name = md.store_country
    LEFT JOIN snowflake.city scity ON scity.city_name = md.store_city AND scity.country_id = scountry.id
    LEFT JOIN snowflake.store_state sstate ON sstate.store_state_name = md.store_state;