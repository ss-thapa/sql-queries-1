select * from olist_customers_dataset ocd 

select * from olist_geolocation_dataset ogd 

select * from olist_order_items_dataset ooid 

select * from olist_order_payments_dataset oopd 

select * from olist_order_reviews_dataset oord 

select * from olist_orders_dataset ood 

select* from olist_products_dataset opd 

select * from olist_sellers_dataset osd 

select * from product_category_name_translation pcnt 




-- orders after 2017
select * from olist_orders_dataset ood 
where extract(year from ood.order_purchase_timestamp) > 2017


--customers who have ordered most in 2017 and after years

select ocd.customer_unique_id ,count(ocd.customer_unique_id), ocd.customer_city, ocd.customer_state  from olist_orders_dataset ood 
join olist_customers_dataset ocd on ood.customer_id =ocd.customer_id 
where extract(year from ood.order_purchase_timestamp) >= 2017
group by ocd.customer_unique_id,ocd.customer_city, ocd.customer_state
order by count(ocd.customer_unique_id) desc 


---which category is sold most in 2018


select opd.product_category_name, count(opd.product_category_name) as most_selling from olist_orders_dataset ood 
join olist_order_items_dataset ooid on ood.order_id  = ooid.order_id 
join olist_products_dataset opd on ooid.product_id = opd.product_id 
where extract(year from ood.order_purchase_timestamp) = 2018
group by opd.product_category_name 
order by most_selling desc 
limit 5




select count(ood.customer_id) from olist_orders_dataset ood 
join olist_order_items_dataset ooid on ood.order_id  = ooid.order_id 
join olist_products_dataset opd on ooid.product_id = opd.product_id 
group by ood.customer_id 
order by count(ood.customer_id) desc





select ocd.customer_state , count(ocd.customer_state) as state_count from olist_orders_dataset ood 
join olist_customers_dataset ocd on ood.customer_id = ocd.customer_id 
group by ocd.customer_state 
order by state_count desc 




