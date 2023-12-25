select * from zomatodb z 

---top 5 countres with maximum records
select  z.country , count(z.country_code) from zomatodb z 
group by z.country 
order by count(z.country_code) desc 


--rating count 
SELECT
    aggregate_rating,
    rating_color,
    rating_text,
    COUNT(*) AS rating_count
from zomatodb z 
where z.aggregate_rating is not null 
GROUP BY
    aggregate_rating,
    rating_color,
    rating_text
order by z.rating_color 



---find the coutries names who have given the zero ratings 

select distinct z.country, count(z.aggregate_rating)as countof from zomatodb z 
where z.aggregate_rating = 0
group by z.country 



--find out which currency is used by which country

select distinct z.country as distinct_co, z.currency  from zomatodb z 
where country is not null
order by distinct_co


---find the countries which have online delveries

select distinct z.country as dist_con, z.has_online_delivery  from zomatodb z 
where z.has_online_delivery = 'Yes'
order by dist_con desc 



--top 5 cities by distribution

select z.city , count(z.city)  from zomatodb z 
group by z.city
order by count(z.city) desc 






