// Richard Connelly, Fall 2019 //
// Data Management//
// Professor: Dr. Adam Okulicz-Kozaryn//

// This research aims to examine the reimplementation of additional funding support for school districts after the 2011 decision in the NJ Supreme Court case Abbot v. Burke. These school districts are of extremely low socioeconomic status and thus have failing schools since school funding in New Jersey is tied to property value. Originally decided in 1985 these schools lost their additional funding in the wake of the recession, where the first cut in many state budgets were state aid to school districts. Once the economy began to recover Abbott v. Burke was reintroduced and such the original 31 school districts were regranted additional funding as a means to ensure the NJ consitutional right to a rigorous and thorough education.  

// My attmempt with this code is examine whether or not this extra funding in the 2016-2017 and 2017-2018 school year has impacted student achievement to any degree compared to those not recieving additioanl funding. I expect to find that it has not meaningfully impacted student achievement as previous studies have not shown much change. However to my knowledge since the 2011 court ruling little research has been done into whether or not these school districts have exhibited any change other than the original findings. Using student test scores, poverty rates per school district, and per pupil expenditures I will attempt to find any relationship between student achievement in Abbott School Districts compared to non-Abbott School Districts.

// Using a multivariate regression model I will utlize student standardized test scores. These test scores will act as a crude metric for student achievement, and as such will act as my dependent variable. My independent varialbes including state aid per pupil and multiple public health indicators such as physical inactivity, obesity, crime rates, teenage birth rates, single parent households, etc.

// There are three main questions I wish to answer with this research:
// 1. Is there a positive relationship between the reinstated stat aid funding and standardized test scores? 
// 2. Does poor public health affect standardized test score?
// 3. If poor public health acts as indicator, which aspects of poor public public health are the most prominent? 

*______________________________________________________________________________*

clear // clears any prior data that could have already been loaded into Stata //
set matsize 800 // Sets maximum number of variables in model to 800 //   
vers 15 //Sets the software version to Stata 15 //
set more off // tells Stata to not pause and show -more message- // 
cap log close // Allows the .dofile to continue despite possible error messages //

*______________________________________________________________________________*

mkdir "C:\Users\rjc361\Desktop/Stata_data/" //Creates a working directory to a public computer CHANGE BEFORE EXECUTING DOFILE // 

cd "C:\Users\rjc361\Desktop/Stata_data/" // Sets the working directory to aforementioned pathway CHANGE BEFORE EXECUTING DOFILE// 

log using log1, replace // Opens log //

*______________________________________________________________________________*
* In this section we're going to pull Math and English Language Arts Test scores from the 2017-2018 school year and merge them *

use "https://github.com/RickConnelly/Data/blob/master/NJ_MATH_2017_18.dta?raw=true", clear //This is the raw data on NJ Math test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE. The direct link to the data can be found here: https://rc.doe.state.nj.us/ReportsDatabase/DistrictPerformanceReports.xlsx under MathParticpationPerform//

drop Subject ProfRateFederalAccountability

ren ValidScores MATHValidScores2017_18
ren ParticipationPercent MATHParticPerc2017_18
ren DistrictPerformance MATHDisPerf2017_18
ren StatePerformance MATHStatePerf2017_18
ren AnnualTarget MATHAnnTar2017_18
ren MetTarget MATHMetTar2017_18

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_MATH_2017_18, replace 

use "https://github.com/RickConnelly/Data/blob/master/NJ_ELA_2017_18.dta?raw=true", clear //This is the raw data on NJ ELA test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE. The direct link to the data can be found here: https://rc.doe.state.nj.us/ReportsDatabase/DistrictPerformanceReports.xlsx under ELALiteracyParticipationPerform//

drop Subject ProfRateFederalAccountability 

ren ValidScores ELAValidScores2017_18
ren ParticipationPercent ELAParticPerc2017_18
ren DistrictPerformance ELADisPerf2017_18
ren StatePerformance ELAStatePerf2017_18
ren AnnualTarget ELAAnnTar2017_18
ren MetTarget ELAMetTar2017_18

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbott Public School student achievement compared to NonAbbott Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_ELA_2017_18, replace 

merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using NJ_MATH_2017_18 
drop _merge 

save Education_Data_2017_2018, replace 

*______________________________________________________________________________*
* Similarly, in this section we're going to pull Math and English Language Arts Test scores from the 2016-2017 school year and merge them *

use "https://github.com/RickConnelly/Data/blob/master/NJ_ELA_2016_17.dta?raw=true", clear //This is the raw data on NJ Math test scores from the 2016-2017 school year uploaded from Github that was pulled directly from the NJ DOE. The direct link to the data can be found here: https://rc.doe.state.nj.us/ReportsDatabase/16-17/DistrictPerformanceReports.xlsx under ELALiteracyParticipationPerform//

drop Subject ProfRateFederalAccountability 

ren ValidScores ELAValidScores2016_17
ren ParticipationPercent ELAParticPerc2016_17
ren DistrictPerformance ELADisPerf2016_17
ren StatePerformance ELAStatePerf2016_17
ren AnnualTarget ELAAnnTar2016_17
ren MetTarget ELAMetTar2016_17

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbott Public School student achievement compared to NonAbbott Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_ELA_2016_17, replace 

use "https://github.com/RickConnelly/Data/blob/master/NJ_MATH_2016_17.dta?raw=true" //This is the raw data on NJ ELA test scores from the 2016-2017 school year uploaded from Github that was pulled directly from the NJ DOE The direct link to the data can be found here: https://rc.doe.state.nj.us/ReportsDatabase/16-17/DistrictPerformanceReports.xlsx under MathParticpationPerform//

drop Subject ProfRateFederalAccountability 

ren ValidScores MATHValidScores2016_17
ren ParticipationPercent MATHParticPerc2016_17
ren DistrictPerformance MATHDisPerf2016_17
ren StatePerformance MATHStatePerf2016_17
ren AnnualTarget MATHAnnTar2016_17
ren MetTarget MATHMetTar2016_17

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbott Public School student achievement compared to NonAbbott Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_MATH_2016_17, replace 

merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using NJ_ELA_2016_17 
drop _merge 

save Education_Data_2016_2017, replace

*______________________________________________________________________________*
* In this section we are going to merge both school years worth of test scores into one dataset * 

use Education_Data_2017_2018, clear

merge 1:1 CountyName DistrictName StudentGroup using Education_Data_2016_2017 
drop _merge 

save Education_Data_2_Years,replace
// Here we have the merged data set for both school years on standardized test scores in both math and english language arts // 

*______________________________________________________________________________*
* This section is where we are pulling data on Per Pupil Expenditures from the New Jersey Department of Education in the 2017-2018 and 2016-2017 school years, once we clean it we each of them we will save it to be merged with the rest of the data. We are only interested in State and Local aid, since Abbot v. Burke only impacts state aid funding. The direct link to the data can be found here: 
// 2017-2018 Expenditure data: https://rc.doe.state.nj.us/ReportsDatabase/DistrictPerformanceReports.xlsx under Per Pupil Expenditures.
// 2016-2017 Expenditure data: https://rc.doe.state.nj.us/ReportsDatabase/16-17/DistrictPerformanceReports.xlsx under Per Pupil Expenditures. //


use "https://github.com/RickConnelly/Data/blob/master/Per_Pupil_Expenditures_2017_18.dta?raw=true", clear 

ren StateLocal ExpPerPupil2017_18

drop if CountyName == "CHARTERS" 
drop if CountyName == "State"
// This drops unnecessary observations so the data merges properly //

save Per_Pupil_Expenditures_2017_18, replace

use "https://github.com/RickConnelly/Data/blob/master/Per_Pupil_Expenditures_2016_17.dta?raw=true", clear

ren StateLocal ExpPerPupil2016_17
ren COUNTY_NAME CountyName
ren DISTRICT_NAME DistrictName
drop DISTRICT_CODE DistrictCode Federal Total  

drop if CountyName == "CHARTERS"

save Per_Pupil_Expenditures_2016_17, replace

*______________________________________________________________________________*
*This section merges in each school year's state aid per pupil in New Jersey. *

use Education_Data_2_Years, clear

merge m:1 CountyName DistrictName using Per_Pupil_Expenditures_2017_18 //Merges State aid per pupil in 2017-2018 //

drop _merge

merge m:1 CountyName DistrictName using Per_Pupil_Expenditures_2016_17 // Merges State aid per pupil in 2016-2017 //

drop if ExpPerPupil2017_18 == "N"
drop if DistrictName == "Camden Prep, Inc."
drop if DistrictName == "KIPP: Cooper Norcross, A New Jersey Nonprofit Corporation"
drop if DistrictName == "Mastery Schools of Camden, Inc."
drop if DistrictName == "Northern Region Educational Services Commission"
drop _merge
// Here we found some non-mergers that we'll be dropping. The first set of non-mergers are charter schools that weren't recorded from one year to another within the data set. This likely because they have either just opened, or have recently closed down operations. Since the purpose of this research is not focused on charter schools and to ensure the data set is as clean and accurate as possible we'll be dropping them. The other form of non-mergers found here are education agencies that are recorded by the New Jersey Department of Education but do not recieve funding from the state, therefore they do not have any impact on our data set and can be dropped. //or education agencies that the New Jersey Department of Education . 

save Education_Data_2_Years_Cleaned, replace

*______________________________________________________________________________*

// I pulled school district poverty data from the U.S. Census for both school years (2016-2017 2017-2018) Direct link to page where data was used can be found here:
// https://www.census.gov/data/datasets/2016/demo/saipe/2016-school-districts.html //
// https://www.census.gov/data/datasets/2017/demo/saipe/2017-school-districts.html //

use "https://github.com/RickConnelly/Data/blob/master/NJ_Poverty_2016_17.dta?raw=true", clear

keep if Tablewithcolumnheadersinrow == "NJ" 
drop Tablewithcolumnheadersinrow 
drop B 
drop C 

ren D DistrictName 
ren E TotalPop2016_17 
ren F TotalStudentPop2016_17 
ren G PovertyStudentPop2016_17 

drop if DistrictName==DistrictName[_n-1] // This drops all repeats of a school district in this data set. From further investigation school districts that repeat are Fairfield Township School District, Franklin Township School District, Greenwich Township School District, Hamilton Township School District, Lawrence Township School District, Mansfield Township School District, Monroe Township School District, Ocean Township School District, Springfield Township School District, Union Township School District, and Washington Township School District. Refering to the codebook or any other material listed on the census website it is unclear why these school districts repeat. Since none of them are our primary focus we wil just keep one of each of them for merging purposes with the caveat these may not be the most accurate sources. Should later research questions involve these school districts contact to the census into why the repeats occur will be necessary. 

destring *, replace

gen prop=PovertyStudentPop2016_17/TotalStudentPop2016_17 * 100 // Controls for population //
ren prop PercStudPovPop2016_17 
 
save NJ_Poverty_2016_17, replace

*_____________________________________________________________________________________________*

use "https://github.com/RickConnelly/Data/blob/master/NJ_Poverty_2017_18.dta?raw=true", clear

keep if Tablewithcolumnheadersinrow == "NJ"
drop Tablewithcolumnheadersinrow
drop B 
drop C 

ren D DistrictName 
ren E TotalPop2017_18 
ren F TotalStudentPop2017_18 
ren G PovertyStudentPop2017_18 

drop if DistrictName==DistrictName[_n-1] // see line 186

destring *, replace

gen prop=PovertyStudentPop2017_18/TotalStudentPop2017_18 * 100 // Controls for population //
ren prop PercStudPovPop2017_18 

save NJ_Poverty_2017_18, replace

*_____________________________________________________________________________________________*

use NJ_Poverty_2017_18, clear 
merge 1:1 DistrictName using NJ_Poverty_2016_17 // Here we have four non-mergers We'll be dropping these as they have no impact on the data, as values were not recordered for them and they are not Abbott Schools //
drop if _merge==1 // Drops non-mergers mentioned above //
drop if _merge==2 // Drops non-mergers mentioned above //

generate str stock_prefix = substr(DistrictName, 1, strlen(DistrictName) - 16) // This deletes 16 characters in each observation in the District Name variable. This was done to increase the probabily the data here will merge properly with the master data set. // 
replace stock_prefix =upper(stock_prefix) // This capitalizes all string observations in the DistrictName variable. This was done to increase the likeihood of a proper merge as all observations in DistrictName in the master data set are capitalized. //
drop _merge 
drop DistrictName 
ren stock_prefix DistrictName 
order DistrictName 

replace DistrictName = "EAST ORANGE" if DistrictName == "EAST ORANGE CITY"
replace DistrictName = "KEANSBURG BORO" if DistrictName == "KEANSBURG BOROUGH"
replace DistrictName = "NEPTU1NE TWP" if DistrictName == "NEPTUNE TOWNSHIP"
replace DistrictName = "CITY OF ORANGE TWP" if DistrictName == "ORANGE CITY TOWNSHIP"
replace DistrictName = "PEMBERTON TWP" if DistrictName == "PEMBERTON TOWNSHIP"
// We want to make sure that the Abbot Schools we want to study merge properly. To make sure that happens I have mannually changed the school district names that did not uniquely identify with the master data set and thus would not have merged. With these mannual changes each school we want to study will have the correct data associated with it. //

save NJ_Poverty_Two_Years, replace 

*_____________________________________________________________________________________________*

use Education_Data_2_Years_Cleaned, replace // Here we load the previously merged data sets **THIS CAN BE USEFUL FOR OTHER RESEARCH QUESTIONS LATER ON, HOWEVER TO MERGE POVERTY DATA WE MUST HEAVILY MANIPUALTE DATASET ** //
merge m:1 DistrictName using NJ_Poverty_Two_Years // This merges the poverty data set with the  master data set by the varialbe "DistrictName" //
// From this merge there are *MANY* non-mergers. Since we want to specifically study abbot school districts we made sure earlier to mannually rename them to ensure a proper merge. All other school districts that did not merge can be dropped because of this. While this deletes many observations we will still have all abbot school districts and a large number of non-Abott schools we can use for comparision later on should we so choose.
drop if _merge==1 // Drops non-mergers mentioned above //
drop if _merge==2 // Drops non-mergers mentioned above //
drop _merge 

save Education_Data_Scores_Expenditures_Poverty, replace

*_____________________________________________________________________________________________*
// This data was imported from County Health Rankings & Roadmaps. Link to the data can be found here: https://www.countyhealthrankings.org/app/new-jersey/2016/downloads //

import excel "https://www.countyhealthrankings.org/sites/default/files/state/downloads/2017%20County%20Health%20Rankings%20New%20Jersey%20Data%20-%20v2.xls", sheet("Ranked Measure Data") cellrange(A4:FF24) clear // Imports the excel directly from the County Health Rankings & Roadmaps, and pulls directly from the sheet titled Ranked Measure Data. //

ren C CountyName
ren AB AdultSmoking2016_17 
ren AF AdultObesity2016_17 
ren AL PhysicalInactivity2016_17 
ren AR ExcessiveDrinking2016_17 
ren BG TeenBirths2016_17 
ren DW SingleParentHouse2016_17 
ren EE ViolentCrime2016_17 

keep CountyName AdultSmoking2016_17 AdultObesity2016_17 PhysicalInactivity2016_17 ExcessiveDrinking2016_17 TeenBirths2016_17 SingleParentHouse2016_17 ViolentCrime2016_17 // This keeps the variables we wish to merge into master dataset //

save Public_health_2016_17, replace

*_____________________________________________________________________________________________*

import excel "https://www.countyhealthrankings.org/sites/default/files/state/downloads/2018%20County%20Health%20Rankings%20New%20Jersey%20Data%20-%20v3.xls", sheet ("Ranked Measure Data") cellrange(A4:FI24) clear

ren C CountyName
ren AE AdultSmoking2017_18 
ren AI AdultObesity2017_18 
ren AO PhysicalInactivity2017_18 
ren AU ExcessiveDrinking2017_18 
ren BH TeenBirths2017_18 
ren DY SingleParentHouse2017_18
ren EG ViolentCrime2017_18 

keep CountyName AdultSmoking2017_18 AdultObesity2017_18 PhysicalInactivity2017_18 ExcessiveDrinking2017_18 TeenBirths2017_18 SingleParentHouse2017_18 ViolentCrime2017_18 // This keeps the variables we wish to merge into master dataset

save Public_health_2017_18, replace

*_____________________________________________________________________________________________*

use Public_health_2016_17, clear 
merge 1:1 CountyName using Public_health_2017_18 
replace CountyName =upper(CountyName) // Makes all strings in County upper case to help with merge to master //
drop _merge

save Public_health_2_years, replace

*______________________________________________________________________________*

use Education_Data_Scores_Expenditures_Poverty, clear
merge m:1 CountyName using Public_health_2_years // Awesome! No non-mergers. Looking over the data all varialbes mergered properly. 
drop _merge

*______________________________________________________________________________*
* This section's code cleans the data in order for it to destring properly, and then save it. *

destring * ,ignore("*""**""N""Not Met""Met Target""Met Goal""Met Target†") replace 

save Education_Data_TOTAL, replace // Saves the data under one name //

*______________________________________________________________________________*

use Education_Data_TOTAL, clear // Loads Data //

gen Abbot_SchoolDist=0 //Generates new variable so we can idenfity Abbott Schools vs. Non-Abbott Schools

replace Abbot_SchoolDist=1 if DistrictName== "ASBURY PARK CITY""BURLINGTON CITY"
replace Abbot_SchoolDist=1 if DistrictName== "BRIDGETON CITY"
replace Abbot_SchoolDist=1 if DistrictName== "BURLINGTON CITY"
replace Abbot_SchoolDist=1 if DistrictName== "CAMDEN CITY"
replace Abbot_SchoolDist=1 if DistrictName== "CITY OF ORANGE TWP"
replace Abbot_SchoolDist=1 if DistrictName== "EAST ORANGE"
replace Abbot_SchoolDist=1 if DistrictName== "ELIZABETH CITY"
replace Abbot_SchoolDist=1 if DistrictName== "GARFIELD CITY"
replace Abbot_SchoolDist=1 if DistrictName== "GLOUCESTER CITY"
replace Abbot_SchoolDist=1 if DistrictName== "HARRISON TOWN"
replace Abbot_SchoolDist=1 if DistrictName== "HOBOKEN CITY"
replace Abbot_SchoolDist=1 if DistrictName== "IRVINGTON TOWNSHIP"
replace Abbot_SchoolDist=1 if DistrictName== "JERSEY CITY"
replace Abbot_SchoolDist=1 if DistrictName== "KEANSBURG BORO"
replace Abbot_SchoolDist=1 if DistrictName== "LONG BRANCH CITY"
replace Abbot_SchoolDist=1 if DistrictName== "MILLVILLE CITY"
replace Abbot_SchoolDist=1 if DistrictName== "NEPTUNE CITY"
replace Abbot_SchoolDist=1 if DistrictName== "NEWARK CITY"
replace Abbot_SchoolDist=1 if DistrictName== "NEW BRUNSWICK CITY"
replace Abbot_SchoolDist=1 if DistrictName== "PASSAIC CITY"
replace Abbot_SchoolDist=1 if DistrictName== "PATERSON CITY"
replace Abbot_SchoolDist=1 if DistrictName== "PEMBERTON TWP"
replace Abbot_SchoolDist=1 if DistrictName== "PERTH AMBOY CITY"
replace Abbot_SchoolDist=1 if DistrictName== "PHILLIPSBURG TOWN"
replace Abbot_SchoolDist=1 if DistrictName== "PLEASANTVILLE CITY"
replace Abbot_SchoolDist=1 if DistrictName== "SALEM CITY"
replace Abbot_SchoolDist=1 if DistrictName== "TRENTON CITY"
replace Abbot_SchoolDist=1 if DistrictName== "UNION CITY"
replace Abbot_SchoolDist=1 if DistrictName== "VINELAND CITY"
replace Abbot_SchoolDist=1 if DistrictName== "WEST NEW YORK TOWN"
replace Abbot_SchoolDist=1 if DistrictName== "PLAINFIELD CITY"
// This codes each Abbott School as 1 for easy sorting and idenfication later on //

foreach v in StudentGroup DistrictName CountyName{
encode `v', gen(`v'N)
} 

drop CountyName CountyCode DistrictName StudentGroup ELAMetTar* ELAAnnTar* ELAStatePerf* ELAValidScores* MATHMetTar* MATHAnnTar* MATHStatePerf* MATHValidScores*
order CountyNameN DistrictNameN Abbot_SchoolDist StudentGroupN ELAParticPerc2017_18 ELADisPerf2017_18 MATHParticPerc2017_18 MATHDisPerf2017_18 ExpPerPupil2017_18 MATHParticPerc2016_17 MATHDisPerf2016_17 ELAParticPerc2016_17 ELADisPerf2016_17 

la var Abbot_SchoolDist "1=Abbott School 0=Non-Abbott School"
la var StudentGroupN "Student Demographic"
la var ELAParticPerc2017_18 "% Student Demographic Participation in ELA 2017-2018" 
la var ELADisPerf2017_18 "District Performance in ELA 2017-2018"
la var MATHParticPerc2017_18 "% Student Demographic Participation in Math 2017-2018"
la var MATHDisPerf2017_18 "District Performance in Math 2017-2018"
la var ExpPerPupil2017_18 "Expenditures Per Pupil 2017-2018"
la var ELAParticPerc2016_17 "% Student Demographic Participation in ELA 2016-2017"
la var ELADisPerf2016_17 "District Performance in ELA 2016-2017"
la var MATHParticPerc2016_17 "% Student Demographic Participation in Math 2016-2017" 
la var MATHDisPerf2016_17 "District Performance in Math 2016-2017"
la var ExpPerPupil2016_17 "Expenditures Per Pupil 2016-2017"
la var TotalPop2017_18 "Total County Population 2017-2018 per County"
la var TotalStudentPop2017_18 "Total Student Population 2017-2018 per County"
la var PovertyStudentPop2017_18 "Total Student Population in Poverty 2017-2018 per County"
la var PercStudPovPop2017_18 "% Student Population in Poverty 2017-2018 per County"
la var TotalPop2016_17 "Total County Population 2016-2017 per County"
la var TotalStudentPop2016_17 "Total Student Population 2016-2017 per County"
la var PovertyStudentPop2016_17 "Total Student Population in Poverty 2016-2017 per County"
la var PercStudPovPop2016_17 "% Student Population in Poverty 2016-2017 per County"
la var AdultSmoking2016_17 "% Population of Adult Smokers per County 2016-2017"
la var AdultObesity2016_17 "% Population of Adult Obesity per County 2016-2017"
la var PhysicalInactivity2016_17 "% Population of Adult Inactivity per County 2016-2017"
la var ExcessiveDrinking2016_17 "% Population of Excessive Drinking per County 2016-2017"
la var TeenBirths2016_17 "% Population of Teen Births per County 2016-2017"
la var SingleParentHouse2016_17 "% Population of Single Parent Households per County 2016-2017"
la var ViolentCrime2016_17 "Violent Crime Rates per County 2016-2017"
la var AdultSmoking2017_18 "% Population of Adult Smokers per County 2017-2018"
la var AdultObesity2017_18 "% Population of Adult Obesity per County 2017-2018"
la var PhysicalInactivity2017_18 "% Population of Adult Inactivity per County 2017-2018"
la var ExcessiveDrinking2017_18 "% Population of Excessive Drinking per County 2017-2018"
la var TeenBirths2017_18 "% Population of Teen Births per County 2017-2018"
la var SingleParentHouse2017_18 "% Population of Single Parent Households per County 2017-2018"
la var ViolentCrime2017_18 "Violent Crime Rates per County 2016-2017"

save Education_Data_TOTAL_2, replace // Saves manipulated Data //

*______________________________________________________________________________*
* This section exports the data in several different formats, and closes the log then clears the data. *

export excel using Education_Data_TOTAL,replace 
export delimited using Education_Data_TOTAL,replace 
outfile using Education_Data_TOTAL,replace 
clear 

*______________________________________________________________________________*
* This section shows some descriptive statistics to better familiarize ourselves with the data. *

use Education_Data_TOTAL_2, clear
keep if StudentGroupN==4

loc v ELADisPerf2016_17 MATHDisPerf2016_17 ELADisPerf2017_18 MATHDisPerf2017_18
sum `v',d
// For the 2016-2017 school year on average 53.6% of New Jersey school districts met or exceed expectations on English language arts standardized exams. On the math portion of the exam school districts scored signficantly lower on average with 41.8% meeting or exceeding expectations.
// For the 2017-2018 school year on average 53% New Jersey school districts met or exceed expectations on English language arts standardized exams, similar to the year prior. On the math portion of the exam school districts scored signficantly lower on average with 40.9% meeting or exceeding expectations, a slight decrease.
// Each year shows similar distributions per each subject, with ELA test scores consistently being higher over math scores over the two year period.

*______________________________________________________________________________*
* The purpose of this code is select a random sample to run descriptive statistics on. *

use Education_Data_TOTAL_2, clear 

keep ELADisPerf* MATHDisPerf* DistrictNameN StudentGroupN Abbot_SchoolDist 
keep if StudentGroupN == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
order DistrictNameN StudentGroupN ELADisPerf* MATHDisPerf* Abbot_SchoolDist 

collapse ELADisPerf* MATHDisPerf* Abbot_SchoolD,by(DistrictNameN) 

bys DistrictNameN: sum *DisPerf* // This provides basic statistics on a random sample of school districts in New Jersey //

*______________________________________________________________________________*
*The purpose of this code is compare student achievement between Abbot Schools and Non-Abbot Schools in the 2017-2018 school year.*

use Education_Data_TOTAL_2, clear 

keep ELADisPerf2016_17 ELADisPerf2017_18 MATHDisPerf2016_17 MATHDisPerf2017_18 DistrictNameN StudentGroupN Abbot_SchoolDist 
keep if StudentGroupN == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //

collapse  ELADisPerf2016_17 ELADisPerf2017_18 MATHDisPerf2016_17 MATHDisPerf2017_18 Abbot_SchoolD,by(DistrictNameN) // This collpases all demographics in each school district into the average standardized test scores for but ELA and Math with an Abbot school designation associated with each district shown in "Abbot_SchoolD".

bys Abbot_SchoolD: sum *DisPerf2017_18 *DisPerf2016_17 // This sorts each school district into an Abbot School or Non-Abbot school, then tabulates the percentage of students who met or exceeded expectations to provide descriptive statistics on student achievement comparing the two types of school districts. // 

keep if Abbot_SchoolDist==0
ta DistrictNameN if MATHDisPerf2017_18<=11 // This details an investigation of a possible outlier on the lowest percentile of students who met or exceeded expectations in math testing (only 11% of students met or exceed expectations) from a non-Abbott school district. The school district responsbile for such low scores is the Trenton City School District. It's likely the same factors contributing to poor test results as Abbot schools are contributing to the poor results of the Egg Harbor School district. More research is required to determine if this is true. //

*______________________________________________________________________________*
*This sections shows the district wide test scores for each demographic throughout each Abbot School. *

use Education_Data_TOTAL_2, clear

keep DistrictNameN StudentGroupN MATHDisPerf2016_17 MATHDisPerf2017_18 ELADisPerf2016_17 ELADisPerf2017_18 StudentGroupN Abbot_SchoolDist // Tells Stata keep these specific variables //

keep if Abbot_SchoolDist == 1 
drop Abbot_SchoolDist 

collapse ELADisPerf2017_18 MATHDisPerf2017_18 ELADisPerf2016_17 MATHDisPerf2016_17,by(StudentGroupN) // This shows how each demographic scored on standardized tests in Abbot Schools. On average, Black or African American students score lower on both math and reading than White students. Female students score signficantly higher than male students on the ELA portion of the test while male students score higher on the math portion than females. Interestingly, the demographic that scored the lowest are migrant students. Initally I had wondered if the reason behind this was that the tests were only administered in English. However, further research shows PARCC testing is adminstered in 10 languages suggesting the test was adminstered in the migrant student's native language. 

reshape long ELADisPerf MATHDisPerf, i(StudentGroupN) j(Year) string 

*______________________________________________________________________________*
*This section shows the changes in aid over the two year period and reshapes the data. *

use Education_Data_TOTAL_2, clear // Reloads manipulated data //

keep ExpPerPupil2016_17 ExpPerPupil2017_18 DistrictNameN StudentGroupN Abbot_SchoolDist 
keep if StudentGroupN == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
keep if Abbot_SchoolDist == 1 

drop Abbot_SchoolDist 
reshape long ExpPerPupil, i(DistrictNameN) j(Year) string 
order DistrictNameN StudentGroupN Year ExpPerPupil 

*______________________________________________________________________________*
*This section begins the visualization of the data

use Education_Data_TOTAL_2, clear

**Distribution of State Aid per Pupil amoung Abbot and Non-Abbot Schools
foreach a in 0 1{
foreach v in ExpPerPupil2016_17 ExpPerPupil2017_18{
histogram `v' if Abbot_SchoolDist==`a', bin(15) start(10000) frequency fcolor(ltblue) lcolor(black) ytitle(Number of School Districts) xtitle(State Aid per Pupil for `a') name(Funding`v'_`a',replace)
												  }
				}
// A quick visualization of the distribution of state aid per pupuil by Abbot School in the 2016-2017 and 2017-2018 School Year
 
gr combine FundingExpPerPupil2016_17_0 FundingExpPerPupil2016_17_1, col(1) title(State Aid of Abbot and Non-Abbot Schools in 2016-2017 SY) name(Expenditure_SidebySide2016_17,replace)
gr combine FundingExpPerPupil2017_18_0 FundingExpPerPupil2017_18_1, col(1) title(State Aid of Abbot and Non-Abbot Schools in 2017-2018 SY) name(Expenditure_SidebySide2017_18,replace)
//This fits the narrative, Abbot schools look recieve money to offset the dismal amount they get from property tax value but overall they are similar to non-Abbott schools.

*______________________________________________________________________________*
** Demographics of students and how they test in Abbott and Non-Abbott Schools
foreach v of varlist MATHDisPerf2017_18 MATHDisPerf2016_17 ELADisPerf2016_17 ELADisPerf2017_18{
gr hbar (mean) `v', over(Abbot_SchoolDist, sort(`v') label(labsize(tiny))) over(StudentGroupN, label(labsize(tiny))) name(Demographic`v',replace)
}
//This shows each school years Math and ELA test scores (% met or exceeded expectations) side by side sorting on whether the school district is an Abbot Shool or not. 0 = Non-Abbot 1 = Abbot. The spread here is generally what we would expect. Abbot school are performing by and large lower than non-Abbot schools. There are some interesting caveats however. //

gr combine DemographicMATHDisPerf2017_18 DemographicELADisPerf2017_18, title(Standardized Test scores by Demographic) name(Demographic_SidebySide2017_18,replace) // In the 2017-2018 school year American Indidan and Alaskan Native students tested better in both math and english language arts in Abbot schools than in non-Abbot schools. Students with disabilties tested better in ELA than their counterparts.
gr combine DemographicMATHDisPerf2016_17 DemographicMATHDisPerf2016_17, title(Standardized Test scores by Demographic) name(Demographic_SidebySide2016_17,replace) // In the 2016-2017 school year again American Indian or Alaskan Native and Military-Connected students out performed their counterparts in non-Abott schools in math but not in ELA. Foster care students tested higher in english language arts in Abbot Schools than their counterparts, with students in foster care and Sudents with Disabilities performing substantially lower math and ELA than other demographics. //

*______________________________________________________________________________*

**Student Poverty Rates Relationship w/ Grades
use Education_Data_TOTAL_2, clear
foreach v of varlist MATHDisPerf2017_18 ELADisPerf2017_18{
tw (scatter `v' PercStudPovPop2017_18, msize(vsmall))(lfit `v' PercStudPovPop2017_18), ytitle(% Met or Exceed Expectations) xtitle(% Student Population in Poverty) title(2017-2018 School Year) name(Poverty`v', replace)
}
foreach v of varlist MATHDisPerf2016_17 ELADisPerf2016_17{
tw (scatter `v' PercStudPovPop2016_17, msize(vsmall))(lfit `v' PercStudPovPop2016_17), ytitle(% Met or Exceed Expectations) xtitle(% Student Population in Poverty) title(2016-2017 School Year) name(Poverty`v', replace)
}

gr combine PovertyMATHDisPerf2017_18 PovertyMATHDisPerf2016_17,col(1) title(Math Test Scores and Poverty) name(Poverty_MATH_SidebySide, replace)
gr combine PovertyELADisPerf2017_18 PovertyELADisPerf2016_17,col(1) title(ELA Test Scores and Poverty) name(Poverty_ELA_SidebySide, replace) // Interestingly, we see more of a drop in math test scores with less student populations in poverty for the 2017-2018 school year whereas in the 2016-2017 school year we have higher populations per school district in poverty yet math test scores overall dropped less. However, it could be more populations fell into further into poverty and tested around the same as the year prior.

*______________________________________________________________________________*
**Expenditures per Pupil Relationship w/ Grades
use Education_Data_TOTAL_2, clear
keep if StudentGroupN==4 

foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' ExpPerPupil2016_17, msize(vsmall))(lfit `v' ExpPerPupil2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Expenditures per Student by School District) title(2016-2017 School Year) name(Expenditures`v'_`a',replace)
}
} //There seems to be an outlier here skewing the data higher, lets take a look
ta DistrictNameN if ExpPerPupil2016_17>25000 & Abbot_SchoolDist==1
// Asbury Park City school district seems to be the outlier, for some reason they spend quite a large amount per student on average in their school districts. This skews the data. Probably will be different if we were to drop that data point from our graph. Lets try.
drop if ExpPerPupil2016_17>25000 & Abbot_SchoolDist==1
// If we run line 532-536 again we see a much weaker correlation.

foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' ExpPerPupil2017_18, msize(vsmall))(lfit `v' ExpPerPupil2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Expenditures per Student by School District) title(2017-2018 School Year) name(Expenditures`v'_`a',replace)
}
} // Again we see the outlier Asbury Park City here. Slight positive correlations here, the data seems to be loosely scattered.

// QUESTION 1. -- Overall the relationship between extra spending and standardize tests scores do not show a large correlation, but in none of the visualizations of this data are there positive correlations, meaning the extra funding does suggest an increase in test scores, even if it is slight. This is likely due to the outlier we observed early from Asbury Park City. Removing this observation shows a negative relationship as we expected from our review of the literature. However, though it is an isolated case, a drastic increase in state aid spending as we've observed with Asbury Park City warrents further investigation as an opportunity for additional research.

*______________________________________________________________________________*
**Smoking Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' AdultSmoking2016_17, msize(vsmall))(lfit `v' AdultSmoking2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Adult Smoking Habits) title(2016-2017 School Year) name(Smoking`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' AdultSmoking2017_18, msize(vsmall))(lfit `v' AdultSmoking2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Adult Smoking Habits) title(2017-2018 School Year) name(Smoking`v'_`a',replace)
}
}
// The percentage population of smokers in a community does seem to have a negative impact on student outcomes overall, with a strange instance of it a relationship in the 2017-2018 school year. As the percent population smoking increases, so does math test scores.

*______________________________________________________________________________*
**Obesity Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' AdultObesity2016_17, msize(vsmall))(lfit `v' AdultObesity2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Adult Obesity) title(2016-2017 School Year) name(Obesity`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' AdultObesity2017_18, msize(vsmall))(lfit `v' AdultObesity2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Adult Obesity) title(2017-2018 School Year) name(Obesity`v'_`a',replace)
}
}
//QUESTION 3. -- Obestiy is one of the strong correlating aspects of public health with standardized test scores. Strong negative correlations across the board here. It presents the neccessity for more research on the individual health of each school districts students and their families. Also opens up a study for what these school districts are providing their students for food during the school day. Many are most likely on free or reduced lunch, and many school lunch services are privatized. Do privatized lunch services have a negative effect on a students health/learning outcomes?

*______________________________________________________________________________*
**Physical Inactivity Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' PhysicalInactivity2016_17, msize(vsmall))(lfit `v' PhysicalInactivity2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Population Physically Inactive) title(2016-2017 School Year) name(Inactive`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' PhysicalInactivity2017_18, msize(vsmall))(lfit `v' PhysicalInactivity2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Population Physically Inactive) title(2017-2018 School Year) name(Inactive`v'_`a',replace)
}
}
//Again, negative correlations across the board here, yet slightly less so than the relationship between test scores and obesity. Perhaps during the periods of inactivity they're doing school related activities.

*______________________________________________________________________________*
**Excessive Drinking Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' ExcessiveDrinking2016_17, msize(vsmall))(lfit `v' ExcessiveDrinking2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Population that Excessively Drinks) title(2016-2017 School Year) name(Drinking`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' ExcessiveDrinking2017_18, msize(vsmall))(lfit `v' ExcessiveDrinking2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Percent of Population that Excessively Drinks) title(2017-2018 School Year) name(Drinking`v'_`a',replace)
}
}
//Strange positive correlations here. One would imagine as drinking of the population increases test schools of the surrounding students decrease. However some counties with the highest percentage of excess drinkers are some of the best performing. Further investigation is required to understand this relationship. 

*______________________________________________________________________________*
**Teen Birth Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' TeenBirths2016_17, msize(vsmall))(lfit `v' TeenBirths2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Teenage Birth Rates) title(2016-2017 School Year) name(TeenBirth`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' TeenBirths2017_18, msize(vsmall))(lfit `v' TeenBirths2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Teenage Birth Rates) title(2017-2018 School Year) name(TeenBirth`v'_`a',replace)
}
}
// QUESTION 3. -- Teenage Birth Rates also seem to be one of the largest aspects of public health as they relate to test scores. The data suggests that as teen pregenancy increase there is a decrease in test scores. This makes logical sense, teenage pregenancies usually take a toll on the ability to meet academic obligations in order to take care of a child leading to things like students failing or dropping out entirely. Interesting policy ideas here, perhaps a contraceptive campaign for students and the communities they operate in. 

*______________________________________________________________________________*
**Single Parent Household Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' SingleParentHouse2016_17, msize(vsmall))(lfit `v' SingleParentHouse2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(% Single-Parent Household) title(2016-2017 School Year) name(SingleParent`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' SingleParentHouse2017_18, msize(vsmall))(lfit `v' SingleParentHouse2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(% Single-Parent Household) title(2017-2018 School Year) name(SingleParent`v'_`a',replace)
}
}
// These graphs suggest that as the percentage of single parent households increase, student standardize test scores decrease. The relationship here is not a strong as I would have expected however, and possibly not as much of a policy concern for lawmakers.

*______________________________________________________________________________*
**Violent Crime Rate Relationship w/ Grades
foreach a in 0 1{
foreach v of varlist ELADisPerf2016_17 MATHDisPerf2016_17{
tw (scatter `v' ViolentCrime2016_17, msize(vsmall))(lfit `v' ViolentCrime2016_17) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Violent Crime Rates) title(2016-2017 School Year) name(Crime`v'_`a',replace)
}
}
foreach a in 0 1{
foreach v of varlist ELADisPerf2017_18 MATHDisPerf2017_18{
tw (scatter `v' ViolentCrime2017_18, msize(vsmall))(lfit `v' ViolentCrime2017_18) if Abbot_SchoolDist==`a', ytitle(% Met or Exceed Expectations) xtitle(Violent Crime Rates) title(2017-2018 School Year) name(Crime`v'_`a',replace)
}
}
//Unsurprisngly, as violent crime increaes in communities, test scores suffer. 

*______________________________________________________________________________*

// QUESTION 2. -- From the visualization of these graphs it appears there are negative relationships between public health. Running regressions between these variables will show how one affects the other and whether or not they are statistically signficant. 

*______________________________________________________________________________*
**Regression of varialbes.
use Education_Data_TOTAL_2, clear
keep if Abbot_SchoolDist==1
keep if StudentGroupN==4

reg ELADisPerf2016_17 ExpPerPupil2016_17
outreg2 using ELA2016_2017.xls, replace
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 SingleParentHouse2016_17
outreg2 using ELA2016_2017.xls, append 
reg ELADisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 SingleParentHouse2016_17 ExcessiveDrinking2016_17
outreg2 using ELA2016_2017.xls, append 
//Runs regressions for all variables with ELA test scores in the 2016-2017 school year

reg ELADisPerf2017_18 ExpPerPupil2017_18
outreg2 using ELA2017_2018.xls, replace
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18
outreg2 using ELA2017_2018.xls, append 
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18
outreg2 using ELA2017_2018.xls, append  
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18
outreg2 using ELA2017_2018.xls, append 
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18
outreg2 using ELA2017_2018.xls, append  
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18
outreg2 using ELA2017_2018.xls, append  
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18
outreg2 using ELA2017_2018.xls, append 
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18 SingleParentHouse2017_18
outreg2 using ELA2017_2018.xls, append  
reg ELADisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18 SingleParentHouse2017_18 ExcessiveDrinking2017_18
outreg2 using ELA2017_2018.xls, append 
}
//Runs regressions for all variables with ELA test scores in the 2017-2018 school year

reg MATHDisPerf2016_17 ExpPerPupil2016_17
outreg2 using MATH2016_2017.xls, replace
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17
outreg2 using MATH2016_2017.xls, append 
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17
outreg2 using MATH2016_2017.xls, append  
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17
outreg2 using MATH2016_2017.xls, append  
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17
outreg2 using MATH2016_2017.xls, append 
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17
outreg2 using MATH2016_2017.xls, append  
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 
outreg2 using MATH2016_2017.xls, append 
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 SingleParentHouse2016_17
outreg2 using MATH2016_2017.xls, append 
reg MATHDisPerf2016_17 ExpPerPupil2016_17 PercStudPovPop2016_17 AdultObesity2016_17 AdultSmoking2016_17 PhysicalInactivity2016_17 TeenBirths2016_17 ViolentCrime2016_17 SingleParentHouse2016_17 ExcessiveDrinking2016_17
outreg2 using MATH2016_2017.xls, append 
//Runs regressions for all variables with Math test scores in the 2016-2017 school year

reg MATHDisPerf2017_18 ExpPerPupil2017_18
outreg2 using MATH2017_2018.xls, replace
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18
outreg2 using MATH2017_2018.xls, append 
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18
outreg2 using MATH2017_2018.xls, append   
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18
outreg2 using MATH2017_2018.xls, append  
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18
outreg2 using MATH2017_2018.xls, append 
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18
outreg2 using MATH2017_2018.xls, append   
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18
outreg2 using MATH2017_2018.xls, append 
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18 SingleParentHouse2017_18
outreg2 using MATH2017_2018.xls, append  
reg MATHDisPerf2017_18 ExpPerPupil2017_18 PercStudPovPop2017_18 AdultObesity2017_18 AdultSmoking2017_18 PhysicalInactivity2017_18 TeenBirths2017_18 ViolentCrime2017_18 SingleParentHouse2017_18 ExcessiveDrinking2017_18
outreg2 using MATH2017_2018.xls, append 
//Runs regressions for all variables with Math test scores in the 2017-2018 school year

*______________________________________________________________________________*
**Final Analysis

// Much of the literature surrounding allocating additional resources to disadvantaged schools in order to close the achievement gap has been subject to harsh critisms. This is mainly due to critics believing that these extra reources do not actually positively impact student achievement. Funding structures are mainly supported by federal and state dollars, and the methods that produce how much a school can spend per pupil are normally subjected to unforeseen variables and politics gaming the system. In many studies an increase in state or federal funding for disadvantaged schools shows no signficant rise in test scores. However, studies examing school finance structures and improving spending equity have shown that spending does in fact matter and does impact student achievement. 

// My attempt with this research was to study the relationship between standardized test scores and per pupil expenditures while controlling for public health issues (crime rates, single parent households, obesity, etc.) that I thought were the most detrimental to these communities. I also wanted to test the relationship between test scores and these public health concerns to identify policy opportunities for the state of New Jersey in order to close the gap in student achievement between Abbott Schools and Non-Abbott Schools. From my results it appears holding public health concerns constant there is no statistical signficance on increases in per pupil expenditures on standardized test scores for Abbott schools in New Jersey. None of the regressions show that per pupil expenditures showed statistical signficance for the 2016-2017 and 2017-2018 school years in either Math or English Language Arts test scores. This was as expected from prior literature. Ultimately, by the Supreme Court mandate state aid was increased dramatically in order to provide equal funding across all schools. With that said, there is not much of a spending difference between Abbott school and non Abbott schools. This did not account for the drastic difference in socioeconomic status. It appears my hunch for using public health data as a proxy for low socioeconomic status was incorrect as well.

// This research is admittedly very crude and riddled with limitations. Most notably, it's probably not the most appropriate to use county level data on health statistics when the primary unit of analysis is school districts. This made the data unwielding and difficult to use. The county level data does not accurate represent the variation in more specific communities found within each county. Additionally, I'm sure there are better regression models to use when studying the relationship between these variables. While the execution of this research does have its limitations these does seem to be a relationship between negative public health outcomes and student achivement outcomes. More robust research should be conducted to provide a better explanation of whether or not this relationship is casual. 
