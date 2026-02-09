-- Databricks notebook source
drop table if exists formula1_dev.silver.drivers;
create table if not exists formula1_dev.silver.drivers
as
select driverId as driver_id,
       driverRef as driver_ref,
       number,
       code,
       concat(name.forename,' ',name.surname) as name,
       dob,
       nationality,
       current_timestamp() as ingestion_date
from formula1_dev.bronze.drivers;

-- COMMAND ----------

drop table if exists formula1_dev.silver.results

-- COMMAND ----------

create table if not exists formula1_dev.silver.results
as
select resultId as result_id,
       raceId as race_id,
       driverId as driver_id,
       constructorId as constructor_id,
       number,
       grid,
       position,
       positionText as position_text,
       positionOrder as position_order,
       points,
       laps,
       time,
       milliseconds,
       fastestLap as fastest_lap,
       rank,
       fastestLapTime as fastest_lap_time,
       fastestLapSpeed as fastest_lap_speed,
       statusId as status_id
from formula1_dev.bronze.results

-- COMMAND ----------

