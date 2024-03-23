CREATE TABLE "orders"(
    "order_id" VARCHAR(255) NOT NULL,
    "order_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "customer_id" VARCHAR(255) NOT NULL,
    "product_id" VARCHAR(255) NOT NULL,
    "sales" DOUBLE PRECISION NOT NULL,
    "quantity" INTEGER NOT NULL,
    "order_priority" VARCHAR(255) NOT NULL,
    "location_id" VARCHAR(255) NOT NULL,
    "profit" DOUBLE PRECISION NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("order_id");
CREATE TABLE "customers"(
    "customer_id" VARCHAR(255) NOT NULL,
    "customer_name" VARCHAR(255) NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "customers" ADD PRIMARY KEY("customer_id");
CREATE TABLE "products"(
    "product_id" VARCHAR(255) NOT NULL,
    "product_name" VARCHAR(255) NOT NULL,
    "category" VARCHAR(255) NOT NULL,
    "sub_category" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("product_id");
CREATE TABLE "shipping"(
    "shipping_cost" DOUBLE PRECISION NOT NULL,
    "ship_mode" VARCHAR(255) NOT NULL,
    "ship_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "order_priority" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "shipping" ADD PRIMARY KEY("shipping_cost");
CREATE TABLE "locations"(
    "location_id" VARCHAR(255) NOT NULL,
    "zip_code" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "market" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "locations" ADD PRIMARY KEY("location_id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_location_id_foreign" FOREIGN KEY("location_id") REFERENCES "locations"("location_id");
ALTER TABLE
    "shipping" ADD CONSTRAINT "shipping_order_priority_foreign" FOREIGN KEY("order_priority") REFERENCES "orders"("order_priority");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("product_id");