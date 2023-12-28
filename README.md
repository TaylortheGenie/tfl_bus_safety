# Data Analysis On TFL Bus Safety.
**Author**: Eugene Taylor Sampson <br />
**Email**: esampson692@gmail.com <br />
**LinkedIn**: https://www.linkedin.com/in/eugene-taylor-sampson-67869621b/ <br />

If you find this repository, do not hesitate to reach out. Thanks!

## Introduction
This repository aims to provide insight on incidents involving bus transport systems within different London Boroughs.
The types of analysis implemented are explanatory data analysis and exploratory data analysis.

Through MySQL, the explanatory analysis aimed to shed light on the full scope of the data by addressing relatively general enquiries. Check out the SQL [script](./mysql_script.sql) for the explanatory analysis.

For the exploratory analysis, an interactive Tableau dashboard was created, aiming to provide specific information on the dataset, based on the various locations (or Boroughs). Kindly visit the Tableau [link](https://public.tableau.com/app/profile/eugene.taylor.sampson/viz/TFLBusSafetyDashboard_17037098659300/TFLBusSafetyDashboard) for the **interactive** dashboard, and remember to select which Borough you may want insight on!

Special thanks to MakeOverMonday for providing this dataset. Follow the [link](https://data.world/makeovermonday/2018w51) for the dataset or check the [file](./data/bus_safety.csv) in the data folder.

## Explanatory Analysis
- The dataset for the analysis consists of 12 columns and 23,158 samples. There were no null values and the datatypes present are mostly text in nature, with one integer datatype and one date datatype.

- 35 locations were recorded for the dataset with 25 recording fatalities. Westminster was the most dangerous, as it recorded the highest number of incidents - 1571, and was also the Borough with the most fatalities recorded - 5.

- A total of 18,828 passengers were recorded with females utilizing the transport systems the most at 11,847. Adult groups took the buses the most at 10,754, with just 319 youths taking the bus. Female adults had the most incidents with 5,460 observations, and male adults at 2,190, below another female and unknown age group.

- 4 types of injuries were present in the dataset, with approximately 75% of these injuries being treated on the scene of the incident. The incidents leading to death were 42, accounting for 0.2% of the population. 32 males died, as well as 10 females, with no unspecified gender group dying and most fatalites occuring for pedestrians. An interesting observation made was males led the charts for fatalities, even though females were almost as twice as males.

- The total number of routes used by the transport system were 612, with the OOS route recording the most incidents at 321, followed by route 18 at 191 incidents. 

- From 2015 to 2017, there was a steady increase in incidents until 2018, with a significant drop. Further analysis revealed that the data  collected for 2018 was only from January to September, which is the reason for the drop. Also, the 3rd quarter among the years recorded the most incidents at 6390, with the fourth quarter having the least-to no surprise, at 4843. Grouping the seasons according to their corresponding years showed that the third and fourth quarters of 2017 recorded the most incidents, at a total of 3,483 incidents.

**MySQL UI**

![SQLUI](./Screenshots/MySQL%20Workbench.png)

## Exploratory Analysis

- The dashboard provides information on 6 data aspects, mainly the incidents. These aspects are:
    - Incident by location; provides the total incidents for the various locations. You click on which location you want to analyse, and the remaining 5 features will relay insights accordingly.
    - Incident by route; provides the total incidents which occured on the various routes.
    - Incident and injury description; groups the type of event leading to the incident by their injuries and provides the frequecny for the occurences.
    - Incidents over time; relays the total number of incidents by months for the various years.
    - Quarterly Incidents; shows the number of incidents at each quarter for every year.
    - Victim information; gives the number of victims by their age group, gender and category.

**Static Dashboard**

![Tableauviz](./Screenshots/Tableau%20Dashboard.png)

