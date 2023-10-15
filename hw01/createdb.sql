CREATE TABLE manufacturers (
  "manufacturer_id"	SERIAL PRIMARY KEY,
  "manufacturer_name"	VARCHART(100) NOT NULL
);

COPY manufacturers(
  "manufacturer_id"	SERIAL PRIMARY KEY,
  "manufacturer_name"	VARCHART(100) NOT NULL
) FROM '/var/lib/postgresql/data/manufacturers.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE categories (
  "category_id"		SERIAL PRIMARY KEY,
  "category_name"	VARCHART(100) NOT NULL
);

COPY categories(
  "category_id"		SERIAL PRIMARY KEY,
  "category_name"	VARCHART(100) NOT NULL
) FROM '/var/lib/postgresql/data/categories.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE products (
  "category_id"		BIGINT UNSIGNED,
  "manufacturer_id"	BIGINT UNSIGNED,
  "product_id"		SERIAL PRIMARY KEY,
  "product_name"	VARCHART(255) NOT NULL
);

COPY products (
  "category_id"		BIGINT UNSIGNED,
  "manufacturer_id"	BIGINT UNSIGNED,
  "product_id"		SERIAL PRIMARY KEY,
  "product_name"	VARCHART(255) NOT NULL
) FROM '/var/lib/postgresql/data/products.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE stores (
  "store_id"		SERIAL PRIMARY KEY,
  "store_name"		VARCHART(255) NOT NULL
);

COPY stores (
  "category_id"		BIGINT UNSIGNED,
  "manufacturer_id"	BIGINT UNSIGNED,
  "product_id"		SERIAL PRIMARY KEY,
  "product_name"	VARCHART(255) NOT NULL
) FROM '/var/lib/postgresql/data/products.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE customers (
  "customer_id"		SERIAL PRIMARY KEY,
  "customer_fname"	VARCHART(100) NOT NULL,
  "customer_lname"	VARCHART(100) NOT NULL
);

CREATE TABLE price_change (
  "product_id"		BIGINT UNSIGNED NOT NULL PRIMARY KEY,
  "price_change_ts"	TIMESTAMP NOT NULL,
  "new_price"		NUMERIC(9, 2) NOT NULL
);

CREATE TABLE deliveries (
	store_id	BIGINT UNSIGNED,\
	product_id		BIGINT UNSIGNED NOT NULL,\
	delivery_date		DATE NOT NULL,\
	product_count	INTEGER UNSIGNED NOT NULL\
\
);\
\
CREATE TABLE purchases (\
	store_id	 BIGINT UNSIGNED NOT NULL,\
	customer_id 	\
	\
);\
\
CREATE TABLE purchase_items (\
);\


