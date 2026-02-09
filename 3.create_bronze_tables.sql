-- Databricks notebook source
drop table if exists formula1_dev.bronze.drivers;

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS formula1_dev.bronze.drivers
(driverId int,
driverRef string,
number int,
code string,
name struct<forename:string,surname:string>,
dob date,
nationality string,
url string
)
using json
options(path "abfss://bronze@databricksucextadl.dfs.core.windows.net/drivers.json");

-- COMMAND ----------

drop table if exists formula1_dev.bronze.results;

-- COMMAND ----------

create table if not exists formula1_dev.bronze.results
(
  resultId int,
  raceId int,
  driverId int,
  constructorId int,
  number int,
  grid int,
  position int,
  positionText string,
  positionOrder int,
  points int,
  laps int,
  time string,
  milliseconds int,
  fastestLap int,
  rank int,
  fastestLapTime string,
  fastestLapSpeed float,
  statusId string
)
using json
options(path "abfss://bronze@databricksucextadl.dfs.core.windows.net/results.json");

-- COMMAND ----------

