-- покупатели
create table dim_customer (
    customer_key bigserial primary key,
    customer_id bigint not null unique,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    age int,
    email varchar(255),
    country varchar(100),
    postal_code varchar(20),
    pet_type varchar(50),
    pet_name varchar(100),
    pet_breed varchar(100)
);

-- продавцы
create table dim_seller (
    seller_key bigserial primary key,
    seller_id bigint not null unique,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255),
    country varchar(100),
    postal_code varchar(20)
);

-- магазины
create table dim_store (
    store_key bigserial primary key,
    store_name varchar(150) not null,
    store_location varchar(250),
    store_city varchar(100),
    store_state varchar(100),
    store_country varchar(100),
    store_phone varchar(20),
    store_email varchar(255)
);

-- всё о поставщиках
create table dim_supplier (
    supplier_key bigserial primary key,
    supplier_name varchar(150) not null,
    supplier_contact varchar(150),
    supplier_email varchar(255),
    supplier_phone varchar(30),
    supplier_address varchar(255),
    supplier_city varchar(100),
    supplier_country varchar(100)
);

-- товары
create table dim_product (
    product_key bigserial primary key,
    product_id bigint not null unique,
    product_name varchar(150) not null, 
    product_category varchar(100),
    pet_category varchar(100),
    product_price numeric(10,2),
    product_quantity int,
    product_weight numeric(10,2),
    product_color varchar(50),
    product_size varchar(50),
    product_brand varchar(100),
    product_material varchar(100),
    product_description text,
    product_rating numeric(3,2),
    product_reviews int,
    product_release_date date,
    product_expiry_date date
);

-- центр звезды
create table fact_sales (
    sales_key bigserial primary key,
    source_row_id bigint,
    customer_key bigint not null references dim_customer(customer_key),
    seller_key bigint not null references dim_seller(seller_key),
    product_key bigint not null references dim_product(product_key),
    store_key bigint references dim_store(store_key),
    supplier_key bigint references dim_supplier(supplier_key),
    sale_date date not null,
    sale_quantity int not null,
    sale_total_price numeric(12,2) not null
);
