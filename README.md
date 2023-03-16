
# COVID-19 Data Analysis SQL Project - README

## Project Overview
This project aims to analyze COVID-19 data using SQL queries to uncover insights and patterns in the data. It focuses on exploring various aspects of the COVID-19 pandemic, such as infection rates, case numbers, fatalities, and vaccination progress. The project demonstrates the power of SQL in processing and analyzing large datasets and can be used as a starting point for further data exploration and analysis.

*** Inspired by a tutorial from Alex The Analyst on Youtube https://www.youtube.com/watch?v=qfyynHBFOsM ***

## Getting Started
### Prerequisites
To get started with this project, you need to have the following tools installed on your machine:

    1. A SQL database server (e.g., MySQL, PostgreSQL, SQLite,  or SQL Server)
    2. A SQL client to connect to the database server and execute queries (e.g., MySQL Workbench, pgAdmin, or a command-line interface)
    3. Basic knowledge of SQL syntax and query execution



### Data Sources
A few reputable sources such as:

    1. Johns Hopkins University COVID-19 Data Repository
    2. Our World in Data COVID-19 dataset https://github.com/owid/covid-19-data/tree/master/public/data (I used this source for my project)

Make sure to download the latest available data and import it into your SQL database.

### Importing Data
To import the data, you may use the import functionality of your SQL client or execute the following SQL commands:
    -- Create the database
    CREATE DATABASE covid_data_analysis;

    -- Use the created database
    USE covid_data_analysis;

    -- Create the tables
    CREATE TABLE CovidDeaths ( ... );
    CREATE TABLE CovidVaccinations ( ... );
    ...

    -- Import the data
    LOAD DATA INFILE 'CovidDeaths.csv' INTO TABLE CovidDeaths;
    LOAD DATA INFILE 'CovidVaccinations.csv' INTO TABLE CovidVaccinations;
    ...



### Analysis and Queries
This project contains a series of SQL queries designed to answer specific questions related to the COVID-19 pandemic. Some example queries include:

    1. Daily COVID-19 cases, deaths, and population by location
    2. Total cases vs. total deaths for each location
    3. Countries with the highest infection rates compared to population
    4. Countries and continents with the highest death counts per population
    5. Global total cases, deaths, and death percentage
    6. Total population vs. total vaccinations by location
    7. Percentage of population vaccinated by location
