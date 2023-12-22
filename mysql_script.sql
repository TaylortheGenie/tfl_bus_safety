CREATE SCHEMA tfl_bus_safety;

USE tfl_bus_safety;

/*
This is a brief introductory paragraph TBD later
*/

-- View the table --
SELECT * FROM bus_safety
LIMIT 5;

/* OUTPUT:
Year + Date Of Incident +Route +   Operator   +Group Name+     Bus Garage     +      Borough      +                   Injury Result Description                   +Incident Event Type+Victim Category+Victims Sex+Victims Age+
2015 | 	  01-01-15      |  1   |London General| Go-Ahead |Garage Not Available|     Southwark     |                   Injuries treated on scene                   | Onboard Injuries  |   Passenger   |    Male   |   Child   |
2015 |    01-01-15      |  4   |   Metroline  |Metroline |Garage Not Available|     Islington     |                   Injuries treated on scene                   |  Onboard Injuries |   Passenger   |    Male   |  Unknown  |
2015 |	  01-01-15      |  5   |  East London |Stagecoach|Garage Not Available|     Havering      |Taken to Hospital – Reported Serious Injury or Severity Unknown|  Onboard Injuries |   Passenger   |    Male   |  Elderly  |
2015 |	  01-01-15      |  5   |  East London |Stagecoach|Garage Not Available|None London Borough|Taken to Hospital – Reported Serious Injury or Severity Unknown|  Onboard Injuries |   Passenger   |    Male   |  Elderly  |
2015 |	  01-01-15      |  6   |   Metroline  |Metroline |Garage Not Available|    Westminster    |          Reported Minor Injury - Treated at Hospital          |  Onboard Injuries |  Pedestrian   |   Female  |  Elderly  |
*/

-- Display table information --
DESCRIBE bus_safety;

/*
The table has no missing values. However, there were some 'unrecorded' samples, especially with respect to the Victim's information.
All the column datatypes are text, except for the year.
However, the 'Date of Incident' column relays date information. Convert this column to a datetime format
*/

-- Convert the Date of Incident column type 
ALTER TABLE bus_safety 
MODIFY COLUMN `Date Of Incident` DATETIME;

/* 
ANALYSIS

*/

-- How many samples were recorded? 
SELECT COUNT(*) FROM bus_safety;
-- 23,158 samples were recorded.

-- How many locations were recorded? --
SELECT COUNT(DISTINCT Borough) FROM bus_safety;
-- 35 locations were recorded for the dataset 

-- How many locations recorded fatalities?
SELECT COUNT(DISTINCT Borough) 
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal';
-- 25 locations recorded fatalities.

-- Which locations were those and how many fatalities were recorded for the various locations?
SELECT 
	Borough, COUNT(*) AS Count
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal'
GROUP BY Borough
ORDER BY Count DESC;
/*
OUTPUT:
Borough             +Count
    Westminster     |5
      Hounslow      |4
       Barnet       |3
       Ealing       |2
Hammersmith & Fulham|2
      Lewisham      |2
      Islington     |2
        Brent       |2
      Greenwich     |2
       Camden       |2
       Newham       |2
      Haringey      |1
      Southwark     |1
      Croydon       |1
       Harrow       |1
Kingston upon Thames|1
   Tower Hamlets    |1
       Hackney      |1
       Merton       |1
     Hillingdon     |1
None London Borough	|1
       Bexley       |1
      Havering      |1
     Wandsworth     |1
   Waltham Forest   |1
*/

-- What were the causes of fatalities in the various locations?
SELECT 
	Borough, `Incident Event Type`, COUNT(*) AS Count
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal'
GROUP BY Borough, `Incident Event Type`
ORDER BY Count DESC
-- LIMIT 3
;
/*
OUPTUT(Shortened):
Borough    +Incident Event Type+Count
Westminster|Collision Incident |  4
   Barnet  |Collision Incident |  3
   Ealing  |Collision Incident |  2

NOTES; Most incidents that led to fatalities were 'Collision Incident'. A few 'Slip Trip Fall' and 'Onboard Injuries' incidents recurred, with just one instance of 'Assault'.
Kindly visit the location_fatality_count_based_on_incident.csv file in the output folder.
*/

-- Which locations recorded the most Incidents?
SELECT Borough, COUNT(*) AS Frequency
FROM bus_safety
GROUP BY Borough
ORDER BY Frequency DESC
LIMIT 5;
/*
OUTPUT:
Borough    +Frequency
Westminster|  1571
 Southwark |  1107
 Lewisham  |  1006
  Lambeth  |  1107
  Croydon  |  1032
*/

-- Rank the severity of injuries based on their frequency and determine the ratio with respect to sample size.
SELECT `Injury Result Description`, COUNT(*) AS Frequency, COUNT(`Injury Result Description`) / 23158 AS Ratio
FROM bus_safety
GROUP BY `Injury Result Description`
ORDER BY Frequency DESC;
/*OUTPUT: 
"Injury Result Description";Frequency;Ratio
"Injuries treated on scene";17336;0.7486
"Taken to Hospital – Reported Serious Injury or Severity Unknown";2994;0.1293
"Reported Minor Injury - Treated at Hospital";2786;0.1203
Fatal;42;0.0018
*/

-- Which category of passengers(based on age and gender) were affected the most?
SELECT `Victims Sex`, `Victims Age`, COUNT(*) AS count
FROM bus_safety
WHERE `Victim Category` = 'Passenger'
GROUP BY `Victims Sex`, `Victims Age`
ORDER BY count DESC;

-- Relay information on the victims
SELECT `Victim Category`, COUNT(*) AS count
FROM bus_safety
GROUP BY `Victim Category`
ORDER BY count DESC;

-- For the gender
SELECT `Victims Sex`, COUNT(*) AS count
FROM bus_safety
GROUP BY `Victims Sex`
ORDER BY count DESC;

-- For the age group
SELECT `Victims Age`, COUNT(*) AS count
FROM bus_safety
GROUP BY `Victims Age`
ORDER BY count DESC;








 