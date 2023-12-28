/*
This SQL script aims to provide analysis on incidents regarding the public bus transport systems in London from 2015 to 2018 using MySQL.
A Tableau dashboard will also be provided to provided a visual representation on incidents based on location, season, and so on.
Kindly check the README file for the link to the Tableau dashboard.
The questions aimed to be answered should be above the various SQL statements, with a general report on insights made in the README file.
*/

CREATE SCHEMA tfl_bus_safety;

USE tfl_bus_safety;

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
MODIFY COLUMN `Date Of Incident` DATE;

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
	Borough, COUNT(*) AS Fatalities
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal'
GROUP BY Borough
ORDER BY Fatalities DESC;
/*
OUTPUT:
Borough             +Fatalities
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
None London Borough |1
       Bexley       |1
      Havering      |1
     Wandsworth     |1
   Waltham Forest   |1
*/

-- What were the causes of fatalities in the various locations?
SELECT 
	Borough, `Incident Event Type`, COUNT(*) AS Fatalities
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal'
GROUP BY Borough, `Incident Event Type`
ORDER BY Fatalities DESC
-- LIMIT 3
;
/*
OUPTUT(Shortened):
Borough    +Incident Event Type+Fatalities
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
Injury Result Description                                       +Frequency+Ratio
                    Injuries treated on scene                   |  17336  | 0.7486
Taken to Hospital – Reported Serious Injury or Severity Unknown |   2994  | 0.1293
            Reported Minor Injury - Treated at Hospital         |   2786  | 0.1203
                              Fatal                             |    42   | 0.0018
*/

-- Relay information on the victims based on their category
SELECT `Victim Category`, COUNT(*) AS Count
FROM bus_safety
GROUP BY `Victim Category`
ORDER BY count DESC;
/*
OUTPUT:
Victim Category            + Count
         Passenger         | 18828
        Pedestrian         | 1612
        Bus Driver         | 1484
3rd Party driver / Occupant|  573
         Cyclist           |  275
     Member Of Public      |  127 
       Motorcyclist        |  102
     Operational Staff     |  59
         Cyclist           |  33
        Conductor          |  28
          Other            |  16
    Contractor Staff       |  6
   Non-Operational Staff   |  4
        TfL Staff          |  4
      Motorcyclist         |  4
    Insufficient Data      |  2
  Operations staff (other) |  1
*/

-- For the gender
SELECT `Victims Sex`, COUNT(*) AS Count
FROM bus_safety
GROUP BY `Victims Sex`
ORDER BY count DESC;
/*
OUTPUT:
Victims Sex + Count
   Female   | 11847
    Male    |  7709
   Unknown  |  3602
*/

-- Which gender group accounted for most fatalities?
SELECT `Victims Sex`, `Victim Category`, COUNT(*) AS Fatalities
FROM bus_safety
WHERE `Injury Result Description` = 'Fatal'
GROUP BY `Victims Sex`, `Victim Category`
ORDER BY 2 DESC;
/*
OUTPUT:
Victims Sex +       Victim Category       + Fatalities
    Male    |          Pedestrian         |    20
   Female   |          Pedestrian         |    8
   Female   |          Passenger          |    1
    Male    |          Passenger          |    5
    Male    |        Motorcyclist         |    4
    Male    |           Cyclist           |    2
    Male    | 3rd Party driver / Occupant |    1
   Female   | 3rd Party driver / Occupant |    1
*/

-- For the age group
SELECT `Victims Age`, COUNT(*) AS Count
FROM bus_safety
GROUP BY `Victims Age`
ORDER BY count DESC;
/*
OUTPUT:
Victims Age + Count
   Adult    | 10754 
  Unknown   |  7135
  Elderly   |  2769
   Child    |  2181
   Youth    |   319
*/

-- Which category of passengers based on age and gender were affected the most?
SELECT `Victims Sex`, `Victims Age`, COUNT(*) AS Count
FROM bus_safety
WHERE `Victim Category` = 'Passenger'
GROUP BY `Victims Sex`, `Victims Age`
ORDER BY count DESC
-- LIMIT 5
;
/*
OUTPUT:
Victims Sex + Victims Age + Count
   Female   |    Adult    |  5460
   Female   |   Unknown   |  2531
   Unknown  |   Unknown   |  2522
    Male    |    Adult    |  2190
   Female   |   Elderly   |  1791
*/

-- Which year recorded the most incidents?
SELECT `Year`, COUNT(*) AS Incidents
FROM bus_safety
GROUP BY Year
ORDER BY Incidents ASC;
/*
OUTPUT:
Year + Incidents
2018 | 4777
2015 | 5715
2016 | 6093
2017 | 6573
*/

-- Examine the year, 2018
SELECT Year, `Date of Incident`
FROM bus_safety
WHERE Year = 2018
;
/*
It seems that for the year 2018, incidents weren't recorded for the whole year. With the last recorded month of 2018 being September.
Confirm this and examine the remaining years 
*/

SELECT Year, MONTH(`Date Of Incident`) AS incident_month
FROM bus_safety
GROUP BY Year, incident_month
ORDER BY Year, incident_month;
/*
As expected, the year 2018 only had records till September, while the remaining years had records for all the month. 
This explain why there was a steady increment in incidents as the  years increased and a decline for 2018.
Refer to the incidents_by_year_and_month.csv file in the outputs folder.
*/

-- Were particular seasons of the years contributing factors to the incidents?
SELECT QUARTER(`Date Of Incident`) AS incident_quarter, COUNT(`Incident Event Type`) AS total_incidents
FROM bus_safety
GROUP BY incident_quarter
ORDER BY 2 DESC;
/*
OUTPUT:
incident_quarter + total_incidents
         3       |     6390
         2       |     6206
         1       |     5719
         4       |     4843

Among the 4 years, incidents occured the most from July to September. 
*/

-- Which seasons had the most incidents with respect to the various years?
SELECT Year, QUARTER(`Date Of Incident`) AS incident_quarter, COUNT(`Incident Event Type`) AS quarterly_incidents
FROM bus_safety
GROUP BY Year, incident_quarter
ORDER BY 3 DESC
-- LIMIT 5
;
/*
OUTPUT:
Year + incident_quarter + quarterly_incidents
2017 |         3        |        1762
2017 |         4        |        1721
2018 |         2        |        1653
2016 |         4        |        1634
2016 |         3        |        1602

Check the total_incidents_by_year_and_quarter.csv file for the full table
*/

-- How many Routes were used?
SELECT COUNT(DISTINCT Route)
FROM bus_safety;
-- 612 routes were used

-- Which routes were the most dangerous?
SELECT Route, COUNT(`Incident Event Type`) AS Incidents
FROM bus_safety
GROUP BY Route
ORDER BY 2 DESC
-- LIMIT 5
;
/*
OUTPUT:
Route + Incidents
  OOS |    321
  18  |    191
  55  |    177
  24  |    165
  73  |    156
Kindly refer to the incidents_by_route.csv file in the outputs folder for the full table
*/


-- How many service providers were present?
SELECT COUNT(DISTINCT Operator)
FROM bus_safety;
-- There were 25 service providers

-- Which service providers recorded the most incidents?
SELECT Operator, COUNT(`Incident Event Type`) AS Incidents
FROM bus_safety
GROUP BY Operator
ORDER BY 2 DESC
-- LIMIT 5
;
/*
OUTPUT:
      Operator     + Incidents
     Metroline     |   3457
Arriva London North|   3208
    East London    |   2402
   London United   |   2263
      Selkent      |   1808
*/
