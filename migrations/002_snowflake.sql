CREATE SCHEMA IF NOT EXISTS snowflake;

--Инициализация таблиц измерений (dimensions)

CREATE TABLE IF NOT EXISTS snowflake.day (
    id SERIAL PRIMARY KEY,
    day_number INTEGER UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.month (
    id SERIAL PRIMARY KEY,
    month_number INTEGER UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.year (
    id SERIAL PRIMARY KEY,
    year_number INTEGER UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.date (
    id BIGSERIAL PRIMARY KEY,
    date DATE NOT NULL,
    day_id INTEGER REFERENCES snowflake.day (id),
    month_id INTEGER REFERENCES snowflake.month (id),
    year_id  INTEGER REFERENCES snowflake.year (id),
    UNIQUE (day_id, month_id, year_id)
);

CREATE TABLE IF NOT EXISTS snowflake.country (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.city (
    id SERIAL PRIMARY KEY,
    country_id INTEGER REFERENCES snowflake.country (id),
    city_name VARCHAR NOT NULL,
    UNIQUE (city_name, country_id)
);

CREATE TABLE IF NOT EXISTS snowflake.pet_type (
    id SERIAL PRIMARY KEY,
    pet_type_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.pet_breed (
    id SERIAL PRIMARY KEY,
    pet_type_id INTEGER REFERENCES snowflake.pet_type (id),
    pet_breed_name VARCHAR NOT NULL,
    UNIQUE (pet_type_id, pet_breed_name)
);

CREATE TABLE IF NOT EXISTS snowflake.pet (
    id SERIAL PRIMARY KEY,
    pet_name VARCHAR NOT NULL,
    pet_type_id INTEGER REFERENCES snowflake.pet_type (id),
    pet_breed_id INTEGER REFERENCES snowflake.pet_breed (id),
    UNIQUE (pet_name, pet_type_id, pet_breed_id)
);

CREATE TABLE IF NOT EXISTS snowflake.postal_code (
    id BIGSERIAL PRIMARY KEY,
    postal_code VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.customer (
    id BIGSERIAL PRIMARY KEY,
    customer_first_name VARCHAR,
    customer_last_name VARCHAR,
    customer_age INT,
    customer_email VARCHAR,
    customer_country_id INTEGER REFERENCES snowflake.country (id),
    customer_postal_code_id BIGINT REFERENCES snowflake.postal_code (id),
    unique (
        customer_first_name, customer_last_name, customer_age,
        customer_email, customer_country_id,customer_postal_code_id
    )
);

CREATE TABLE IF NOT EXISTS snowflake.seller (
    id BIGSERIAL PRIMARY KEY,
    seller_first_name VARCHAR,
    seller_last_name VARCHAR,
    seller_email VARCHAR,
    seller_country_id INTEGER REFERENCES snowflake.country (id),
    seller_postal_code_id BIGINT REFERENCES snowflake.postal_code (id),
    UNIQUE (
        seller_first_name, seller_last_name, seller_email,
        seller_country_id, seller_postal_code_id
    )
);

CREATE TABLE IF NOT EXISTS snowflake.supplier_address (
    id SERIAL PRIMARY KEY,
    supplier_address VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.supplier (
    id SERIAL PRIMARY KEY,
    supplier_name VARCHAR NOT NULL,
    supplier_contact VARCHAR NOT NULL,
    supplier_email VARCHAR NOT NULL,
    supplier_phone VARCHAR NOT NULL,
    supplier_address_id INTEGER REFERENCES snowflake.supplier_address (id),
    supplier_city_id INTEGER REFERENCES snowflake.city (id),
    supplier_country_id INTEGER REFERENCES snowflake.country (id),
    UNIQUE (
        supplier_name, supplier_contact, supplier_email,
        supplier_phone, supplier_address_id, supplier_city_id,
        supplier_country_id
    )
);

CREATE TABLE IF NOT EXISTS snowflake.product_category (
    id SERIAL PRIMARY KEY,
    product_category_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.product_color (
    id SERIAL PRIMARY KEY,
    product_color_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.product_size (
    id SERIAL PRIMARY KEY,
    product_size_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.product_brand (
    id SERIAL PRIMARY KEY,
    product_brand_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.product_material (
    id SERIAL PRIMARY KEY,
    product_material_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.product (
    id BIGSERIAL PRIMARY KEY,
    product_name VARCHAR NOT NULL,
    product_category_id INTEGER REFERENCES snowflake.product_category (id),
    product_price NUMERIC(10, 2) NOT NULL,
    product_quantity INTEGER NOT NULL,
    product_weight NUMERIC(10, 2) NOT NULL,
    product_color_id INTEGER REFERENCES snowflake.product_color (id),
    product_size_id INTEGER REFERENCES snowflake.product_size (id),
    product_brand_id INTEGER REFERENCES snowflake.product_brand (id),
    product_material_id INTEGER REFERENCES snowflake.product_material (id),
    product_description TEXT NOT NULL,
    product_rating NUMERIC(10, 2),
    product_reviews INTEGER,
    product_release_date_id BIGINT REFERENCES snowflake.date (id),
    product_expire_date_id BIGINT REFERENCES snowflake.date (id),
    product_supplier_id BIGINT REFERENCES snowflake.supplier (id)
);

CREATE TABLE IF NOT EXISTS snowflake.store_location (
    id SERIAL PRIMARY KEY,
    store_location_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.store_state (
    id SERIAL PRIMARY KEY,
    store_state_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.store (
    id SERIAL PRIMARY KEY,
    store_name VARCHAR NOT NULL,
    store_location_id INTEGER REFERENCES snowflake.store_location (id),
    store_city_id INTEGER REFERENCES snowflake.city (id),
    store_state_id INTEGER REFERENCES snowflake.store_state (id),
    store_country_id INTEGER REFERENCES snowflake.country (id),
    store_phone VARCHAR NOT NULL,
    store_email VARCHAR NOT NULL,
    UNIQUE (
        store_name, store_location_id, store_city_id,
        store_state_id, store_country_id, store_phone,
        store_email
    )
);

--Инициализация таблицы фактов (продажи)

CREATE TABLE IF NOT EXISTS snowflake.sale (
    id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT REFERENCES snowflake.customer (id),
    customer_pet_id INTEGER REFERENCES snowflake.pet (id),
    seller_id BIGINT REFERENCES snowflake.seller (id),
    sale_date_id BIGINT REFERENCES snowflake.date (id),
    sale_quantity INTEGER NOT NULL,
    sale_total_price NUMERIC(10,2) NOT NULL,
    store_id INTEGER REFERENCES snowflake.store (id)
);