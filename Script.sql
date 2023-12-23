select * from covid_deaths c


select * from covid_vaccinations cv 
order by 3,4



select cd.location_ ,cd.date_ , cd.total_cases , cd.new_cases , cd.total_deaths, cd.population 
from covid_deaths cd 
order by 1,2

--looking at total cases vs total deaths 
--shows likelihood of percentage dying according to the country
select cd.location_ ,cd.date_ , cd.total_cases , cd.total_deaths, (cd.total_deaths/total_cases)*100 as death_percentage
from covid_deaths cd 
where cd.location_ like '%Nepal%'
order by 1,2


--looking at total cases vs population
--shows what percentage of popolaton got covid
select cd.location_ ,cd.date_ , cd.total_cases , cd.population, (cd.total_cases/cd.population)*100 as percent_population_cases
from covid_deaths cd 
where cd.location_ like '%States%'
order by 1,2



--looking at countries with highest infection rate compared to populations

select cd.location_ ,cd.population, max(cd.total_cases) as highest_infection_count, max((cd.total_cases/cd.population)*100) as max_percentage_infected
from covid_deaths cd 
group by cd.location_ ,cd.population 
order by max_percentage_infected desc 




--showing the countries with the highest death count per population

select cd.location_, max(cd.total_deaths) as total_death_count
from covid_deaths cd 
where cd.continent is not null
group by cd.location_ 
order by total_death_count desc 


--showing total deaths as per country


select cd.location_  , sum(cd.total_deaths) as total_death_count
from covid_deaths cd
where cd.continent is not null
group by cd.location_  
order by total_death_count desc




--lets break things down by continent 
--showing continents with the highest death count per population 


select cd.continent  , max(cd.total_deaths) as total_death_count
from covid_deaths cd
where cd.continent is not null
group by cd.continent  
order by total_death_count desc


--global numbers 

select  sum(cd.new_cases) as sum_new_cases, sum(cd.new_deaths) as sum_new_deaths, (sum(cd.new_deaths)/ sum(new_cases)) * 100 as percentage_of_death from covid_deaths cd 
where cd.continent is not null
--group by cd.date_ 
order by 1,2 


--looking at total population vs vaccination 


select cd.continent,cd.location_ , cd.date_ , cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over (partition by cd.location_ order by cd.location_,cd.date_) as rolling_people_vaccinated
from covid_deaths cd 
join covid_vaccinations cv on cd.location_ = cv.location_ and cd.date_ = cv.date_ 
where cd.continent is not null 
order by 2,3


--use cte


with pop_vs_vac (continent, location_, date_, population, new_vaccinations, rolling_people_vaccinated)
as
(
select cd.continent, cd.location_ , cd.date_ , cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over (partition by cd.location_ order by cd.location_,cd.date_) as rolling_people_vaccinated
from covid_deaths cd 
join covid_vaccinations cv on cd.location_ = cv.location_ and cd.date_ = cv.date_ 
where cd.continent is not null 
--order by 2,3
)
select *, (rolling_people_vaccinated/population)*100 from pop_vs_vac




--create view 

create view pop_vs_vac2 as
select cd.continent, cd.location_ , cd.date_ , cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over (partition by cd.location_ order by cd.location_,cd.date_) as rolling_people_vaccinated
from covid_deaths cd 
join covid_vaccinations cv on cd.location_ = cv.location_ and cd.date_ = cv.date_ 
where cd.continent is not null 
order by 2,3 











