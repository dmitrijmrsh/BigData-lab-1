-- Заполняем измерение pet_type
INSERT INTO snowflake.pet_type(pet_type_name)
SELECT customer_pet_type
FROM mock.mock_data
ON CONFLICT (pet_type_name) DO NOTHING;

-- Заполняем измерение pet_breed
INSERT INTO snowflake.pet_breed(pet_type_id, pet_breed_name)
SELECT pt.id, customer_pet_breed
FROM mock.mock_data md LEFT JOIN snowflake.pet_type pt ON pt.pet_type_name = md.customer_pet_type
ON CONFLICT (pet_type_id, pet_breed_name) DO NOTHING;

-- Заполняем измерение pet
INSERT INTO snowflake.pet(pet_name, pet_type_id, pet_breed_id)
SELECT customer_pet_name, pt.id, pb.id
FROM mock.mock_data md
    LEFT JOIN snowflake.pet_type pt ON pt.pet_type_name = md.customer_pet_type
    LEFT JOIN snowflake.pet_breed pb ON pb.pet_breed_name = md.customer_pet_breed AND pb.pet_type_id = pt.id
ON CONFLICT DO NOTHING;