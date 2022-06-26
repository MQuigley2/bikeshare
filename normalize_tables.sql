USE bike_share;

ALTER TABLE trips
DROP COLUMN month,
DROP COLUMN year;

ALTER TABLE stations
DROP COLUMN location;

UPDATE trips
SET start_station_id=1001
WHERE start_station_name IN 
	('Shop', 
    'Main Office', 
    'Repair Shop', 
    'Re-branding', 
    'Customer Service'); 
    
UPDATE trips
SET end_station_id=1001
WHERE end_station_name IN 
	('Shop', 
    'Main Office', 
    'Repair Shop', 
    'Re-branding', 
    'Customer Service'); 

    
UPDATE trips
SET start_station_id=2546
WHERE start_station_name='ACC - West & 12th';

UPDATE trips
SET end_station_id=2546
WHERE end_station_name='ACC - West & 12th';

UPDATE trips
SET start_station_id=1004
WHERE start_station_name='Red River @ LBJ Library';

UPDATE trips
SET end_station_id=1004
WHERE end_station_name='Red River @ LBJ Library';

UPDATE trips
SET start_station_id=2568
WHERE start_station_name='East 11th Street at Victory Grill';

UPDATE trips
SET end_station_id=2568
WHERE end_station_name='East 11th Street at Victory Grill';

UPDATE trips
SET start_station_id=2539
WHERE start_station_name='Convention Center/ 3rd & Trinity';

UPDATE trips
SET end_station_id=2539
WHERE end_station_name='Convention Center/ 3rd & Trinity';

UPDATE trips
SET start_station_id=2574
WHERE start_station_name='Zilker Park at Barton Springs & William Barton Drive';

UPDATE trips
SET end_station_id=2574
WHERE end_station_name='Zilker Park at Barton Springs & William Barton Drive';

INSERT INTO stations 
	(station_id, name, status, latitude, longitude)  
    VALUES 
		(3001, 'MapJam at Hops & Grain Brewery', 'MapJam', 30.25825, -97.71172),
        (3002, 'MapJam at French Legation', 'MapJam', 30.26729, -97.73178),
        (3003, 'MapJam at Pan Am Park', 'MapJam', 30.25818, -97.72069),
        (3004, 'MapJam at Scoot Inn', 'MapJam', 30.26218, -97.72944);
        
UPDATE trips
SET start_station_id=3001
WHERE start_station_name='MapJam at Hops & Grain Brewery';

UPDATE trips
SET end_station_id=3001
WHERE end_station_name='MapJam at Hops & Grain Brewery';

UPDATE trips
SET start_station_id=3002
WHERE start_station_name='MapJam at French Legation';

UPDATE trips
SET end_station_id=3002
WHERE end_station_name='MapJam at French Legation';

UPDATE trips
SET start_station_id=3003
WHERE start_station_name='MapJam at Pan Am Park';

UPDATE trips
SET end_station_id=3003
WHERE end_station_name='MapJam at Pan Am Park';

UPDATE trips
SET start_station_id=3004
WHERE start_station_name='MapJam at Scoot Inn';

UPDATE trips
SET end_station_id=3004
WHERE end_station_name='MapJam at Scoot Inn';

