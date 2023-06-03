/* Part 2: Energy Losses and Market Reliability */

/* #1. Of the outage types in 2016 and 2017, what are the respective percentages composed of forced outages? */

-- 1.1. The total number of approved forced outage events in 2016 and 2017
SELECT COUNT(*) AS Total_Number_Outage_Events,
	Reason,
	YEAR(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
   AND Reason = 'Forced'
GROUP BY Reason, Year(Start_Time);


-- 1.2. The proportion of outages that were forced in both 2016 and 2017
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


/* #2: What was the average duration for a forced outage during both 2016 and 2017? Have we seen an increase in the average duration of forced outages? */

-- Answer: There has been a significant increase in the average duration of forced outages, and even though the average energy loss has decreased a bit.

-- 2.1. The average duration and energy loss (MW) of forced outages in 2016-2017
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


-- 2.2. The comparison of the average duration of each outage type event in 2016-2017
SELECT Status,
	Reason,
	YEAR(Start_Time) AS Year,
	ROUND(AVG(Outage_MW), 2) AS Avg_Outage_MW_Loss,
    ROUND(AVG(DATEDIFF(MINUTE, Start_Time, End_Time)), 2) AS Average_Outage_Duration_Minutes
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Reason, YEAR(Start_Time)
ORDER BY Reason, Year;


/* #3: Which energy providers tend to be the most unreliable? */

-- 3.1. The average duration and energy loss (MW) for forced outages by participant code
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


-- 3.2. The average outage and sum outage (MW) loss by participant code for forced outages in 2016-2017
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