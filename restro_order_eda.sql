select * from order_detail od 

select * from restro_detail rd 

--Which restaurant received the most orders?

select rd.restaurantname ,count(od.order_id) as max_order from order_detail od 
join restro_detail rd on od.restaurant_id = rd.restaurantid 
group by rd.restaurantname 
order by max_order desc 

-- which restaurant did the most sales in terms of total revenue 

select rd.restaurantname ,sum(od.order_amount) as max_amount from order_detail od 
join restro_detail rd on od.restaurant_id = rd.restaurantid 
group by rd.restaurantname 
order by max_amount desc

--Which restaurant did sell the most item ?


select rd.restaurantname ,sum(od.quantity_of_items) as max_item from order_detail od 
join restro_detail rd on od.restaurant_id = rd.restaurantid 
group by rd.restaurantname 
order by max_item desc


-- Which customer ordered the most?

select od.customer_name , count(od.order_id) as max_item from order_detail od 
group by od.customer_name
order by max_item desc


-- When do customers order more in a day? 

SELECT TO_CHAR(order_date, 'HH:MI AM') AS time_of_day, COUNT(*) AS count
FROM order_detail od 
GROUP BY TO_CHAR(order_date, 'HH:MI AM')
ORDER BY count desc 

-- Which is the most liked cuisine as per sales

select rd.cuisine , count(od.order_id) as count_order from order_detail od 
join restro_detail rd on od.restaurant_id = rd.restaurantid 
group by rd.cuisine 
order by count_order desc 

-- which are the cuisines those are rated most

select rd.cuisine , count(od.order_id)as count_ from order_detail od 
join restro_detail rd on rd.restaurantid = od.restaurant_id 
where od.customer_rating_food = 5
group by  rd.cuisine 
order by count_ desc


--which 5 restaurant have taken less time to deliver then average delivery time

select rd.restaurantname , count(od.order_id) as count_  from order_detail od 
join restro_detail rd on rd.restaurantid = od.restaurant_id 
where od.delivery_time_taken_mins < (select avg(od2.delivery_time_taken_mins) from order_detail od2)
group by rd.restaurantname 
order by count_ desc 
limit 5

-- how many times did any restro took max delivery time to deliver food 

select rd.restaurantname ,count(od.order_id)as count_ from order_detail od 
join restro_detail rd on rd.restaurantid = od.restaurant_id 
where od.delivery_time_taken_mins = (select max(od2.delivery_time_taken_mins)from order_detail od2)
group by rd.restaurantname 
order by count_ desc 










