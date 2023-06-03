# American Energy Market Regulator

For my visualisation and data story, please also check out my [Tableau Public Viz](https://public.tableau.com/app/profile/nam.anh.pham3727/viz/AmericanEnergyMarketRegulator_16767868381910/AmericanEnergyMarketRegulator_1).

## 1. Introduction

### 1.1. Background

The American Energy Market Regulator (AEMR) is responsible for looking after the United States of America’s domestic energy network. The regulator’s responsibility is to ensure that America’s energy network remains reliable with minimal disruptions, which are known as outages. There are four key types of outages:

* Consequential – This outage is caused by an exogenous event or a consequence of work unrelated to the energy provider (i.e. A transmission line may be down, which means that a particular power provider may be unable to send energy to the network)
* Forced – This outage is caused by a situation that has forced the power generating asset to be unavailable. In other words, it has caught the AEMR by surprise and was not planned. (i.e. A cooling tower that supplies water to cool down a power-generating asset has broken down, which has now forced the power-generating asset offline as the temperature can no longer be regulated properly.)
* Opportunistic – This outage arises when an energy provider wishes to be proactive with the maintenance of their assets and believes that it can complete maintenance on its plant within a 48-hour window. If it takes longer than this, the outage is considered a PLANNED outage as it was planned in advance and will take longer than 48 hours.
* Planned – This outage arises when an energy provider reports to the AEMR that an energy-generating asset needs to be taken offline for routine or planned maintenance activities to ensure the reliability of the asset in the future.

Of the four outage types, the only one the AEMR penalises is the forced outage, as this means that, if enough energy providers enter the forced outage state and the demand for energy is greater than the amount of energy that can be supplied, stress will be put on the energy system. This will then threaten the reliability of the network which is what the AEMR wishes to avoid.

### 1.2. Objectives

Recently, the AEMR management team has been increasingly aware of a large number of energy providers that submitted outages over the 2016 and 2017 calendar years. The management team has expressed a desire to have the following two areas of concern addressed:

1. Energy Stability and Market Outages
2. Energy Losses and Market Reliability

### 1.3. Methodology & Tools

* SQL: data extraction
* Tableau: data visualisation and analysis

## 2. Data Extraction & Analysis

### 2.1. SQL

Details of the SQL queries can be found [here]().

### 2.2. Tableau

#### 2.2.1. Summary

![Summary](https://github.com/nam-anh-21/American-Energy-Market-Regulator/blob/main/Images/1.%20Summary.png)

In order to understand the energy market, AEMR needs to have an overview regarding outages of 2016 and 2017. Here, Forced outages took place much more often than other reasons of outage in both 2016 and 2017 (occurring 1204 and 1622 times respectively), having the frequency more than 9-10 times compared to other causes. Being recorded as the major reason, Forced outages accounts for about 68% of the total of outages.

Finding out how many outages occur through months is important for the overall frequency. Outages in 2016 decreased by time, but on the other hand we see a surge in number throughout 2017.

#### 2.2.2. Frequency of Outages

![Frequency of Outages](https://github.com/nam-anh-21/American-Energy-Market-Regulator/blob/main/Images/2.%20Frequency%20of%20Outages.png)

Further analysing the frequency of each outage is a necessary step to ensure market stability. Obviously, over the time, Forced cause of outage has always been the dominant type, occurring significantly higher than other types. It is easily seen that Forced outages heavily influenced the overall frequency by months.

As three other types stabilised throughout the months and years, the Forced reason has seen a high fluctuation. However, as it took a dive in March 2017, this type has witnessed a dramatic increase from April, with an occasional decrease in Quarter 4 of the following year.


#### 2.2.3. Forced Outages

![Forced Outages](https://github.com/nam-anh-21/American-Energy-Market-Regulator/blob/main/Images/3.%20Forced%20Outages.png)

It is now ensured that Forced outages are crucial in the whole market, and further insights of this type is a must.

Regarding the average loss of energy by month, In March and April, even though the total loss remains fairly low compared to other months, the average loss of energy peaks at the highest throughout the months. Also, the total energy loss took a sudden rise in 2017, which needs to be taken into consideration.

Regarding the average duration of each occurrence, it is of great concern that the highest average duration of the outages is in December, a winter month that should expect a rise in electricity demand, when the number increases significantly.

#### 2.2.4. Energy Providers

![Energy Providers](https://github.com/nam-anh-21/American-Energy-Market-Regulator/blob/main/Images/4.%20Energy%20Providers.png)

Three categories are selected in order to assess the performance of all energy providers: number of outages, outage duration, energy loss. If one category has one exceedingly high value or two categories have a high value, it is a warning sign of an underperformed energy provider. The smaller the values are, the better the provider is.

* Best providers: DNHR, WGUTD, STHRNCRS
* Worst providers: AURICON, ENRG, GW, PMC, MELK, COLLGAR

AURICON, GW, and MELK ranks at top providers who have a great number of outages. Together with a moderately high energy loss in each outage, they are unreliable sources of electricity, and need to be further investigated.

ENRG has a very high value of outage duration and energy loss, respectively.

COLLGAR and PMC, although do not have a high number of outages, have warning energy loss.

#### 3. Suggestions

* The numbers of outages, especially towards the end of the year, should be monitored. It seems that as the demands rise in winter, the number of outages rise as well. The frequency of outages should be assessed more often, so as to keep track and predict the outcome of the next months.
* Forced outages should be reduced. Forced outages are dominant in all types, at around 70% of all outages. Keeping the forced outages as low as possible helps stabilise the energy market.
* Underperformed providers should be put into investigation, especially AURICON, GW, MELK. They are three most unreliable energy providers, as they have many outages in two years, and a high number of energy losses.
* ENRG, COLLGAR, and PMC should be reviewed too, for they cause some drawbacks in outage duration and energy loss as well.
