/* Part 1: Energy Stability and Market Outages */

/* #1. What are the most common outage types? */

-- 1.1. The number of valid (i.e. Status = Approved) outage events in 2016
SELECT COUNT(*) AS Total_Number_Outage_Events,
    Status,
    Reason
FROM AEMR
WHERE YEAR(Start_Time) = 2016
    AND Status = 'Approved'
GROUP BY Status, Reason
ORDER BY Reason;


-- 1.2. The number of valid (i.e. Status = Approved) outage events in 2017
SELECT COUNT(*) AS Total_Number_Outage_Events,
    Status,
    Reason
FROM AEMR
WHERE YEAR(Start_Time) = 2017
    AND Status = 'Approved'
GROUP BY Status, Reason
ORDER BY Reason;


-- 1.3. The average duration in days for each approved outage type across 2016-2017
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


/* #2. How frequently do outages occur? */

-- 2.1. The monthly number of all approved outage types in 2016
SELECT Status,
	Reason,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved'
	AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason, MONTH(start_time)
ORDER BY Reason, Month;


-- 2.2. The monthly number of all approved outage types in 2017
SELECT Status,
	Reason,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved'
	AND YEAR(Start_Time) = 2017
GROUP BY Status, Reason, Month(Start_Time)
ORDER BY Reason, Month;


-- 2.3. The monthly number of all approved outage types in 2016-2017
SELECT Status,
	COUNT(*) AS Total_Number_Outage_Events,
	MONTH(Start_Time) AS Month,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Month(Start_Time), Year(Start_Time)
ORDER BY Year(Start_Time), Month(Start_Time);


/* #3. Are there any energy providers that have more outages than their peers that may be indicative of being unreliable? */

-- 3.1. The number of all approved outage types by participant codes in 2016-2017
SELECT COUNT(*) AS Total_Number_Outage_Events,
	Participant_Code,
	Status,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, Year(Start_Time)
ORDER BY Year(Start_Time), Participant_Code;


-- 3.2. The average duration of approved outage types by participant codes 2016-2017
SELECT Participant_Code,
	Status,
	Year(Start_Time) AS Year,
	ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) /
		24), 2) AS Outage_Duration_Days
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, YEAR(Start_Time)
ORDER BY Year(Start_Time), ROUND(AVG(CAST(DATEDIFF(MINUTE, Start_Time, End_Time) / 60 AS FLOAT) / 24), 2) DESC;