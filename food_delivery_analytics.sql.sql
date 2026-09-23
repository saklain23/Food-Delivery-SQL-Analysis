--CREATE DATABASE
CREATE DATABASE food_delivery;

-- CREATE TABLE
DROP TABLE IF EXISTS delivery;
CREATE TABLE IF NOT EXISTS delivery(
ID INTEGER PRIMARY KEY,
Delivery_person_ID TEXT,
Delivery_person_Age INT,
Delivery_person_Ratings NUMERIC(2,1),
Restaurant_latitude NUMERIC(9,6),
Restaurant_longitude NUMERIC(9,6),
Delivery_location_latitude NUMERIC(9,6),
Delivery_location_longitude NUMERIC(9,6),
Order_Date DATE,
Time_Orderd TIME,
Time_Order_picked TIME,
Weatherconditions VARCHAR(100),
Road_traffic_density VARCHAR(50),
Vehicle_condition INT,
Type_of_order VARCHAR(50),
Type_of_vehicle VARCHAR(100),
multiple_deliveries INT,
Festival BOOLEAN,
City VARCHAR(70),
Time_taken_min TEXT
);



COPY delivery(ID, Delivery_person_ID, Delivery_person_Age, Delivery_person_Ratings, Restaurant_latitude, Restaurant_longitude, Delivery_location_latitude, Delivery_location_longitude, Order_Date, Time_Orderd, Time_Order_picked, Weatherconditions, Road_traffic_density, Vehicle_condition, Type_of_order, Type_of_vehicle, multiple_deliveries, Festival, City, Time_taken_min)
FROM 'data\train.csv.'
WITH (FORMAT csv, HEADER true, NULL '');

SELECT * FROM delivery;


-- How many NULL values exist in each column, and what is their percentage?

SELECT 'id' AS column_names,
COUNT(*) AS total_rows,
COUNT(*) - COUNT(id) AS null_count,
ROUND((COUNT(*) - COUNT(id))*100.0 / COUNT(*),2) AS null_pct
FROM delivery

UNION ALL

SELECT 'delivery_person_id', COUNT(*), COUNT(*) - COUNT(delivery_person_id),
ROUND((COUNT(*) - COUNT(delivery_person_id))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'delivery_person_age', COUNT(*), COUNT(*) - COUNT(delivery_person_age),
ROUND((COUNT(*) - COUNT(delivery_person_age))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'delivery_person_ratings', COUNT(*), COUNT(*) - COUNT(delivery_person_ratings),
ROUND((COUNT(*) - COUNT(delivery_person_ratings))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'restaurant_latitude', COUNT(*), COUNT(*) - COUNT(restaurant_latitude),
ROUND((COUNT(*) - COUNT(restaurant_latitude))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'restaurant_longitude', COUNT(*), COUNT(*) - COUNT(restaurant_longitude),
ROUND((COUNT(*) - COUNT(restaurant_longitude))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'delivery_location_latitude', COUNT(*), COUNT(*) - COUNT(delivery_location_latitude),
ROUND((COUNT(*) - COUNT(delivery_location_latitude))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'delivery_location_longitude', COUNT(*), COUNT(*) - COUNT(delivery_location_longitude),
ROUND((COUNT(*) - COUNT(delivery_location_longitude))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'order_date', COUNT(*), COUNT(*) - COUNT(order_date),
ROUND((COUNT(*) - COUNT(order_date))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'time_orderd', COUNT(*), COUNT(*) - COUNT(time_orderd),
ROUND((COUNT(*) - COUNT(time_orderd))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'time_order_picked', COUNT(*), COUNT(*) - COUNT(time_order_picked),
ROUND((COUNT(*) - COUNT(time_order_picked))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'weatherconditions', COUNT(*), COUNT(*) - COUNT(weatherconditions),
ROUND((COUNT(*) - COUNT(weatherconditions))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'road_traffic_density', COUNT(*), COUNT(*) - COUNT(road_traffic_density),
ROUND((COUNT(*) - COUNT(road_traffic_density))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'vehicle_condition', COUNT(*), COUNT(*) - COUNT(vehicle_condition),
ROUND((COUNT(*) - COUNT(vehicle_condition))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'type_of_order', COUNT(*), COUNT(*) - COUNT(type_of_order),
ROUND((COUNT(*) - COUNT(type_of_order))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'type_of_vehicle', COUNT(*), COUNT(*) - COUNT(type_of_vehicle),
ROUND((COUNT(*) - COUNT(type_of_vehicle))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'multiple_deliveries', COUNT(*), COUNT(*) - COUNT(multiple_deliveries),
ROUND((COUNT(*) - COUNT(multiple_deliveries))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'festival', COUNT(*), COUNT(*) - COUNT(festival),
ROUND((COUNT(*) - COUNT(festival))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'city', COUNT(*), COUNT(*) - COUNT(city),
ROUND((COUNT(*) - COUNT(city))*100.0 / COUNT(*),2)
FROM delivery

UNION ALL

SELECT 'time_taken_min', COUNT(*), COUNT(*) - COUNT(time_taken_min),
ROUND((COUNT(*) - COUNT(time_taken_min))*100.0 / COUNT(*),2)
FROM delivery
ORDER BY null_pct DESC;


SELECT * FROM delivery;


-- Does the table contain duplicate records?

SELECT COUNT(*) AS total,
COUNT(DISTINCT id) AS unique_ids,
COUNT(*) - COUNT(DISTINCT id) AS duplicates
FROM delivery;


-- What are the basic statistics (Avg, Min, Max, Median, P90, P95) of delivery time?

SELECT 
    COUNT(*) AS total_deliveries,
    ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric), 2) AS avg_time,
    MIN(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric) AS min_time,
    MAX(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric) AS max_time,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric
    ) AS median_time,
    PERCENTILE_CONT(0.9) WITHIN GROUP (
        ORDER BY REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric
    ) AS p90_time,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric
    ) AS p95_time
FROM delivery
WHERE time_taken_min IS NOT NULL
  AND time_taken_min ~ '[0-9]';



-- How are delivery times distributed — fast, normal, slow, and very slow?

SELECT
CASE
WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC  <= 20 THEN 'fast (0-20)'
WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC  <= 30 THEN 'normal (21-30)'
WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC  <= 40 THEN 'slow (31-40)'
ELSE 'very slow (41+)'
END AS delivery_bucket,
COUNT(*) AS delivery_count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS percentage
FROM delivery
WHERE time_taken_min IS NOT NULL 
AND time_taken_min ~ '[0-9]'
GROUP BY 1
ORDER BY 1;
	 
-- How does delivery performance vary by city?
SELECT city,
      COUNT(*) AS delivery_count,
	  ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time,
	  ROUND(AVG(
      CASE 
	  WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC <=30
	  THEN 1 ELSE 0 
	  END
	  ) *100,2) AS sla_compliance_pct
	  
	  FROM delivery
	    WHERE time_taken_min IS NOT NULL
		AND time_taken_min ~ '[0-9]' AND city IS NOT NULL
		GROUP BY city
		ORDER BY avg_time DESC;

-- How does delivery performance vary by vehicle type?

SELECT type_of_vehicle,
      COUNT(*) AS delivery_count,
	  ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time,
	  ROUND(AVG(
      CASE 
	  WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC <=30
	  THEN 1 ELSE 0 
	  END
	  ) *100,2) AS sla_compliance_pct
	  
	  FROM delivery
	    WHERE time_taken_min IS NOT NULL
		AND time_taken_min ~ '[0-9]' AND type_of_vehicle IS NOT NULL
		GROUP BY type_of_vehicle
		ORDER BY avg_time DESC;

 -- How does delivery performance vary by hour?
 SELECT
     EXTRACT(HOUR FROM time_orderd) AS hour_of_day,
	 COUNT(*) AS delivery_count,
	 ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time,
	 ROUND(AVG(
	 CASE
	  WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC <=30
     THEN 1 ELSE 0
	 END 
	) *	100,2) AS sla_comlince_pct
	 FROM delivery
	 WHERE time_taken_min IS NOT NULL AND time_taken_min ~ '[0-9]'
	 AND time_orderd IS NOT NULL
	 GROUP BY 1
	 ORDER BY 1;
	 
-- Is performance different on weekends?
SELECT 
    CASE
	    WHEN EXTRACT(DOW FROM order_date::DATE) IN (0,6) THEN 'weekend'
		ELSE 'weekday'
		END AS day_type,
		COUNT(*) AS delivery_count,
		ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time,
		ROUND(AVG(
        CASE
		   WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC <= 30 
		   THEN 1 ELSE 0
		   END
		) *100,2) AS sla_complince_pct
		FROM delivery
		WHERE time_taken_min IS NOT NULL AND time_taken_min ~ '[0-9]'
		AND order_date IS NOT NULL
		GROUP BY 1;
		
	 
-- How many deliveries were delayed (over 30 min)?
SELECT 
       CASE WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC >30
	   THEN 'delayed'
	   ELSE 'on time'
	   END AS status,
	   COUNT(*) AS total
	   FROM delivery
	   GROUP BY 1;

-- How many deliveries were delayed by weather condition?
SELECT weatherconditions,
      CASE WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]','', 'g')::NUMERIC >30
	  THEN 'delayed'
	  ELSE 'on time'
	  END AS delivery_status,
	  COUNT(*) AS total
	  FROM delivery
	  GROUP BY 1,2
	  ORDER BY 1,2;
	  
-- How many deliveries were delayed by traffic density?
SELECT road_traffic_density,
CASE WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC > 30
THEN 'delayed'
ELSE 'on time'
END AS delivery_status,
COUNT(*) AS total
FROM delivery
GROUP BY 1,2
ORDER BY 1,2;

-- How many deliveries were delayed by vehicle type?
SELECT type_of_vehicle,
CASE WHEN REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC >30
THEN 'delayed'
ELSE 'on time'
END AS delivery_status,
COUNT(*) AS total
FROM delivery
GROUP BY 1,2
ORDER BY 1,2;

-- Do multiple deliveries take longer?
SELECT multiple_deliveries,
COUNT(*) AS total_delivery,
ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
FROM delivery
WHERE time_taken_min IS NOT NULL
AND time_taken_min ~ '[0-9]'
GROUP BY 1
ORDER BY 1;



-- Question: Which order type takes the longest to deliver?

SELECT 
    type_of_order,
    COUNT(*) AS total_delivery,
    ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::numeric), 2) AS avg_time
FROM delivery
WHERE time_taken_min IS NOT NULL
  AND time_taken_min ~ '[0-9]'
GROUP BY 1
ORDER BY 3 DESC;


 -- What is the min, max, and avg delivery time per city?
SELECT city,
       COUNT(*) AS total,
	   MAX(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC) AS fastest,
	   MIN(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC) AS slowest,
ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
FROM delivery
WHERE time_taken_min IS NOT NULL
AND time_taken_min ~ '[0-9]'
AND city IS NOT NULL
GROUP BY 1
ORDER BY avg_time;
 

-- How many deliveries received each rating (1 to 5)?
SELECT 
delivery_person_ratings,
COUNT(*) AS total_delivery
FROM delivery
WHERE delivery_person_ratings IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- How many delivery partners fall into each age group?
 SELECT
 CASE 
 WHEN delivery_person_age < 25 THEN 'young (18-24)'
 WHEN delivery_person_age <35 THEN  'mid(25-34)'
 WHEN delivery_person_age <45 THEN 'senior(34-41)'
 ELSE 'veteran (45+)'
 END AS age_group,
 COUNT(*) AS total_partners
 FROM delivery
 WHERE delivery_person_age IS NOT NULL
 GROUP BY 1
 ORDER BY 1;

 -- Which are the top 5 slowest cities by average delivery time?
 SELECT city,
  COUNT(*) AS total,
  ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
  FROM delivery
  WHERE time_taken_min IS NOT NULL AND time_taken_min ~ '[0-9]'
  AND city IS NOT NULL
  GROUP BY city
  ORDER BY avg_time DESC
  LIMIT 5;
 
 -- Do lower ratings correspond to longer delivery times?
 SELECT delivery_person_ratings,
 COUNT(*) AS total,
 ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
 FROM delivery
 WHERE time_taken_min IS NOT NULL 
 AND time_taken_min ~ '[0-9]'
 AND delivery_person_ratings IS NOT NULL
 GROUP BY delivery_person_ratings
 ORDER BY delivery_person_ratings;

 -- Top 10 Fastest Partners
 SELECT delivery_person_id,
 COUNT(*) AS total,
 ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
 FROM delivery
 GROUP BY delivery_person_id
 HAVING COUNT(*)>=50
 ORDER BY avg_time ASC LIMIT 10;

-- Bottom 10 Slowest Partners
 
 SELECT delivery_person_id,
 COUNT(*) AS total,
 ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
 FROM delivery
 GROUP BY delivery_person_id
 HAVING COUNT(*)>=50
 ORDER BY avg_time DESC LIMIT 10;


 -- Top Rated Partners
 SELECT delivery_person_id,
 COUNT(*) AS total,
 ROUND(AVG(delivery_person_ratings),2) AS avg_rating
 FROM delivery
 GROUP BY delivery_person_id
 HAVING COUNT(*)>= 50
 ORDER BY avg_rating DESC LIMIT 10;


-- Worst Rated Partners
SELECT delivery_person_id,
COUNT(*) AS total,
ROUND(AVG(delivery_person_ratings),2) AS avg_ratings
FROM delivery
GROUP BY delivery_person_id
HAVING COUNT(*)>=50
ORDER BY avg_ratings ASC LIMIT 10;

-- City-wise Partner Count
SELECT city, 
COUNT(DISTINCT delivery_person_id ) AS total_partners,
COUNT(*) AS total_delivery
FROM delivery
WHERE city IS NOT NULL 
AND delivery_person_id IS NOT NULL
GROUP BY city
ORDER BY total_partners;

-- Vehicle-wise Partner Count
SELECT type_of_vehicle,
COUNT(DISTINCT delivery_person_id) AS total_partners,
COUNT(*) AS total_delivery,
ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
FROM delivery
WHERE type_of_vehicle IS NOT NULL
AND time_taken_min ~ '[0-9]'
AND delivery_person_id IS NOT NULL
GROUP BY type_of_vehicle
ORDER BY total_partners DESC;



 -- Rating vs Age Group
 SELECT
      CASE
	  WHEN delivery_person_age <25 THEN 'young (18-24)'
	  WHEN delivery_person_age <35 THEN 'mid (24-34)'
	  WHEN delivery_person_age <45 THEN 'senior (34-44)'
	  ELSE 'veneter(45+)'
	  END AS age_group_rating,
	  COUNT(*) AS total,
	  ROUND(AVG(delivery_person_ratings),2) AS avg_ratings
	  FROM delivery
	  WHERE delivery_person_age IS NOT NULL
	  AND delivery_person_ratings IS NOT NULL
	  GROUP BY age_group_rating
	  ORDER BY avg_ratings DESC;
    
-- Which vehicle type performs best in each city (by average delivery time)?

SELECT city, type_of_vehicle,
COUNT(*) AS total,
ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
FROM delivery 
WHERE city IS NOT NULL
AND type_of_vehicle IS NOT NULL
AND time_taken_min ~ '[0-9]'
GROUP BY city, type_of_vehicle
ORDER BY city, avg_time;
 
-- Do experienced partners (longer tenure) deliver faster than new partners?
SELECT delivery_person_id,
MIN(order_date) AS fast_delivery,
COUNT(*) AS total_deliveries,
ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
FROM delivery
WHERE delivery_person_id IS NOT NULL 
AND order_date IS NOT NULL 
AND time_taken_min ~ '[0-9]'
GROUP BY delivery_person_id
HAVING COUNT(*)>=50
ORDER BY fast_delivery;

 -- Which partners have been active across the most months?
 SELECT delivery_person_id,
 COUNT(DISTINCT EXTRACT(MONTH FROM order_date)) AS active_months,
 COUNT(*) AS total_deliveries,
 ROUND(AVG(REGEXP_REPLACE(time_taken_min, '[^0-9]', '', 'g')::NUMERIC),2) AS avg_time
 FROM delivery
 WHERE delivery_person_id IS NOT NULL
 AND order_date IS NOT NULL
 AND time_taken_min ~ '[0-9]'
 GROUP BY delivery_person_id
 HAVING COUNT(DISTINCT EXTRACT(MONTH FROM order_date))>=2
 ORDER BY active_months DESC, total_deliveries DESC;















	 




 
