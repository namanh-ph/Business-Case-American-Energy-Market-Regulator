# Part 2: Energy Losses and Market Reliability
(*): Display only the first 5 rows of the actual answer

## 1. Of the outage types in 2016 and 2017, what are the respective percentages composed of forced outages?

### 1.1. The total number of approved forced outage events in 2016 and 2017
``` sql
SELECT COUNT(*) AS Total_Number_Outage_Events,
	Reason,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
   AND Reason = 'Forced'
GROUP BY Reason, Year(Start_Time);
```
|Total_Number_Outage_Events|Reason|Year|
|---|---|---|
|1264|Forced|2016|
|1622|Forced|2017|



### 1.2. The proportion of outages that were forced in both 2016 and 2017
``` sql
SELECT SUM(CASE WHEN Reason = 'Forced' THEN 1 ELSE 0 END) AS Total_Number_Forced_Outage_Events,
	COUNT(*) AS Total_Number_Outage_Events,
	CAST((CAST(SUM(CASE WHEN Reason = 'Forced' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) /
		CAST(Count(*) AS DECIMAL(10, 2)))
		* 100 AS DECIMAL(10, 2))
		AS Forced_Outage_Percentage,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Year(Start_Time);
```
|Total_Number_Forced_Outage_Events|Total_Number_Outage_Events|Forced_Outage_Percentage|Year|
|---|---|---|---|
|1264|1931|65.46|2016|
|1622|2171|74.71|2017|



## 2. What was the average duration for a forced outage during both 2016 and 2017? Have we seen an increase in the average duration of forced outages?

Answer: There has been a significant increase in the average duration of forced outages, and even though the average energy loss has decreased a bit.

## 2.1. The average duration and energy loss (MW) of forced outages in 2016-2017
``` sql
SELECT Status,
	Reason,
	YEAR(Start_Time) AS Year,
	ROUND(AVG(Outage_MW), 2) AS Average_Energy_Loss,
	CAST(ROUND(AVG(Cast(DATEDIFF(MINUTE, Start_Time, End_Time) AS DECIMAL(10, 2))), 2)
		AS DECIMAL(10, 2)) AS Average_Outage_Duration_Minutes
FROM AEMR
WHERE Status = 'Approved' 
	AND Reason = 'Forced'
GROUP BY Status, Reason, Year(Start_Time)
ORDER BY Year(Start_Time);
```
|Status|Reason|Year|Average_Energy_Loss|Average_Outage_Duration_Minutes|
|---|---|---|---|---|
|Approved|Forced|2016|55.62|812.92|
|Approved|Forced|2017|50.56|1144.09|



## 2.2. The comparison of the average duration of each outage type event in 2016-2017
``` sql
SELECT Status,
	Reason,
	YEAR(Start_Time) AS Year,
	ROUND(AVG(Outage_MW), 2) AS Avg_Outage_MW_Loss,
    ROUND(AVG(DATEDIFF(MINUTE, Start_Time, End_Time)), 2) AS Average_Outage_Duration_Minutes
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Reason, YEAR(Start_Time)
ORDER BY Reason, Year;
```
|Status|Reason|Year|Avg_Outage_MW_Loss|Average_Outage_Duration_Minutes|
|---|---|---|---|---|
|Approved|Consequential|2016|53.06|518|
|Approved|Consequential|2017|51.03|481|
|Approved|Forced|2016|55.62|812|
|Approved|Forced|2017|50.56|1144|
|Approved|Opportunistic Maintenance (Planned)|2016|103.66|456|
|Approved|Opportunistic Maintenance (Planned)|2017|84.4|387|
|Approved|Scheduled (Planned)|2016|99.1|6582|
|Approved|Scheduled (Planned)|2017|85.47|8034|



## 3: Which energy providers tend to be the most unreliable?

### 3.1. The average duration and energy loss (MW) for forced outages by participant code
(*)
``` sql
SELECT Participant_Code,
	YEAR(Start_Time) AS Year,
	ROUND(AVG(Outage_MW), 2) AS Average_Energy_Loss,
	ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) /
		24), 2) AS Average_Outage_Duration_Days
FROM AEMR
WHERE Status = 'Approved'
	AND Reason = 'Forced'
GROUP BY Participant_Code, YEAR(Start_Time)
ORDER BY Year(Start_Time), ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) / 24), 2) DESC;
```
|Participant_Code|Year|Average_Energy_Loss|Average_Outage_Duration_Days|
|---|---|---|---|
|ENRG|2016|56.32|15.7|
|EUCT|2016|5.89|9.73|
|MCG|2016|55|1.29|
|PUG|2016|33.98|0.92|
|MUND|2016|36.8|0.48|



### 3.2. The average outage and sum outage (MW) loss by participant code for forced outages in 2016-2017
(*)
``` sql
SELECT Participant_Code,
	Facility_Code,
	Status,
	YEAR(start_time) AS Year,
	ROUND(AVG(Outage_MW), 2) AS Average_Outage_MW_Loss,
	ROUND(SUM(Outage_MW), 2) AS Sum_Energy_Loss
FROM AEMR
WHERE Status = 'Approved'
	AND Reason = 'Forced'
GROUP BY Participant_Code, Facility_Code, Status, Year(Start_Time)
ORDER BY YEAR(Start_Time) ASC, ROUND(SUM(Outage_MW), 2) DESC;
```
|Participant_Code|Facility_Code|Status|Year|Average_Outage_MW_Loss|Sum_Energy_Loss|
|---|---|---|---|---|---|
|GW|BW1_GREENWATERS_G2|Approved|2016|49.69|15751.38|
|MELK|MELK_G7|Approved|2016|87.71|13771.07|
|AURICON|AURICON_PNJ_U1|Approved|2016|51.42|10696.28|
|PMC|PMC_AG|Approved|2016|131.78|9093.09|
|PJRH|PJRH_GT11|Approved|2016|72.61|5881.52|