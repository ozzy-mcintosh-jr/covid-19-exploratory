SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY location;


-- Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, total_deaths/CAST(total_cases AS float)*100 AS death_percentage
FROM CovidDeaths
WHERE location LIKE '%state%'
AND continent IS NOT NULL
ORDER BY location;

-- Countries With Highest Infection Rate Compared To Population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases)/CAST(population AS float)*100 AS percent_of_population_infected
FROM CovidDeaths
--WHERE location LIKE '%state%'
GROUP BY location, population
ORDER BY percent_of_population_infected DESC;


-- Countries With Highest Death Count Per Population
SELECT location, MAX(CAST(total_deaths AS INTEGER)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

--Let's Break It Down By Continent

-- Continents With Highest Death Count Per Population
SELECT continent, MAX(CAST(total_deaths AS INTEGER)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;



-- GLOBAL
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INTEGER)) AS total_deaths, SUM(CAST(new_deaths AS FLOAT))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
--WHERE location LIKE '%state%'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2


-- Total Population Vs Total Vaccinations


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM "CovidDeaths" AS dea
JOIN "CovidVaccinations" AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- TEMP TABLE
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, rolling_num_people_vaxxed)
AS
(
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS INTEGER)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_num_people_vaxxed
    FROM "CovidDeaths" AS dea
    JOIN "CovidVaccinations" AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL
    ORDER BY dea.location, dea.date ASC
)
SELECT *, (CAST(rolling_num_people_vaxxed AS FLOAT)/CAST(population AS FLOAT)*100) 
FROM PopvsVac;

---Create view for tableau
CREATE VIEW PopvsVacView AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS INTEGER)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_num_people_vaxxed,
    (CAST(SUM(CAST(vac.new_vaccinations AS INTEGER)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS FLOAT)/CAST(population AS FLOAT)*100) AS PercentagePopvsVac
FROM "CovidDeaths" AS dea
JOIN "CovidVaccinations" AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date ASC;

