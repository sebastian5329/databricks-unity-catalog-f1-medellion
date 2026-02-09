# Formula 1 Data Insights

## Project Overview

This project implements the **Medallion Architecture (Bronze → Silver → Gold)** within an **Azure Databricks Lakehouse** using **Unity Catalog** for governance and secure data access.

The goal of the project is to demonstrate how raw external data can be ingested, curated, and transformed into business-ready analytics using **Databricks SQL**, **managed Delta tables**, and **scheduled workflows**.

The dataset is based on **Formula 1 racing data**, with the final output identifying the **most successful drivers by number of race wins**.

---

## Medallion Architecture Used

The project follows the **Medallion Architecture**, which organizes data into three quality layers:

###  Bronze – Raw Data
- Contains raw, immutable source data
- No transformations applied
- Schema-on-read

###  Silver – Curated Data
- Cleaned and standardized data
- Column renaming and light transformations
- Flattened nested structures
- Added ingestion metadata

###  Gold – Business Data
- Aggregated, analytics-ready data
- Designed for direct consumption by reporting and dashboards

---

## Business Use Case

From a business perspective, the project answers:

> **Which Formula 1 drivers have achieved the highest number of race wins?**

---

## Technology Stack

- Azure Databricks (Unity Catalog enabled)
- Azure Data Lake Storage Gen2 (ADLS)
- Databricks SQL
- Delta Lake (managed tables)
- Databricks Workflows (Scheduled Trigger)

---

## Unity Catalog & Storage Design

This project uses Unity Catalog for centralized governance and metadata management.

Two Azure Data Lake Storage (ADLS) accounts are involved:

- A default ADLS associated with the Unity Catalog metastore for metadata management.
- A separate ADLS registered as an external location, containing Bronze, Silver, and Gold containers.

Raw Formula 1 JSON files are stored in the Bronze container, while Silver and Gold layers store Unity Catalog–managed Delta tables within the same external ADLS, using Unity-managed directory structures.

This design ensures that raw data remains immutable in the Bronze layer, while curated and analytical datasets in the Silver and Gold layers are fully governed and managed by Unity Catalog, even though their physical data files reside in external storage.

---

## Implementation Details

### 1️. External Locations
- Storage credentials created using Azure Databricks Access Connector
- External locations defined for Bronze, Silver, and Gold containers
- Access governed centrally through Unity Catalog

---

### 2️. Catalog & Schemas
- Catalog created: `formula1_dev`
- Schemas created:
  - `bronze`
  - `silver`
  - `gold`

---

### 3️. Bronze Layer – External Tables (Raw)

- Raw JSON files registered as **external tables**
- All columns retained without modification
- No data written back to storage

Tables:
- `bronze.drivers`
- `bronze.results`

Purpose:
- Preserve source data
- Enable reproducible downstream processing

---

### 4️. Silver Layer – Managed Delta Tables (Curated)

Minimal transformations applied:

#### Drivers
- Renamed columns for consistency (e.g., `driverId` → `driver_id`)
- Flattened nested JSON structure by concatenating `forename` and `surname`
- Added `ingestion_date` using `current_timestamp()`

#### Results
- Standardized column names
- No complex transformations

Purpose:
- Improve readability
- Standardize schema
- Prepare data for analytics

---

### 5️. Gold Layer – Managed Delta Tables (Business)

Created an analytical table:

**`gold.driver_wins`**

Logic:
- Joined Silver drivers and results on `driver_id`
- Filtered winning races (`position = 1`)
- Grouped by driver name
- Calculated total wins per driver

## Workflow Orchestration

A Databricks Workflow was created to execute the pipeline sequentially:

1. Bronze table creation  
2. Silver table creation  
3. Gold table creation  

The workflow is configured with a **scheduled trigger**, enabling automated and repeatable data processing.

This ensures proper dependency handling and consistent pipeline execution.

## Data Lineage & Governance

Unity Catalog provides end-to-end data lineage across the **Bronze, Silver, and Gold** layers.

It clearly differentiates between:
- **External tables** in the Bronze layer
- **Managed Delta tables** in the Silver and Gold layers

Unity Catalog also manages table metadata, ownership, and governance for all catalogs and schemas used in this project.

## Delta Lake Usage

Delta Lake is implicitly used in the **Silver and Gold layers** of this project.

All managed tables created in these layers use the **Delta format by default** in Databricks, providing ACID-compliant writes, schema enforcement, and reliable reads.

The Bronze layer uses external JSON tables and does not leverage Delta Lake features.

## Summary

This project demonstrates a practical implementation of the **Medallion Architecture** within an **Azure Databricks Lakehouse** using **Unity Catalog**.

It includes:
- External Bronze tables for raw data
- Managed Delta tables for Silver and Gold layers
- SQL-based transformations and aggregations
- Scheduled workflow execution
- End-to-end data lineage and governance

The final Gold layer delivers business-ready insights by identifying the most successful Formula 1 drivers based on total race wins.
