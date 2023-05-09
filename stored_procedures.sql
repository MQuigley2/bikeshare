
DROP PROCEDURE IF EXISTS statuion_stats;

DELIMITER $$

CREATE PROCEDURE station_stats (IN id INT,
                                IN start_year INT,
                                IN end_year INT)  
	BEGIN  
		WITH cte AS(
			SELECT     
				CASE
					WHEN checkout_station_id=id AND return_station_id=id THEN 0     
                    WHEN checkout_station_id=id  THEN return_station_id     
                    WHEN return_station_id=id  THEN checkout_station_id    
				END AS other_station,    
                COUNT(*)/t.cnt AS share_of_trips,    
                AVG(duration_minutes) AS avg_duration_minutes   
			FROM trips   
            CROSS JOIN (    
				SELECT COUNT(*) AS cnt     
                FROM trips     
                WHERE (checkout_station_id=id OR return_station_id=id)     
					AND YEAR(checkout_date)>start_year 
                    AND YEAR(checkout_date)<=end_year) t   
			WHERE (checkout_station_id=id OR return_station_id=id)          
				AND YEAR(checkout_date)>start_year 
                AND YEAR(checkout_date)<=end_year   
                GROUP BY other_station   
                ORDER BY share_of_trips DESC)   
                
		SELECT 
			cte.other_station AS other_station_id,   
            s.station_name AS other_station_name,         
            CAST(REGEXP_SUBSTR(s.location,'30\.[0-9]*') AS FLOAT) AS latitude,          
            CAST(REGEXP_SUBSTR(s.location,'\-97\.[0-9]*') AS FLOAT) AS longitude,   
            cte.share_of_trips AS share_of_trips,   
            cte.avg_duration_minutes AS avg_duration_minutes  
		FROM cte  
        LEFT JOIN stations s   ON s.station_id=cte.other_station;      
        
	END $$
DELIMITER ;
