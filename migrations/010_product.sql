-- Заполняем измерение product_category
INSERT INTO snowflake.product_category(product_category_name)
SELECT md.product_category
FROM mock.mock_data md
ON CONFLICT DO NOTHING;

-- Заполняем измерение product_color
INSERT INTO snowflake.product_color(product_color_name)
SELECT md.product_color
FROM mock.mock_data md
ON CONFLICT DO NOTHING;

-- Заполняем измерение product_size
INSERT INTO snowflake.product_size(product_size_name)
SELECT md.product_size
FROM mock.mock_data md
ON CONFLICT DO NOTHING;

-- Заполняем измерение product_brand
INSERT INTO snowflake.product_brand(product_brand_name)
SELECT md.product_brand
FROM mock.mock_data md
ON CONFLICT DO NOTHING;

-- Заполняем измерение product_material
INSERT INTO snowflake.product_material(product_material_name)
SELECT md.product_material
FROM mock.mock_data md
ON CONFLICT DO NOTHING;

--
INSERT INTO snowflake.product(product_name,
                                product_category_id,
                                product_price,
                                product_quantity,
                                product_weight,
                                product_color_id,
                                product_size_id,
                                product_brand_id,
                                product_material_id,
                                product_description,
                                product_rating,
                                product_reviews,
                                product_release_date_id,
                                product_expire_date_id)
SELECT md.product_name,
       pc.id,
       md.product_price,
       md.product_quantity,
       md.product_weight,
       pcol.id,
       ps.id,
       pb.id,
       pm.id,
       md.product_description,
       md.product_rating,
       md.product_reviews,
       d1.id,
       d2.id
FROM mock.mock_data md
         LEFT JOIN snowflake.product_category pc ON pc.product_category_name = md.product_category
         LEFT JOIN snowflake.product_color pcol ON pcol.product_color_name = md.product_color
         LEFT JOIN snowflake.product_size ps ON ps.product_size_name = md.product_size
         LEFT JOIN snowflake.product_brand pb ON pb.product_brand_name = md.product_brand
         LEFT JOIN snowflake.product_material pm ON pm.product_material_name = md.product_material
         LEFT JOIN snowflake.date d1 ON d1.date = md.product_release_date
         LEFT JOIN snowflake.date d2 ON d2.date = md.product_expiry_date
         LEFT JOIN snowflake.supplier s ON md.supplier_name = s.supplier_name
ON CONFLICT DO NOTHING;