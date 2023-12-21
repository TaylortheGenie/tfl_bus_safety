CREATE SCHEMA tfl_bus_safety;

USE tfl_bus_safety;

/*
This is a brief introductory paragraph TBD later
*/

-- View the table --
SELECT * FROM bus_safety
LIMIT 5;

/* OUTPUT:
Year;	"Date Of Incident";	Route;Operator;	"Group Name";	"Bus Garage";			Borough;				"Injury Result Description";										"Incident Event Type";	"Victim Category";	"Victims Sex";	"Victims Age"
2015;	01-01-15;1;			"London General";Go-Ahead;		"Garage Not Available";	Southwark;				"Injuries treated on scene";										"Onboard Injuries";		Passenger;			Male;			Child
2015;	01-01-15;4;			Metroline;		 Metroline;		"Garage Not Available";	Islington;				"Injuries treated on scene";										"Onboard Injuries";		Passenger;			Male;			Unknown
2015;	01-01-15;5;			"East London";	 Stagecoach;	"Garage Not Available";	Havering;				"Taken to Hospital – Reported Serious Injury or Severity Unknown";	"Onboard Injuries";		Passenger;			Male;			Elderly
2015;	01-01-15;5;			"East London";	 Stagecoach;	"Garage Not Available";	"None London Borough";	"Taken to Hospital – Reported Serious Injury or Severity Unknown";	"Onboard Injuries";		Passenger;			Male;			Elderly
2015;	01-01-15;6;			Metroline;		 Metroline;		"Garage Not Available";	Westminster;			"Reported Minor Injury - Treated at Hospital";						"Onboard Injuries";		Pedestrian;			Female;			Elderly
*/

-- Display table information --
DESCRIBE bus_safety;

/*OUTPUT:
Field;						Type;	Null;	Key;	Default;	Extra
Year;						int;	NO;				NULL;
"Date Of Incident";			text;	NO;				NULL;
Route;						text;	NO;				NULL;
Operator;					text;	NO;				NULL;
"Group Name";				text;	NO;				NULL;
"Bus Garage";				text;	NO;				NULL;
Borough;					text;	NO;				NULL;
"Injury Result Description";text;	NO;				NULL;
"Incident Event Type";		text;	NO;				NULL;
"Victim Category";			text;	NO;				NULL;
"Victims Sex";				text;	NO;				NULL;
"Victims Age";				text;	NO;				NULL;
*/

-- How many samples were recorded? --
SELECT COUNT(*) FROM bus_safety;
-- 23,158 samples were recorded.

-- Convert the Date of Incident column type --
ALTER TABLE bus_safety 
MODIFY COLUMN `Date Of Incident` DATETIME;

-- How many locations were recorded? --
SELECT COUNT(DISTINCT Borough) FROM bus_safety;
-- 35 locations were recorded for the dataset 

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

-- What kind of Iinjuries and incidents recurred frequently in the various locations?




 