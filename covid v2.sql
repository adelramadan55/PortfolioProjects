select * from portfolioproject..covieddeath where continent is not null  order by 3,4
--select * from portfolioproject..CovidVaccinations order by 3,4
select location, date, total_cases, new_cases, total_deaths, population from portfolioproject..covieddeath order by 1,2
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathspercentages from portfolioproject..covieddeath where location like '%egypt%'  order by 1,2
select location, date, total_cases, population, (total_cases/population)*100 as totalcasespercentages from portfolioproject..covieddeath where location like '%egypt%'  order by 1,2
select location, population, max(total_cases) as highestinfictioncountries, max((total_cases/population))*100 as populationinfctpercentages from portfolioproject..covieddeath group by population, location  order by populationinfctpercentages desc
select location, max(cast(total_deaths as int)) as totaldeathscount from portfolioproject..covieddeath where continent is not null group by location  order by totaldeathscount desc
select continent, max(cast(total_deaths as int)) as totaldeathscount from portfolioproject..covieddeath where continent is not null group by continent  order by totaldeathscount desc
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathspercentages from portfolioproject..covieddeath where continent is not null order by 1,2
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int)) / sum(new_cases) *100 as deathpercentage from portfolioproject..covieddeath where continent is not null  order by 1,2
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as rollingpeoplevaccinated from portfolioproject..covieddeath dea join portfolioproject..CovidVaccinations vac on dea.location = vac.location and dea.date = vac.date  where dea.continent is not null order by 2,3
with popvsvac (continent, location, date, population, rollingpeoplevaccinated, new_vaccintions) as ( select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as rollingpeoplevaccinated from portfolioproject..covieddeath dea join portfolioproject..CovidVaccinations vac on dea.location = vac.location and dea.date = vac.date  where dea.continent is not null) select *, (rollingpeoplevaccinated/population) *100 from popvsvac 
drop table if exists #perentpopulationvaccinated
create table #perentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccintions numeric,
rollingpeoplevaccinated numeric
)
insert into #perentpopulationvaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as rollingpeoplevaccinated from portfolioproject..covieddeath dea join portfolioproject..CovidVaccinations vac on dea.location = vac.location and dea.date = vac.date  --(where dea.continent is not null)
order by 2,3

select *, (rollingpeoplevaccinated/population)*100 from #perentpopulationvaccinated
create view perentpopulationvaccinated as
select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as rollingpeoplevaccinated
from portfolioproject..covieddeath dea join portfolioproject..CovidVaccinations vac
on dea.location = vac.location and dea.date = vac.date  where dea.continent is not null 
select * from perentpopulationvaccinated