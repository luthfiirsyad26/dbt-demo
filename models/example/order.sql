{{ config(materialized-"table") }}

with customer as (select *  from {{ ref("customer")}}),
    stores as (select *  from {{ ref("stores")}}),
    dates as (select *  from {{ ref("dates")}}),
    product as (select *  from {{ ref("product")}})
    orders as (
                SELECT customer_id,
                    date_id,
                    b.product_id,
                    sum(quantity * b.price) as amount,
                    sum(quantity) as quantity,
                    count(a.order_id) as number_of_orders
                FROM raw_order
                LEFT JOIN raw_order_items b on (a.order_id = b.order_id)
                LEFT JOIN dates c on (date(a.transaction_date) = c.date)
                LEFT JOIN product d on (b.product_id = d.product_id)
                GROUP BY customer_id, b.product_id, date_id
            ),
    final as (select * from orders)
SELECT * FROM final