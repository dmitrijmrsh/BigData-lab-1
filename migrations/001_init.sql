CREATE SCHEMA IF NOT EXISTS mock;

CREATE TABLE IF NOT EXISTS mock.mock_data (
  id INT,
  customer_first_name VARCHAR,
  customer_last_name VARCHAR,
  customer_age INT,
  customer_email VARCHAR,
  customer_country VARCHAR,
  customer_postal_code VARCHAR,
  customer_pet_type VARCHAR,
  customer_pet_name VARCHAR,
  customer_pet_breed VARCHAR,
  seller_first_name VARCHAR,
  seller_last_name VARCHAR,
  seller_email VARCHAR,
  seller_country VARCHAR,
  seller_postal_code VARCHAR,
  product_name VARCHAR,
  product_category VARCHAR,
  product_price NUMERIC(10, 2),
  product_quantity INT,
  sale_date DATE,
  sale_customer_id INT,
  sale_seller_id INT,
  sale_product_id INT,
  sale_quantity INT,
  sale_total_price NUMERIC(10, 2),
  store_name VARCHAR,
  store_location VARCHAR,
  store_city VARCHAR,
  store_state VARCHAR,
  store_country VARCHAR,
  store_phone VARCHAR,
  store_email VARCHAR,
  pet_category VARCHAR,
  product_weight NUMERIC(10, 2),
  product_color VARCHAR,
  product_size VARCHAR,
  product_brand VARCHAR,
  product_material VARCHAR,
  product_description TEXT,
  product_rating NUMERIC(10, 2),
  product_reviews NUMERIC(10, 2),
  product_release_date DATE,
  product_expiry_date DATE,
  supplier_name VARCHAR,
  supplier_contact VARCHAR,
  supplier_email VARCHAR,
  supplier_phone VARCHAR,
  supplier_address VARCHAR,
  supplier_city VARCHAR,
  supplier_country VARCHAR
);

COPY mock.mock_data FROM '/source/MOCK_DATA.csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA.csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (2).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (3).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (4).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (5).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (6).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (7).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (8).csv' DELIMITER ',' CSV HEADER;
COPY mock.mock_data FROM '/source/MOCK_DATA (9).csv' DELIMITER ',' CSV HEADER;