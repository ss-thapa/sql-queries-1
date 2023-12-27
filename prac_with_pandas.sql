select * from gamingdf g 

---to select the specified row number
select * from gamingdf g 
offset 5-1
limit 1

---to select from nth to nth number
--if you want to select rows 3 to 7 (inclusive) from a table 
--named your_table, the query would be:
---it shows the 7 rows  from 3rd row 
select * from gamingdf g 
offset 2
limit 7


---select everything where platform is wii

select * from gamingdf g 
where g.platform = 'Wii'



---select the game which have higher sales in japan then eu_sales

SELECT * 
FROM gamingdf g 
WHERE 
CASE 
	WHEN g.jp_sales > g.eu_sales  THEN true 
    ELSE false 
END



---select names of the games where japan sales is greater then na_sales, eu_sales and other sales
select * from gamingdf g 
where 
case 
	WHEN jp_sales > eu_sales AND jp_sales > na_sales AND jp_sales > other_sales THEN true
	else false 
end 

--or

select * from gamingdf g 
where jp_sales > eu_sales AND jp_sales > na_sales AND jp_sales > other_sales

---select name of games where platform is wii and genre is role_playing 

select * from gamingdf g 
where 
case 
	when g.platform = 'Wii' and g.genre ='Role-Playing' then true
	else false 
end
order by g.global_sales desc 

--or

select * from gamingdf g 
where g.platform = 'Wii' and G.genre = 'Role-Playing'
order by g.global_sales desc 



---select everything where genre = action or shooter

select * from gamingdf g 
where g.genre = 'Action' or g.genre = 'Shooter'


-- using or and And combine


select * from gamingdf g 
where g.year_ >= 2010 and (g.genre = 'Action' or g.genre = 'Shooter')




---top 3 publishers

select count(*) from gamingdf g 
where g.publisher = 'Electronic Arts' or  g.publisher = 'Activision' or g.publisher = 'Namco Bandai Games'

---top 3 publichers where genres are sports action or shooter and sales >= 2m

select * from gamingdf g 
where g.global_sales >= 2 and (g.publisher = 'Electronic Arts' or g.publisher ='Activision' or g.publisher = 'Namco Bandai Games') and (g.genre = 'Sports' or g.genre = 'Action' or g.genre = 'Shooter')



---between 

select g.genre , count(g.genre) as my_count from gamingdf g 
where (g.year_ between 1990 and 1999) and (g.global_sales between 2 and 10)
group by g.genre 
order by my_count desc


---negating is done by using not

select count(*) from gamingdf g 
where not ((g.year_ between 2010 and 2019) and g.genre in ('Puzzles', 'Strategy', 'Adventure'))

--same thing both

select count(*) from gamingdf g 
where not ((g.year_ between 2010 and 2019) and  (g.genre = 'Puzzles' or g.genre ='Strategy' or g.genre = 'Adventure'))




-- find out which racing games had the highest sales in eu compared to na, jp and other sales between the year 2000-2009


select g.name_, g.genre  from gamingdf g 
where (g.year_ between 2000 and 2009) and g.genre = 'Racing' and (g.eu_sales > g.na_sales and g.eu_sales > g.jp_sales and g.eu_sales > g.other_sales) 


--average sales in north america by genre 

select g.genre, avg(g.na_sales) as avg_sales from gamingdf g 
group by g.genre 
order by avg_sales asc

--average sales in all sales by genre


select g.genre, avg(g.na_sales) as na , avg(g.jp_sales) as jp, avg(g.eu_sales) as eu, avg(g.other_sales) as other from gamingdf g 
group by g.genre 
order by na desc, jp desc , eu desc, other desc 


-- when and case 

select *,
case
	when g.platform in ('PS', 'PS2',  'PS3',  'PS4',  'PSP',  'PSV') then 'Sony'
	when g.platform in ('N64', 'GB', 'GBA', 'GC', 'Wii', 'WiiU', 'NSE','3DS', 'SNES') then 'Nintando'
	when g.platform in ('XB','XB360', 'XOne') then 'Microsoft'
	when g.platform = 'PC' then 'PC'
	when g.platform in ('DC', 'GG', 'SAT', 'SCD') then 'Sega'
	else 'other'
end as platform_companies
from gamingdf g 


--- using group by in above query group by platform_ocompanies
select platform_companies, avg(jp_sales) as average_sales
from(
select *,
case
	when g.platform in ('PS', 'PS2',  'PS3',  'PS4',  'PSP',  'PSV') then 'Sony'
	when g.platform in ('N64', 'GB', 'GBA', 'GC', 'Wii', 'WiiU', 'NSE','3DS', 'SNES') then 'Nintando'
	when g.platform in ('XB','XB360', 'XOne') then 'Microsoft'
	when g.platform = 'PC' then 'PC'
	when g.platform in ('DC', 'GG', 'SAT', 'SCD') then 'Sega'
	else 'other'
end as platform_companies
from gamingdf g)
as platform_data
group by platform_companies
order by average_sales desc


select platform_companies, count(jp_sales) as total_sales
from(
select *,
case
	when g.platform in ('PS', 'PS2',  'PS3',  'PS4',  'PSP',  'PSV') then 'Sony'
	when g.platform in ('N64', 'GB', 'GBA', 'GC', 'Wii', 'WiiU', 'NSE','3DS', 'SNES') then 'Nintando'
	when g.platform in ('XB','XB360', 'XOne') then 'Microsoft'
	when g.platform = 'PC' then 'PC'
	when g.platform in ('DC', 'GG', 'SAT', 'SCD') then 'Sega'
	else 'other'
end as platform_companies
from gamingdf g)
as platform_data
group by platform_companies
order by average_sales desc


----average, median and count at once

select platform_companies,
count(jp_sales) as total_count,
avg(jp_sales) as  average_sales,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY jp_sales) AS median_column
from(
select *,
case
	when g.platform in ('PS', 'PS2',  'PS3',  'PS4',  'PSP',  'PSV') then 'Sony'
	when g.platform in ('N64', 'GB', 'GBA', 'GC', 'Wii', 'WiiU', 'NSE','3DS', 'SNES') then 'Nintando'
	when g.platform in ('XB','XB360', 'XOne') then 'Microsoft'
	when g.platform = 'PC' then 'PC'
	when g.platform in ('DC', 'GG', 'SAT', 'SCD') then 'Sega'
	else 'other'
end as platform_companies
from gamingdf g)
as platform_data
group by platform_companies
order by total_count desc, average_sales desc, median_column desc;


--- min max and mean average of jp_sales just average value of globalsales

select platform_companies,
avg(global_sales) as average_global,
min(jp_sales) as min_values,
max(jp_sales) as max_values,
avg(jp_sales) as average_values
from(
select *,
case
	when g.platform in ('PS', 'PS2',  'PS3',  'PS4',  'PSP',  'PSV') then 'Sony'
	when g.platform in ('N64', 'GB', 'GBA', 'GC', 'Wii', 'WiiU', 'NSE','3DS', 'SNES') then 'Nintando'
	when g.platform in ('XB','XB360', 'XOne') then 'Microsoft'
	when g.platform = 'PC' then 'PC'
	when g.platform in ('DC', 'GG', 'SAT', 'SCD') then 'Sega'
	else 'other'
end as platform_companies
from gamingdf g)
as platform_data
group by platform_companies

----



