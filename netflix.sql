select * from netflix_detail nd 

--- top 10 movies according to the rating
select * from netflix_detail nd 
order by nd.rating desc 
limit 10


--- bottom 10 movies according to the rating
select * from netflix_detail nd 
order by nd.rating asc
limit 10

-- all movies which were between 2012-2014 and whose view time were less the 40crore and are globally available


SELECT *, EXTRACT(YEAR FROM nd.release_date) AS year_only
FROM netflix_detail nd
WHERE EXTRACT(YEAR FROM nd.release_date) BETWEEN 2012 AND 2014 AND nd.hours_viewed < 400000000 and nd.global_available = 'Yes'

---all movies which are between 2021 and 2023 view time more then 40 crore and not globally available

SELECT *, EXTRACT(YEAR FROM nd.release_date) AS year_only
FROM netflix_detail nd
WHERE EXTRACT(YEAR FROM nd.release_date) BETWEEN 2021 AND 2023 AND nd.hours_viewed > 400000000 and nd.global_available = 'No'





-- group by
select nd.global_available  , sum(nd.no_of_ratings)  from netflix_detail nd 
group by nd.global_available 





select nd.genre ,count(nd.genre) from netflix_detail nd 
group by nd.genre 
order by count(nd.genre) desc 
