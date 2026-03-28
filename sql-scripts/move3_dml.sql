insert into dim_customer (
    customer_id,
    first_name,
    last_name,
    age,
    email,
    country,
    postal_code,
    pet_type,
    pet_name,
    pet_breed
)
select distinct
    sale_customer_id,
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
from mock_data
where sale_customer_id is not null;


insert into dim_seller (
    seller_id,
    first_name,
    last_name,
    email,
    country,
    postal_code
)
select distinct
    sale_seller_id,
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
from mock_data
where sale_seller_id is not null;


insert into dim_store (
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
)
select distinct
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
from mock_data
where store_name is not null;


insert into dim_supplier (
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
)
select distinct
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
from mock_data
where supplier_name is not null;


insert into dim_product (
    product_id,
    product_name,
    product_category,
    pet_category,
    product_price,
    product_quantity,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date
)
select distinct
    sale_product_id,
    product_name,
    product_category,
    pet_category,
    product_price,
    product_quantity,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    to_date(product_release_date, 'mm/dd/yyyy'),
    to_date(product_expiry_date, 'mm/dd/yyyy')
from mock_data
where sale_product_id is not null;


insert into fact_sales (
    source_row_id,
    customer_key,
    seller_key,
    product_key,
    store_key,
    supplier_key,
    sale_date,
    sale_quantity,
    sale_total_price
)
select
    md.id,
    dc.customer_key,
    ds.seller_key,
    dp.product_key,
    dst.store_key,
    dsp.supplier_key,
    to_date(md.sale_date, 'mm/dd/yyyy'),
    md.sale_quantity,
    md.sale_total_price
from mock_data md
join dim_customer dc
    on md.sale_customer_id = dc.customer_id
join dim_seller ds
    on md.sale_seller_id = ds.seller_id
join dim_product dp
    on md.sale_product_id = dp.product_id
left join dim_store dst
    on md.store_name is not distinct from dst.store_name
   and md.store_location is not distinct from dst.store_location
   and md.store_city is not distinct from dst.store_city
   and md.store_state is not distinct from dst.store_state
   and md.store_country is not distinct from dst.store_country
   and md.store_phone is not distinct from dst.store_phone
   and md.store_email is not distinct from dst.store_email
left join dim_supplier dsp
    on md.supplier_name is not distinct from dsp.supplier_name
   and md.supplier_contact is not distinct from dsp.supplier_contact
   and md.supplier_email is not distinct from dsp.supplier_email
   and md.supplier_phone is not distinct from dsp.supplier_phone
   and md.supplier_address is not distinct from dsp.supplier_address
   and md.supplier_city is not distinct from dsp.supplier_city
   and md.supplier_country is not distinct from dsp.supplier_country;
