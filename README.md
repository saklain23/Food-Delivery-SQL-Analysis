# Food Delivery SQL Analysis

End-to-end SQL analysis on a Food Delivery dataset containing 45,593 records across 20 columns — covering data quality checks, delivery performance, segmentation, time-based patterns, and partner analysis.

---

## Overview

This project demonstrates SQL-based data analysis skills on a real-world Food Delivery dataset. The analysis covers 27 requirements — from data quality checks to advanced partner performance evaluation.

**Tools:** PostgreSQL, Git & GitHub

---

## Dataset

Single table `delivery` with 20 columns:

| Column | Description |
|--------|-------------|
| ID | Primary key |
| Delivery_person_ID | Delivery partner ID |
| Delivery_person_Age | Partner age |
| Delivery_person_Ratings | Partner rating |
| Restaurant_latitude | Restaurant latitude |
| Restaurant_longitude | Restaurant longitude |
| Delivery_location_latitude | Customer latitude |
| Delivery_location_longitude | Customer longitude |
| Order_Date | Order date |
| Time_Orderd | Order time |
| Time_Order_picked | Pickup time |
| Weatherconditions | Weather during delivery |
| Road_traffic_density | Traffic condition |
| Vehicle_condition | Vehicle condition (0-3) |
| Type_of_order | Order category |
| Type_of_vehicle | Vehicle used |
| multiple_deliveries | Multiple deliveries in one trip |
| Festival | Festival day (True/False) |
| City | Delivery city |
| Time_taken_min | Delivery time (text format) |

---

## Analysis Covered (27 Requirements)

### Data Quality
- NULL value analysis across all 20 columns
- Duplicate record check

### Statistics
- Descriptive statistics (Avg, Min, Max, Median, P90, P95)
- Distribution analysis (Fast / Normal / Slow / Very Slow)

### Segmentation
- City-wise delivery performance
- Vehicle-wise delivery performance
- City + Vehicle combination analysis
- Top 5 slowest cities

### Time-Based
- Hourly delivery pattern
- Weekday vs Weekend comparison

### Operational
- Delay rate analysis
- Weather impact on delays
- Traffic impact on delays
- Vehicle type impact
- Multiple deliveries impact
- Order type impact

### Partner Analysis
- Top 10 fastest partners
- Bottom 10 slowest partners
- Top rated partners
- Worst rated partners
- City-wise partner count
- Vehicle-wise partner count
- Rating vs Age group
- Partner consistency

---

## SQL Skills Demonstrated

| Skill | Usage |
|-------|-------|
| Aggregations (COUNT, AVG, MIN, MAX) | Statistics |
| GROUP BY + HAVING | Segmentation |
| CASE WHEN | Bucketing (Fast/Slow, Age groups) |
| REGEXP_REPLACE | Text cleaning |
| EXTRACT | Date/time functions |
| UNION ALL | NULL analysis |
| PERCENTILE_CONT | P50, P90, P95 |
| COUNT(DISTINCT) | Unique counts |
| Subqueries | Advanced analysis |

---

## Key Insights

- 7 columns contain NULL values (0.50% – 4.18%)
- 13 columns are 100% clean
- Zero duplicate records
- Average delivery time: ~26 minutes
- SLA compliance (30 min): ~70%
- ~30% of deliveries are delayed
- Top partners deliver 2x faster than bottom performers

---

## Files

## Files

| File | Description |
|------|-------------|
| `README.md` | Project documentation |
| `food_delivery_analytics.sql` | Database setup and all 27 analysis queries |
| `food_delivery_data.csv` | Dataset (45,593 records, 20 columns) |

---

## How to Use

1. Create the database using `schema.sql`
2. Load the dataset
3. Run queries from `analysis.sql`

---

## Author

**Saklain Alam**  
Data Analyst | SQL | Python | Power BI | Tableau
