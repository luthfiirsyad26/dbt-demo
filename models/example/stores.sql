{{ config(materialized-"table") }}

with stores as (
                select id, city, country from raw_stores
                )
select * from stores