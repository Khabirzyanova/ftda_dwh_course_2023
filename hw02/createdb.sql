-- #1
CREATE TABLE manufacturers (
  "manufacturer_id"  SERIAL PRIMARY KEY,
  "manufacturer_name"  VARCHAR(100) NOT NULL,
  "manufacturer_legal_entity"  VARCHAR(100) NOT NULL -- added column
);

-- #2
CREATE TABLE categories (
  "category_id"  SERIAL PRIMARY KEY,
  "category_name"  VARCHAR(100) NOT NULL
);

-- #3
CREATE TABLE products (
  category_id  SERIAL, -- BIGINT UNSIGNED,
  "manufacturer_id"  SERIAL, --  BIGINT UNSIGNED,
  "product_id"  SERIAL PRIMARY KEY,
  "product_name"  VARCHAR(255) NOT NULL,
  "product_picture_url"  VARCHAR(255) NOT NULL, -- added column
  "product_description"  VARCHAR(255) NOT NULL, -- added column
  "product_age_restriction"  VARCHAR(255) NOT NULL -- added column
);

-- #4
CREATE TABLE stores (
  "store_id"  SERIAL PRIMARY KEY,
  "store_name"  VARCHAR(255) NOT NULL,
  "store_country"  VARCHAR(255) NOT NULL, -- added column
  "store_city"  VARCHAR(255) NOT NULL, -- added column
  "store_address"  VARCHAR(255) NOT NULL -- added column
);

-- #5
CREATE TABLE customers (
  "customer_id"  SERIAL PRIMARY KEY,
  "customer_fname"  VARCHAR(100) NOT NULL,
  "customer_lname"  VARCHAR(100) NOT NULL, 
  "customer_gender"  VARCHAR(100) NOT NULL, -- added column
  "customer_phone"  VARCHAR(100) NOT NULL -- added column
);

-- #6
CREATE TABLE price_change (
  "product_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "price_change_ts"	TIMESTAMP NOT NULL,
  "new_price"		NUMERIC(9, 2) NOT NULL
);

-- #7
CREATE TABLE deliveries (
  "delivery_id"  SERIAL,  -- BIGINT UNSIGNED, -- added column
  "store_id"		SERIAL, -- BIGINT UNSIGNED,
  "product_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "delivery_date"	DATE NOT NULL,
  "product_count"	SERIAL NOT NULL -- INTEGER UNSIGNED NOT NULL
);

-- #8
CREATE TABLE purchases (
  "store_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "customer_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "purchase_id" 	SERIAL PRIMARY KEY,
  "purchase_date" 	DATE NOT NULL, -- DATETIME NOT NULL,
  "purchase_payment_type"  VARCHAR(100) NOT NULL
);

-- #9
CREATE TABLE purchase_items (
  "product_id" 		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "purchase_id" 	SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "product_count" 	SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "product_price" NUMERIC(9,2) NOT NULL  -- added column
);



-- -- view for GMV
-- CREATE VIEW gmv
-- AS
-- WITH per_purchase_sales_sum AS (SELECT products.category_id,
--                                        purchase_items.purchase_id,
--                                        SUM(purchase_items.product_count * purchase_items.product_price) AS sales_sum
--                                        FROM purchase_items
--                                        LEFT JOIN products ON purchase_items.product_id=products.product_id
--                                        GROUP BY products.category_id, purchase_items.purchase_id),
--      GMV AS (SELECT purchases.store_id,
--                     per_purchase_sales_sum.*
--                     FROM purchases
--                     LEFT JOIN per_purchase_sales_sum ON purchases.purchase_id=per_purchase_sales_sum.purchase_id)
-- SELECT store_id, category_id, sales_sum FROM GMV;
