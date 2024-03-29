# Austin Bikeshare Analysis

## Disclaimer

  This project is a work in progress. The code on display currently covers the creation and population of database tables, the early exploration of the data and the identification of missing or contradictory data that needs to be resolved. Future updates will include further analysis, visualizations and a machine learning component.
  
## Motivation

  Austin is among [the fastest growing cities in the US](https://worldpopulationreview.com/us-city-rankings/fastest-growing-cities-in-the-us). The city's rapid growth has contributed to some of the worst traffic congestion in the country. INRIX rated Austin's I-35 [the 6th most congested road in america](https://inrix.com/press-releases/2019-traffic-scorecard-us/) Pre-COVID, and currently rates Austin [the 21st most congest city in the US](https://inrix.com/scorecard-city/?city=Austin%20TX&index=240). TxDOT has proposed to alleiviate congestion by expanding I-35, but their proposal has been met [opposition from activist groups](https://rethink35.com/txdots-expansion-plan) who believe the expansion would encourage more car travel, increasing emissions and road fatalities while keeping congestion constant. The city of Austin also has [a plan to limit congestion](https://www.austintexas.gov/department/austin-strategic-mobility-plan) which includes a stated goal of reducing the percentage of people who get to work by driving alone from [74% to only 50%](https://www.austintexas.gov/sites/default/files/files/Transportation/ASMP/ASMP_Chapters/AdoptedASMP_Executive_Summary_and_Introduction.pdf).  

  One of the strategies Austin has implemented to reduce the number of cars on the road is to create [a network of safe bicycle routes](https://austin.maps.arcgis.com/apps/MapJournal/index.html?appid=dba125033d42453491b36ea5fb935eea). Bicycles present a cheap, zero emission transportation solution, but it can be difficult to measure the usage of personal bicycles to determine which factors affect ridership. Fortunately the city also offers [MetroBike](https://www.capmetro.org/ourservices/metrobike), a bike sharing service. MetroBike tracks the origin, destination and time for every trip. MetroBike data does not necessarily correlate with other bike trips, and only covers a small section of the city, but still provides us with the best set of tools to analyze bike ridership in the city of Austin and identify potential approaches to make Austin a more bike friendly city.
  
## Data Sources and Tools Used
  
  The data used in this project was acquired from Austin's [Open Data Portal](https://data.austintexas.gov/). Data is stored in a MySQL database. SQL queries were run through MySQL Workbench and in python with MySQL connector. Python packages used include pandas, plotly and MySQL connector.
