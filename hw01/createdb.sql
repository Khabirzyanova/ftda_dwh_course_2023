-- #1
CREATE TABLE manufacturers (
  "manufacturer_id"	SERIAL PRIMARY KEY,
  "manufacturer_name"	VARCHAR(100) NOT NULL
);

COPY manufacturers(
  "manufacturer_id",
  "manufacturer_name"
) FROM '/var/lib/postgresql/init-data/manufacturers.csv' DELIMITER ';' CSV HEADER;

-- #2
CREATE TABLE categories (
  "category_id"		SERIAL PRIMARY KEY,
  "category_name"	VARCHAR(100) NOT NULL
);

COPY categories(
  "category_id",
  "category_name"
) FROM '/var/lib/postgresql/init-data/categories.csv' DELIMITER ';' CSV HEADER;

-- #3
CREATE TABLE products (
  category_id		SERIAL, -- BIGINT UNSIGNED,
  "manufacturer_id"	SERIAL, --  BIGINT UNSIGNED,
  "product_id"		SERIAL PRIMARY KEY,
  "product_name"	VARCHAR(255) NOT NULL
);

COPY products(
  "category_id",
  "manufacturer_id",
  "product_id",
  "product_name"
) FROM '/var/lib/postgresql/init-data/products.csv' DELIMITER ';' CSV HEADER;

-- #4
CREATE TABLE stores (
  "store_id"		SERIAL PRIMARY KEY,
  "store_name"		VARCHAR(255) NOT NULL
);

COPY stores(
  "store_id",
  "store_name"
) FROM '/var/lib/postgresql/init-data/stores.csv' DELIMITER ';' CSV HEADER;

-- #5
CREATE TABLE customers (
  "customer_id"		SERIAL PRIMARY KEY,
  "customer_fname"	VARCHAR(100) NOT NULL,
  "customer_lname"	VARCHAR(100) NOT NULL
);

COPY customers(
  "customer_id",
  "customer_fname",
  "customer_lname"
) FROM '/var/lib/postgresql/init-data/customers.csv' DELIMITER ';' CSV HEADER;

-- #6
CREATE TABLE price_change (
  "product_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "price_change_ts"	TIMESTAMP NOT NULL,
  "new_price"		NUMERIC(9, 2) NOT NULL
);

COPY price_change(
  "product_id",
  "price_change_ts",
  "new_price"
) FROM '/var/lib/postgresql/init-data/price_change.csv' DELIMITER ';' CSV HEADER;

-- #7
CREATE TABLE deliveries (
  "store_id"		SERIAL, -- BIGINT UNSIGNED,
  "product_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "delivery_date"	DATE NOT NULL,
  "product_count"	SERIAL NOT NULL -- INTEGER UNSIGNED NOT NULL
);

COPY deliveries(
  "store_id",
  "product_id",
  "delivery_date",
  "product_count"
) FROM '/var/lib/postgresql/init-data/deliveries.csv' DELIMITER ';' CSV HEADER;

-- #8
CREATE TABLE purchases (
  "store_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "customer_id"		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "purchase_id" 	SERIAL PRIMARY KEY,
  "purchase_date" 	DATE NOT NULL -- DATETIME NOT NULL
);

COPY purchases(
  "store_id",
  "customer_id",
  "purchase_id",
  "purchase_date"
) FROM '/var/lib/postgresql/init-data/purchases.csv' DELIMITER ';' CSV HEADER;

-- #9
CREATE TABLE purchase_items (
  "product_id" 		SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "purchase_id" 	SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "product_count" 	SERIAL NOT NULL, -- BIGINT UNSIGNED NOT NULL,
  "product_price" NUMERIC(9,2) NOT NULL
);

COPY purchase_items(
  "product_id",
  "purchase_id",
  "product_count",
  "product_price"
) FROM '/var/lib/postgresql/init-data/purchase_items.csv' DELIMITER ';' CSV HEADER;


-- view for GMV
CREATE VIEW gmv
AS
WITH per_purchase_sales_sum AS (SELECT products.category_id,
                                       purchase_items.purchase_id,
                                       SUM(purchase_items.product_count * purchase_items.product_price) AS sales_sum
                                       FROM purchase_items
                                       LEFT JOIN products ON purchase_items.product_id=products.product_id
                                       GROUP BY products.category_id, purchase_items.purchase_id),
     GMV AS (SELECT purchases.store_id,
                    per_purchase_sales_sum.*
                    FROM purchases
                    LEFT JOIN per_purchase_sales_sum ON purchases.purchase_id=per_purchase_sales_sum.purchase_id)
SELECT store_id, category_id, sales_sum FROM GMV;
