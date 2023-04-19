CREATE DATABASE IF NOT EXISTS bike_share;

USE bike_share;

#Defining stations table and loading data from csv
DROP TABLE IF EXISTS stations; 
CREATE TABLE stations(
   latitude FLOAT,
   location VARCHAR(20),
   longitude FLOAT,
   name VARCHAR(80),
   station_id INT,
   status VARCHAR(10),
   PRIMARY KEY (station_id)
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bike_share/Austin_MetroBike_Kiosk_Locations.csv'
INTO TABLE stations 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


#Defining trips table and loading data from csv
DROP TABLE IF EXISTS trips; 
CREATE TABLE trips(
   bike_id INT,
   checkout_time TIME,
   duration_minutes INT,
   end_station_id INT,
   end_station_name VARCHAR(80),
   month INT NULL,
   start_station_id INT,
   start_station_name VARCHAR(80),
   start_time DATETIME,
   subscriber_type VARCHAR(50),
   trip_id BIGINT,
   year INT,
   PRIMARY KEY (trip_id)
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQlatitudeL/MySQL Server 8.0/Uploads/bike_share/Austin_MetroBike_Trips.csv'
INTO TABLE trips 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
#replace empty string with null
	(@bike_id, checkout_time, duration_minutes, 
    @end_station_id, end_station_name, @month, 
    @start_station_id, start_station_name, start_time, 
    subscriber_type, trip_id, @year)
    SET month=NULLIF(@month,''),
    year=NULLIF(@year,''),
    end_station_id=NULLIF(@end_station_id,''),
    start_station_id=NULLIF(@start_station_id,''),
    bike_id=NULLIF(@bike_id,'');
    




