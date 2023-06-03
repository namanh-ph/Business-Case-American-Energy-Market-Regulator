# Part 1: Energy Stability and Market Outages
(*): Display only the first 5 rows of the actual answer

## 1. What are the most common outage types?

### 1.1. The number of valid (i.e. Status = Approved) outage events in 2016
``` sql
SELECT COUNT(*) AS Total_Number_Outage_Events,
    Status,
    Reason
FROM AEMR
WHERE YEAR(Start_Time) = 2016
    AND Status = 'Approved'
GROUP BY Status, Reason
ORDER BY Reason;
```
|Total_Number_Outage_Events|Status|Reason|
|---|---|---|
|181|Approved|Consequential|
|1264|Approved|Forced|
|106|Approved|Opportunistic Maintenance (Planned)|
|380|Approved|Scheduled (Planned)|



### 1.2. The number of valid (i.e. Status = Approved) outage events in 2017
``` sql
SELECT COUNT(*) AS Total_Number_Outage_Events,
    Status,
    Reason
FROM AEMR
WHERE YEAR(Start_Time) = 2017
    AND Status = 'Approved'
GROUP BY Status, Reason
ORDER BY Reason;
```
|Total_Number_Outage_Events|Status|Reason|
|---|---|---|
|127|Approved|Consequential|
|1622|Approved|Forced|
|102|Approved|Opportunistic Maintenance (Planned)|
|320|Approved|Scheduled (Planned)|



### 1.3. The average duration in days for each approved outage type across 2016-2017
``` sql
SELECT Status,
	Reason,
	COUNT(*) AS Total_Number_Outage_Events,
	ROUND(AVG(CAST(DATEDIFF(MINUTE,Start_Time,End_Time) / 60 AS FLOAT) /
		24), 2) AS Average_Outage_Duration_Time_Days,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Reason, YEAR(start_time)
ORDER BY Year, Reason;
```
|Status|Reason|Total_Number_Outage_Events|Average_Outage_Duration_Time_Days|Year|
|---|---|---|---|---|
|Approved|Consequential|181|0.35|2016|
|Approved|Forced|1264|0.56|2016|
|Approved|Opportunistic Maintenance (Planned)|106|0.3|2016|
|Approved|Scheduled (Planned)|380|4.56|2016|
|Approved|Consequential|127|0.33|2017|
|Approved|Forced|1622|0.79|2017|
|Approved|Opportunistic Maintenance (Planned)|102|0.26|2017|
|Approved|Scheduled (Planned)|320|5.57|2017|



## 2. How frequently do outages occur?

### 2.1. The monthly number of all approved outage types in 2016
(*)
``` sql
SELECT Status,
	Reason,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved'
	AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason, MONTH(start_time)
ORDER BY Reason, Month;
```
|Status|Reason|Total_Number_Outage_Events|Month|
|---|---|---|---|
|Approved|Consequential|24|1|
|Approved|Consequential|23|2|
|Approved|Consequential|7|3|
|Approved|Consequential|36|5|
|Approved|Consequential|12|6|



### 2.2. The monthly number of all approved outage types in 2017
(*)
``` sql
SELECT Status,
	Reason,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved'
	AND YEAR(Start_Time) = 2017
GROUP BY Status, Reason, Month(Start_Time)
ORDER BY Reason, Month;
```
|Status|Reason|Total_Number_Outage_Events|Month|
|---|---|---|---|
|Approved|Consequential|12|1|
|Approved|Consequential|27|2|
|Approved|Consequential|19|3|
|Approved|Consequential|12|4|
|Approved|Consequential|5|5|



### 2.3. The monthly number of all approved outage types in 2016-2017
(*)
``` sql
SELECT Status,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Month(Start_Time), Year(Start_Time)
ORDER BY Year(Start_Time), Month(Start_Time);
```
|Status|Total_Number_Outage_Events|Month|Year|
|---|---|---|---|
|Approved|191|1|2016|
|Approved|227|2|2016|
|Approved|136|3|2016|
|Approved|135|4|2016|
|Approved|173|5|2016|



## 3. Are there any energy providers that have more outages than their peers that may be indicative of being unreliable?

### 3.1. The number of all approved outage types by participant codes in 2016-2017
(*)
``` sql
SELECT COUNT(*) AS Total_Number_Outage_Events,
	Participant_Code,
	Status,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, Year(Start_Time)
ORDER BY Year(Start_Time), Participant_Code;
```
|Total_Number_Outage_Events|Participant_Code|Status|Year|
|---|---|---|---|
|298|AURICON|Approved|2016|
|209|AUXC|Approved|2016|
|53|COLLGAR|Approved|2016|
|12|DNHR|Approved|2016|
|69|ENRG|Approved|2016|



### 3.2. The average duration of approved outage types by participant codes 2016-2017
(*)
``` sql
SELECT Participant_Code,
	Status,
	Year(Start_Time) AS Year,
	ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) /
		24), 2) AS Outage_Duration_Days
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, YEAR(Start_Time)
ORDER BY Year(Start_Time), ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) / 24), 2) DESC;
```
|Participant_Code|Status|Year|Outage_Duration_Days|
|---|---|---|---|
|ENRG|Approved|2016|7.15|
|EUCT|Approved|2016|4.03|
|MELK|Approved|2016|2.18|
|KORL|Approved|2016|2.11|
|PJRH|Approved|2016|1.9|