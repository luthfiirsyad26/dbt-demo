{{ config(materialized-"table") }}

with customer as (
                select id, first_name, last_name, dob, email from raw_customers
                )
select * from customer