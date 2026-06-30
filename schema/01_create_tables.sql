CREATE TABLE customers (
    customer_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    customer_unique_id NVARCHAR(50) NULL,
    customer_zip_code_prefix NVARCHAR(10) NULL,  -- stored as text to preserve leading zeros
    customer_city NVARCHAR(50) NULL,
    customer_state NVARCHAR(50) NULL
);

CREATE TABLE sellers (
    seller_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix NVARCHAR(10) NOT NULL,  -- text, not int, to preserve leading zeros
    seller_city NVARCHAR(50) NULL,
    seller_state NVARCHAR(50) NULL
);

CREATE TABLE products (
    product_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    product_category_name NVARCHAR(50) NULL,
    product_name_lenght INT NULL,
    product_description_lenght INT NULL,
    product_photos_qty TINYINT NULL,
    product_weight_g INT NULL,  -- int, not smallint, since some products exceed 32,767g
    product_length_cm TINYINT NULL,
    product_height_cm TINYINT NULL,
    product_width_cm TINYINT NULL
);

CREATE TABLE product_category_name_translation (
    product_category_name NVARCHAR(50) NULL,  -- Portuguese category name, joins to products table
    product_category_name_english NVARCHAR(50) NULL   -- English translation used for readable reporting
);

CREATE TABLE orders (
    order_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    customer_id NVARCHAR(50) NOT NULL,
    order_status NVARCHAR(50) NOT NULL,
    order_purchase_timestamp DATETIME2(7) NOT NULL,
    order_approved_at DATETIME2(7) NULL,
    order_delivered_carrier_date DATETIME2(7) NULL,  -- null for orders not yet shipped
    order_delivered_customer_date DATETIME2(7) NULL,  -- null for cancelled or undelivered orders
    order_estimated_delivery_date DATETIME2(7) NULL
);

CREATE TABLE order_items (
    order_id NVARCHAR(50) NULL,
    order_item_id TINYINT NULL,
    product_id NVARCHAR(50) NULL,
    seller_id NVARCHAR(50) NULL,
    shipping_limit_date DATETIME2(7) NULL,
    price DECIMAL(18,10) NULL,  -- decimal instead of float for exact monetary precision
    freight_value DECIMAL(18,10) NULL
);

CREATE TABLE order_payments (
    order_id NVARCHAR(50) NULL,
    payment_sequential TINYINT NULL,
    payment_type NVARCHAR(50) NULL,
    payment_installments TINYINT NULL,
    payment_value DECIMAL(18,10) NULL  -- decimal instead of float for exact monetary precision
);

CREATE TABLE order_reviews (
    review_id NVARCHAR(50) NOT NULL,
    order_id NVARCHAR(50) NOT NULL,
    review_score TINYINT NOT NULL,
    review_comment_title NVARCHAR(250) NULL,
    review_comment_message NVARCHAR(MAX) NULL,  -- max length since review text can be long
    review_creation_date DATETIME2(7)  NOT NULL,
    review_answer_timestamp DATETIME2(7) NULL
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix NVARCHAR(10) NULL,  -- text, not int, to preserve leading zeros
    geolocation_lat DECIMAL(18,10) NULL,  -- decimal instead of float for exact coordinate precision
    geolocation_lng DECIMAL(18,10) NULL,
    geolocation_city NVARCHAR(50) NULL,
    geolocation_state NVARCHAR(50) NULL
);


