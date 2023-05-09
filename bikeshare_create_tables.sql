CREATE DATABASE IF NOT EXISTS bike_share;

USE bike_share;

#Defining stations table and loading data from csv
DROP TABLE IF EXISTS stations; 
CREATE TABLE stations(
   station_id INT,
   station_name VARCHAR(80),
   status VARCHAR(10),
   location VARCHAR(25),
   address VARCHAR(80),
   alternate_name VARCHAR(80),
   asset_num INT,
   property_type VARCHAR(20),
   docks INT,
   power VARCHAR(20),
   length FLOAT,
   width FLOAT,
   notes VARCHAR(120),
   district INT,
   PRIMARY KEY (station_id)
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Austin_MetroBike_Kiosk_Locations.csv'
INTO TABLE stations 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
	(station_id, station_name, status, location, address, 
    @alternate_name, @asset_num, property_type, @docks, power, 
    @length, @width, notes, district, @dummy, @dummy)
    SET 
    alternate_name=NULLIF(@alternate_name,''),
    asset_num=NULLIF(@asset_num,''),
    length=NULLIF(@length,''),
    width=NULLIF(@width,''),
    docks=NULLIF(@docks,'')
    ;
    


#Defining trips table and loading data from csv
DROP TABLE IF EXISTS trips; 
CREATE TABLE trips(

   trip_id BIGINT,
   membership_type VARCHAR(50),
   bike_id VARCHAR(10),
   checkout_date DATE,
   checkout_time TIME,
   checkout_station_id INT,
   checkout_station_name VARCHAR(80),
   return_station_id INT,
   return_station_name VARCHAR(80),
   duration_minutes INT,
   month INT,
   year INT
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Austin_MetroBike_Trips.csv'
INTO TABLE trips 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
#replace empty string with null
	(trip_id, membership_type, @bike_id, 
    @dummy, @checkout_date, checkout_time, 
    @checkout_station_id, checkout_station_name, 
    @return_station_id, return_station_name, duration_minutes,
    @month, @year)
    SET 
    month=NULLIF(@month,''),
    year=NULLIF(@year,''),
    return_station_id=CASE WHEN @return_station_id REGEXP '^-?[0-9]+$' THEN @return_station_id ELSE NULL END,
    checkout_station_id=CASE WHEN @checkout_station_id REGEXP '^-?[0-9]+$' THEN @checkout_station_id ELSE NULL END,
    bike_id=NULLIF(@bike_id,''),
    checkout_date=STR_TO_DATE(@checkout_date, "%m/%d/%Y");
    




