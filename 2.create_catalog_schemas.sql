-- Databricks notebook source
create catalog if not exists formula1_dev;

-- COMMAND ----------

use catalog formula1_dev;

-- COMMAND ----------

create schema if not exists bronze
managed location 'abfss://bronze@databricksucextadl.dfs.core.windows.net/'

-- COMMAND ----------

create schema if not exists silver
managed location 'abfss://silver@databricksucextadl.dfs.core.windows.net/'

-- COMMAND ----------

create schema if not exists gold
managed location 'abfss://gold@databricksucextadl.dfs.core.windows.net/'

-- COMMAND ----------

show schemas;

-- COMMAND ----------

