******************************************************************
*Please refer to heading to find specific problem sets, thank you*
******************************************************************
//destring * ,ignore("*""**""N""Not Met""Met Target""Met Goal""Met Target†") replace 

//overall almost there, just pls add like 2 datasets from elsewhere, eg census has district level data; and can get more educ data
//from some other agency, say federal dept of educ or county level dept of educ etc

****// Data Formats and Conversion Problem Set #1 (STARTS LINE 20 - 79 THEN 197 - 278)//****
****// Manipulating Data Problem Set #2 (STARTS LINE 309 - 375 ORIGINAL MERGE FOR PS2 STARTS LINE 81)//**** 
****// Merging Problem Set #3 (STARTS LINE 90 - 193 THEN 379 - 394)//**** 

// Richard Connelly, Fall 2019 //
// Data Management//
// Professor: Dr. Adam Okulicz-Kozaryn//

// This research aims to examine the reimplementation of additional funding support for school districts after the 2011 decision in the NJ Supreme Court case Abbot v. Burke. These school districts are of extremely low socioeconomic status and thus have failing schools since school funding in New Jersey is tied to property value. Originally decided in 1985 these schools lost their additional funding in the wake of the recession, where the first cut in many state budgets were state aid to school districts. Once the economy began to recover Abbot v. Burke was reintroduced and such the original 31 school districts were regranted additional funding as a means to ensure the NJ consitutional right to a rigorous and thorough education.  

// My attmempt with this code is examine whether or not this extra funding since 2011 has impacted student achievement to any degree compared to those not recieving additioanl funding. I expect to find that it has not meaningfully impacted student achievement as previous studies have not shown much change. However to my knowledge since the 2011 court ruling little research has been done into whether or not these school districts have exhibited any change other than the original findings. Using student test scores, graduation rates, and possibly student attendence I will attempt to find any relationship between student achievement in Abbot School Districts compared to non-Abott School Districts.


*______________________________________________________________________________*

////////////////////////////////////////////////////////////////////////////////
// **Beginning of PS1** ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

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


use "https://github.com/RickConnelly/Data/blob/master/NJ_MATH_2017_18.dta?raw=true", clear //This is the raw data on NJ Math test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE //
//if possible pls give exact url for these data or at least full detailed description so i can find it online myself;same for others

drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores MATHValidScores2017_18
ren ParticipationPercent MATHParticPerc2017_18
ren DistrictPerformance MATHDisPerf2017_18
ren StatePerformance MATHStatePerf2017_18
ren AnnualTarget MATHAnnTar2017_18
ren MetTarget MATHMetTar2017_18
// This renames each variable to designate data specific to Math test scores and by year //

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_MATH_2017_18, replace //Saves the data be later pulled to merge with English Language Arts Scores //

use "https://github.com/RickConnelly/Data/blob/master/NJ_ELA_2017_18.dta?raw=true", clear //This is the raw data on NJ ELA test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE //

drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores ELAValidScores2017_18
ren ParticipationPercent ELAParticPerc2017_18
ren DistrictPerformance ELADisPerf2017_18
ren StatePerformance ELAStatePerf2017_18
ren AnnualTarget ELAAnnTar2017_18
ren MetTarget ELAMetTar2017_18
// This renames each variable to designate data specific to English Language Arts test scores and by year //

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_ELA_2017_18, replace // Saves the data be later pulled to merge with Math Scores //

merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using NJ_MATH_2017_18 // Merges Math Performance with ELA Performance Data for the 2017-2018 school year //
drop _merge // drops variable created by merge command //

save Education_Data_2017_2018, replace // This saves the merged ELA and MATH test scores for the school year 2017-2018 to be pulled later to merge with other data sets //


*______________________________________________________________________________*
* Similarly, in this section we're going to pull Math and English Language Arts Test scores from the 2016-2017 school year and merge them *

////////////////////////////////////////////////////////////////////////////////
// **Beginning of PS3** ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

use "https://github.com/RickConnelly/Data/blob/master/NJ_ELA_2016_17.dta?raw=true", clear //This is the raw data on NJ Math test scores from the 2016-2017 school year uploaded from Github that was pulled directly from the NJ DOE //

drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores ELAValidScores2016_17
ren ParticipationPercent ELAParticPerc2016_17
ren DistrictPerformance ELADisPerf2016_17
ren StatePerformance ELAStatePerf2016_17
ren AnnualTarget ELAAnnTar2016_17
ren MetTarget ELAMetTar2016_17
// This renames each variable to designate data specific to English Language Arts test scores and by year//

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_ELA_2016_17, replace // Saves the data be later pulled to merge with Math Scores //

use "https://github.com/RickConnelly/Data/blob/master/NJ_MATH_2016_17.dta?raw=true" //This is the raw data on NJ ELA test scores from the 2016-2017 school year uploaded from Github that was pulled directly from the NJ DOE //

drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores MATHValidScores2016_17
ren ParticipationPercent MATHParticPerc2016_17
ren DistrictPerformance MATHDisPerf2016_17
ren StatePerformance MATHStatePerf2016_17
ren AnnualTarget MATHAnnTar2016_17
ren MetTarget MATHMetTar2016_17
// This renames each variable to designate data specific to Math test scores and by year //

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_MATH_2016_17, replace // Saves the data be later pulled to merge with Math Scores //

merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using NJ_ELA_2016_17 // Merges Math Performance with ELA Performance Data for the 2016-2017 school year //
drop _merge // drops variable created by merge command //

save Education_Data_2016_2017, replace // This saves the merged ELA and MATH test scores for the school year 2017-2018 to be pulled later to merge with other data sets //


*______________________________________________________________________________*
* In this section we are going to merge both school years worth of test scores into one dataset * 


use Education_Data_2017_2018, clear

merge 1:1 CountyName DistrictName StudentGroup using Education_Data_2016_2017 // Merges Math Performance with ELA Performance Data from BOTH school years //
drop _merge // drops variable created by merge command //

save Education_Data_2_Years,replace
// Here we have the merged data set for both school years on standardized test scores in both math and english language arts // 


*______________________________________________________________________________*
* This section is where we are pulling data on Per Pupil Expenditures from the New Jersey Department of Education in the 2017-2018 and 2016-2017 school years, once we clean it we each of them we will save it to be merged with the rest of the data *


use "https://github.com/RickConnelly/Data/blob/master/Per_Pupil_Expenditures_2017_18.dta?raw=true", clear // Now we're going to pull the data for per pupil expenditures for each school district in New Jersey. We are only interested in State and Local aid, since Abbot v. Burke only impacts state aid funding //

ren StateLocal ExpPerPupil2017_18 // Renames the variable for proper identification //

drop if CountyName == "CHARTERS" 
drop if CountyName == "State"
// This drops unnecessary observations so the data merges properly //

save Per_Pupil_Expenditures_2017_18, replace // saves the data to be merged later //

use "https://github.com/RickConnelly/Data/blob/master/Per_Pupil_Expenditures_2016_17.dta?raw=true", clear // Now we're going to pull the data for per pupil expenditures for each school district in New Jersey. We are only interested in State and Local aid, since Abbot v. Burke only impacts state aid funding //

ren StateLocal ExpPerPupil2016_17
ren COUNTY_NAME CountyName
ren DISTRICT_NAME DistrictName
drop DISTRICT_CODE DistrictCode Federal Total  
// The data here was recorded differently in this year, a little extra code was needed to manipulate the data properly before merging //

drop if CountyName == "CHARTERS"
// This drops unnecessary observations so the data merges properly //

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
// Drops some unnecessary chater schools //


*______________________________________________________________________________*
* This section's code cleans the data in order for it to destring properly, and then save it. *


replace ELAValidScores2017_18="." if ELAValidScores2017_18=="*"
replace ELAValidScores2017_18="." if ELAValidScores2017_18=="N"
replace ELAValidScores2016_17="." if ELAValidScores2016_17=="*"
replace ELAValidScores2016_17="." if ELAValidScores2016_17=="N"
replace ELAParticPerc2017_18="." if ELAParticPerc2017_18=="*"
replace ELAParticPerc2017_18="." if ELAParticPerc2017_18=="N"
replace ELAParticPerc2016_17="." if ELAParticPerc2016_17=="*"
replace ELAParticPerc2016_17="." if ELAParticPerc2016_17=="N" 
replace ELADisPerf2017_18="." if ELADisPerf2017_18=="*"
replace ELADisPerf2017_18="." if ELADisPerf2017_18=="N" 
replace ELADisPerf2016_17="." if ELADisPerf2016_17=="*"
replace ELADisPerf2016_17="." if ELADisPerf2016_17=="N" 
replace ELAStatePerf2017_18="." if ELAStatePerf2017_18=="*"
replace ELAStatePerf2017_18="." if ELAStatePerf2017_18=="N" 
replace ELAStatePerf2016_17="." if ELAStatePerf2016_17=="*"
replace ELAStatePerf2016_17="." if ELAStatePerf2016_17=="N" 
replace ELAAnnTar2017_18="." if ELAAnnTar2017_18=="**" 
replace ELAAnnTar2017_18="." if ELAAnnTar2017_18=="N" 
replace ELAAnnTar2016_17="." if ELAAnnTar2016_17=="**" 
replace ELAAnnTar2016_17="." if ELAAnnTar2016_17=="N" 
replace ELAMetTar2017_18="." if ELAMetTar2017_18=="**" 
replace ELAMetTar2017_18="." if ELAMetTar2017_18=="N"
replace ELAMetTar2017_18="1" if ELAMetTar2017_18=="Met Goal"
replace ELAMetTar2017_18="1" if ELAMetTar2017_18=="Met Target†"
replace ELAMetTar2017_18="1" if ELAMetTar2017_18=="Met Target"
replace ELAMetTar2017_18="0" if ELAMetTar2017_18=="Not Met"  
replace ELAMetTar2016_17="." if ELAMetTar2016_17=="**" 
replace ELAMetTar2016_17="." if ELAMetTar2016_17=="N"
replace ELAMetTar2016_17="1" if ELAMetTar2016_17=="Met Goal"
replace ELAMetTar2016_17="1" if ELAMetTar2016_17=="Met Target†"
replace ELAMetTar2016_17="1" if ELAMetTar2016_17=="Met Target"
replace ELAMetTar2016_17="0" if ELAMetTar2016_17=="Not Met" 
//Cleans data on ELA standardized test scores for both the 2016-2017 school year and 2017-2018 school year //

replace MATHValidScores2017_18="." if MATHValidScores2017_18=="*"
replace MATHValidScores2017_18="." if MATHValidScores2017_18=="N" 
replace MATHValidScores2016_17="." if MATHValidScores2016_17=="*"
replace MATHValidScores2016_17="." if MATHValidScores2016_17=="N" 
replace MATHParticPerc2017_18="." if MATHParticPerc2017_18=="*"
replace MATHParticPerc2017_18="." if MATHParticPerc2017_18=="N"
replace MATHParticPerc2016_17="." if MATHParticPerc2016_17=="*"
replace MATHParticPerc2016_17="." if MATHParticPerc2016_17=="N"  
replace MATHDisPerf2017_18="." if MATHDisPerf2017_18=="*" 
replace MATHDisPerf2017_18="." if MATHDisPerf2017_18=="N" 
replace MATHDisPerf2016_17="." if MATHDisPerf2016_17=="*" 
replace MATHDisPerf2016_17="." if MATHDisPerf2016_17=="N" 
replace MATHStatePerf2017_18="." if MATHStatePerf2017_18=="*"
replace MATHStatePerf2017_18="." if MATHStatePerf2017_18=="N"
replace MATHStatePerf2016_17="." if MATHStatePerf2016_17=="*"
replace MATHStatePerf2016_17="." if MATHStatePerf2016_17=="N"   
replace MATHAnnTar2017_18="." if MATHAnnTar2017_18=="**"
replace MATHAnnTar2017_18="." if MATHAnnTar2017_18=="N" 
replace MATHAnnTar2016_17="." if MATHAnnTar2016_17=="**"
replace MATHAnnTar2016_17="." if MATHAnnTar2016_17=="N" 
replace MATHMetTar2017_18="." if MATHMetTar2017_18=="**"
replace MATHMetTar2017_18="." if MATHMetTar2017_18=="N"  
replace MATHMetTar2017_18="1" if MATHMetTar2017_18=="Met Goal" 
replace MATHMetTar2017_18="1" if MATHMetTar2017_18=="Met Target†" 
replace MATHMetTar2017_18="1" if MATHMetTar2017_18=="Met Target" 
replace MATHMetTar2017_18="0" if MATHMetTar2017_18=="Not Met" 
replace MATHMetTar2016_17="." if MATHMetTar2016_17=="**"
replace MATHMetTar2016_17="." if MATHMetTar2016_17=="N"  
replace MATHMetTar2016_17="1" if MATHMetTar2016_17=="Met Goal" 
replace MATHMetTar2016_17="1" if MATHMetTar2016_17=="Met Target†" 
replace MATHMetTar2016_17="1" if MATHMetTar2016_17=="Met Target" 
replace MATHMetTar2016_17="0" if MATHMetTar2016_17=="Not Met" 
//Cleans data on MATH standardized test scores for both the 2016-2017 school year and 2017-2018 school year //

// I mannually cleaned each varialbe that had missing values in the form of "*" , "**" , and ".999" //

// "*" == that data was available for too few students to report the given information, or the data represents a small percentage of students. There may be some additional cases where the data was kept private because the data could be used to potentially identify individual students. //

// "**" ==  data was not available for the minimum 20 students, the required number for a student group to be included in New Jersey’s Every Student Succeeds Act ESS accountability system. //

// ".999" == indicates that no data was available to report. This happens when there are no students enrolled in a particular student group or if no data was submitted by the district. //

destring * , replace // Destrings Varibles //

save Education_Data_TOTAL, replace // Saves the data under one name //


*______________________________________________________________________________*
* This section shows some descriptive statistics to better familiarize ourselves with the data. *


sum ELADisPerf2017_18,d // This statstic shows that on average at the **District Level** 56.9% of students met or exceeded expectations in their performance on ELA assessments. Students in the upper quartile met or exceeded expectations at 71.9% while the lower quartile shows that 41.2% met or exceeded expectations with a SD of about 20.5%. The data is very slightly skewed to the left. // 

sum ELAStatePerf2017_18,d // This statistic shows that on average at the **State Level** 52.7% of students met or exceeded expectations in their performance on ELA assessments. This is a lower average of assessment expectations met or exceeded than when measuring at the district level by 4.2%. This trend continues in the upper quartile however at the state level a higer proportion of student met or exceeded assessment expectations at the lower quartile. //

sum MATHDisPerf2017_18,d // On average at the district level 44.8% of students met or exceeded expectations on their performance on math assessments. At the upper and lower quartile students met or exceeded expectations at 30.7% and 61.1% respectively. The data is slightly skewed to the right. //

sum MATHStatePerf2017_18, d // On average 43.9% of students met or exceed expectations on their performance on math assessments at the state level. This is only slightly less than the average at the district level. Overall, at the upper quartile 50.5% of students met or exceeded expectations and in the lower quartile only 23.7% met or exceeded expectations. //


*______________________________________________________________________________*
* This section exports the data in several different formats, and closes the log then clears the data. *


export excel using Education_Data_TOTAL,replace // Exports file into an Excel document //
export delimited using Education_Data_TOTAL,replace // Exports file into delimited text //
outfile using Education_Data_TOTAL,replace // Exports file into a debased file //
// log close // Closes Log //
clear //clears Stata //


*______________________________________________________________________________*

////////////////////////////////////////////////////////////////////////////////
// **Beginning of PS2** ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

use Education_Data_TOTAL, clear // Loads Data //

encode StudentGroup, gen(StudentGroup2) // Generates variable "StudentGroup2" as same variable but with numeric values associated with each category //
encode DistrictName, gen(DistrictName2) // Generates variable "DistrictName2" as same variable but with numeric values associated with each category //
encode CountyName, gen(CountyName2) // Generates variable "CountyName2" as same variable but with numeric values associated with each category //

recode DistrictName2 (9=1) (49=1) (55=1) (62=1) (76=1) (115=1) (126=1) (159=1) (166=1) (193=1) (208=1) (219=1) (224=1) (225=1) (261=1) (303=1) (330=1) (333=1) (337=1) (374=1) (378=1) (380=1) (385=1) (386=1) (392=1) (393=1) (436=1) (487=1) (490=1) (501=1) (526=1) (nonm = 0), gen(Abbot_SchoolDist)
// recodes DistrictName2 to identify Abbot School as 1 and NON-Abbot School as 0 then generates new var "Abbot_SchoolDist" to show this //

drop CountyName DistrictCode DistrictName StudentGroup
order CountyCode CountyName2 DistrictName2 Abbot_SchoolDist StudentGroup2 ELAValidScores2017_18 ELAParticPerc2017_18 ELADisPerf2017_18 ELAStatePerf2017_18 ELAAnnTar2017_18 ELAMetTar2017_18 MATHValidScores2017_18 MATHParticPerc2017_18 MATHDisPerf2017_18 MATHStatePerf2017_18 MATHAnnTar2017_18 MATHMetTar2017_18 ExpPerPupil2017_18 MATHValidScores2016_17 MATHParticPerc2016_17 MATHDisPerf2016_17 MATHStatePerf2016_17 MATHAnnTar2016_17 MATHMetTar2016_17 ELAValidScores2016_17 ELAParticPerc2016_17 ELADisPerf2016_17 ELAStatePerf2016_17 ELAAnnTar2016_17 ELAMetTar2016_17 //orders data

save Education_Data_TOTAL_2, replace // Saves manipulated Data //


*______________________________________________________________________________*
* The purpose of this code is select a random sample to run descriptive statistics on. *


use Education_Data_TOTAL_2, clear // Tells Stata to use manipulated Data // 

keep ELADisPerf2017_18 MATHDisPerf2017_18 DistrictName2 StudentGroup2 Abbot_SchoolDist //Tells Stata which varibles to keep //
keep if StudentGroup2 == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
order DistrictName2 StudentGroup2 ELADisPerf2017_18 MATHDisPerf2017_18 Abbot_SchoolDist // Orders Data in an easily digestable manner //

sort DistrictName2 // Sorts DistrictName2 Alphabetically //
set seed 123456789 // Sets randomness to a constant //
sample 50, count // takes a random sample of 50 observations //

collapse ELADisPerf2017_18 MATHDisPerf2017_18 Abbot_SchoolD,by(DistrictName2) 

bys DistrictName2: sum *DisPerf2017_18 // This provides basic statistics on a random sample of school districts in New Jersey //


*______________________________________________________________________________*
*The purpose of this code is compare student achievement between Abbot Schools and Non-Abbot Schools in the 2017-2018 school year.*


use Education_Data_TOTAL_2, clear // Reloads manipulated data //

keep ELADisPerf2017_18 MATHDisPerf2017_18 DistrictName2 StudentGroup2 Abbot_SchoolDist // Tells Stata keep these specific variables //
keep if StudentGroup2 == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
order DistrictName2 StudentGroup2 ELADisPerf2017_18 MATHDisPerf2017_18 Abbot_SchoolDist
// Orders Data in an easily digestable manner //

collapse  ELADisPerf2017_18 MATHDisPerf2017_18 Abbot_SchoolD,by(DistrictName2) // This collpases all demographics in each school district into the average standardized test scores for but ELA and Math with an Abbot school designation associated with each district shown in "Abbot_SchoolD".

bys Abbot_SchoolD: sum *DisPerf2017_18 // This sorts each school district into an Abbot School or Non-Abbot school, then tabulates the percentage of students who met or exceeded expectations to provide descriptive statistics on student achievement comparing the two types of school districts. // 

ta DistrictName2 if MATHDisPerf2017_18<11 // This details an investigation of a possible outlier on the lowest percentile of students who met or exceeded expectations in math testing (only 11% of students met or exceed expectations) from a non-Abbot school district. The school district responsbile for such low scores is the Trenton City School District. It's likely the same factors contributing to poor test results as Abbot schools are contributing to the poor results of the Trenton City School district. More research is required to determine if this is true. //


*______________________________________________________________________________*
*This sections shows the district wide test scores for each demographic throughout each Abbot School. *


use Education_Data_TOTAL_2, clear // Reloads manipulated data //

keep DistrictName2 StudentGroup2 MATHDisPerf2016_17 MATHDisPerf2017_18 ELADisPerf2016_17 ELADisPerf2017_18 StudentGroup2 Abbot_SchoolDist // Tells Stata keep these specific variables //

keep if Abbot_SchoolDist == 1 // Drops all Non-Abbot Schools
drop Abbot_SchoolDist // Drops the numeric repsentation for an Abbot School //

collapse ELADisPerf2017_18 MATHDisPerf2017_18 ELADisPerf2016_17 MATHDisPerf2016_17,by(StudentGroup2) // This shows how each demographic scored on standardized tests in Abbot Schools. On average, Black or African American students score lower on both math and reading than White students. Female students score signficantly higher than male students on the ELA portion of the test while male students score higher on the math portion than females. Interestingly, the demographic that scored the lowest are migrant students. Initally I had wondered if the reason behind this was that the tests were only administered in English. However, further research shows PARCC testing is adminstered in 10 languages suggesting the test was adminstered in the migrant student's native language. 

// **Continuation of PS3** ////////////////////////////////////////////////////////

reshape long ELADisPerf MATHDisPerf, i(StudentGroup2) j(Year) string // Reshapes data to long format  //


*______________________________________________________________________________*
*This section shows the changes in aid over the two year period and reshapes the data. *


use Education_Data_TOTAL_2, clear // Reloads manipulated data //

keep ExpPerPupil2016_17 ExpPerPupil2017_18 DistrictName2 StudentGroup2 Abbot_SchoolDist // Tells Stata keep these specific variables //
keep if StudentGroup2 == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
keep if Abbot_SchoolDist == 1 // This tells Stata to keep only Abbot Schools

drop Abbot_SchoolDist // Drops unnecessary variable //
reshape long ExpPerPupil, i(DistrictName2) j(Year) string //Reshapes data to long format //
order DistrictName2 StudentGroup2 Year ExpPerPupil // Orders the data //
