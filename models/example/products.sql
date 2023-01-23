{{ config(materialized-"table") }}

with products as (
                select id, name, description, price from raw_products
                )
select * from products