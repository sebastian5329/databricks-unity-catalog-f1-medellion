-- Databricks notebook source
create external location if not exists ucextdl_bronze
url 'abfss://bronze@databricksucextadl.dfs.core.windows.net/'
with(storage credential databricks_ext_credential);

-- COMMAND ----------

desc external location ucextdl_bronze;

-- COMMAND ----------

-- MAGIC %fs
-- MAGIC ls "abfss://bronze@databricksucextadl.dfs.core.windows.net/"

-- COMMAND ----------

create external location if not exists ucextdl_silver
url 'abfss://silver@databricksucextadl.dfs.core.windows.net/'
with(storage credential databricks_ext_credential);

-- COMMAND ----------

desc external location ucextdl_silver;

-- COMMAND ----------

create external location if not exists ucextdl_gold
url 'abfss://gold@databricksucextadl.dfs.core.windows.net/'
with(storage credential databricks_ext_credential);

-- COMMAND ----------

desc external location ucextdl_gold;

-- COMMAND ----------

