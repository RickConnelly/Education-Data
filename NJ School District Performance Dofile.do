******************************************************************
*Please refer to heading to find specific problem sets, thank you*
******************************************************************

**** // Data Formats and Conversion Problem Set #1// ****
****// Manipulating Data Problem Set #2 // (STARTS AT 27 - 69 THEN AT 147 - 209) ****
// Richard Connelly, Fall 2019 //
// Data Management//
// Professor: Dr. Adam Okulicz-Kozaryn//

// This research aims to examine the reimplementation of additional funding support for school districts after the 2011 decision in the NJ Supreme Court case Abbot v. Burke. These school districts are of extremely low socioeconomic status and thus have failing schools since school funding in New Jersey is tied to property value. Originally decided in 1985 these schools lost their additional funding in the wake of the recession, where the first cut in many state budgets were state aid to school districts. Once the economy began to recover Abbot v. Burke was reintroduced and such the original 31 school districts were regranted additional funding as a means to ensure the NJ consitutional right to a rigorous and thorough education.  

// My attmempt with this code is examine whether or not this extra funding since 2011 has impacted student achievement to any degree compared to those not recieving additioanl funding. I expect to find that it has not meaningfully impacted student achievement as previous studies have not shown much change. However to my knowledge since the 2011 court ruling little research has been done into whether or not these school districts have exhibited any change other than the original findings. Using student test scores, graduation rates, and possibly student attendence I will attempt to find any relationship between student achievement in Abbot School Districts compared to non-Abott School Districts.

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

use "https://github.com/RickConnelly/Data/blob/master/NJ_MATH_2017_18.dta?raw=true", clear //This is the raw data on NJ Math test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE //

drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores MATHValidScores
ren ParticipationPercent MATHParticipationPercent
ren DistrictPerformance MATHDistrictPerformance
ren StatePerformance MATHStatePerformance
ren AnnualTarget MATHAnnualTarget
ren MetTarget MATHMetTarget
// This renames each variable to designate data specific to Math test scores//

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_MATH_2017_18, replace //Saves the data be later pulled to merge with English Language Arts Scores //

use "https://github.com/RickConnelly/Data/blob/master/NJ_ELA_2017_18.dta?raw=true", clear //This is the raw data on NJ ELA test scores from the 2017-2018 school year uploaded from Github that was pulled directly from the NJ DOE //


drop Subject ProfRateFederalAccountability //Drops unneeded variables //

ren ValidScores ELAValidScores
ren ParticipationPercent ELAParticipationPercent
ren DistrictPerformance ELADistrictPerformance
ren StatePerformance ELAStatePerformance
ren AnnualTarget ELAAnnualTarget
ren MetTarget ELAMetTarget
// This renames each variable to designate data specific to English Language Arts test scores//

drop if CountyName == "CHARTERS"
drop if CountyName == "State"
// The purpose of this research is about Abbot Public School student achievement compared to NonAbbot Public School student achievement, to that end I'm dropping observations on Charter Schools and overall State statistics // 

save NJ_ELA_2017_18, replace // Saves the data be later pulled to merge with Math Scores //

// This pulls data on NJ School District Student Performance from the NJ DOE. More specifically this data is about student performance in English Language Arts/Literacy (ELA) and Mathematics as measured by the Partnership for Assessment of Readiness for College and Careers assessment, also known as the PARCC test. The data displays PARCC results overall, by grade or test, and by school year. //


merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using NJ_MATH_2017_18 // Merges Math Performance with ELA Performance Data for the 2018-2019 school year //

drop _merge // drops variable created by merge command //

replace ELAValidScores="." if ELAValidScores=="*"
replace ELAValidScores="." if ELAValidScores=="N"
replace ELAParticipationPercent="." if ELAParticipationPercent=="*"
replace ELAParticipationPercent="." if ELAParticipationPercent=="N"  
replace ELADistrictPerformance="." if ELADistrictPerformance=="*"
replace ELADistrictPerformance="." if ELADistrictPerformance=="N"  
replace ELAStatePerformance="." if ELAStatePerformance=="*"
replace ELAStatePerformance="." if ELAStatePerformance=="N"   
replace ELAAnnualTarget="." if ELAAnnualTarget=="**" 
replace ELAAnnualTarget="." if ELAAnnualTarget=="N" 
replace ELAMetTarget="." if ELAMetTarget=="**" 
replace ELAMetTarget="." if ELAMetTarget=="N"
replace ELAMetTarget="1" if ELAMetTarget=="Met Goal"
replace ELAMetTarget="1" if ELAMetTarget=="Met Target†"
replace ELAMetTarget="1" if ELAMetTarget=="Met Target"
replace ELAMetTarget="0" if ELAMetTarget=="Not Met"  
replace MATHValidScores="." if MATHValidScores=="*"
replace MATHValidScores="." if MATHValidScores=="N" 
replace MATHParticipationPercent="." if MATHParticipationPercent=="*"
replace MATHParticipationPercent="." if MATHParticipationPercent=="N"  
replace MATHDistrictPerformance="." if MATHDistrictPerformance=="*" 
replace MATHDistrictPerformance="." if MATHDistrictPerformance=="N" 
replace MATHStatePerformance="." if MATHStatePerformance=="*"
replace MATHStatePerformance="." if MATHStatePerformance=="N"   
replace MATHAnnualTarget="." if MATHAnnualTarget=="**"
replace MATHAnnualTarget="." if MATHAnnualTarget=="N"  
replace MATHMetTarget="." if MATHMetTarget=="**"
replace MATHMetTarget="." if MATHMetTarget=="N"  
replace MATHMetTarget="1" if MATHMetTarget=="Met Goal" 
replace MATHMetTarget="1" if MATHMetTarget=="Met Target†" 
replace MATHMetTarget="1" if MATHMetTarget=="Met Target" 
replace MATHMetTarget="0" if MATHMetTarget=="Not Met" 


// I mannually cleaned each varialbe that had missing values in the form of "*" , "**" , and ".999" //

// "*" == that data was available for too few students to report the given information, or the data represents a small percentage of students. There may be some additional cases where the data was kept private because the data could be used to potentially identify individual students. //

// "**" ==  data was not available for the minimum 20 students, the required number for a student group to be included in New Jersey’s Every Student Succeeds Act ESS accountability system. //

// ".999" == indicates that no data was available to report. This happens when there are no students enrolled in a particular student group or if no data was submitted by the district. //

*______________________________________________________________________________*

destring * , replace // Destrings Varibles //

save Education_Data, replace // Saves the data under one name //

*______________________________________________________________________________*

// The following commands show basic descriptive statistics //

sum ELADistrictPerformance,d // This statstic shows that on average at the **District Level** 56.9% of students met or exceeded expectations in their performance on ELA assessments. Students in the upper quartile met or exceeded expectations at 71.9% while the lower quartile shows that 41.2% met or exceeded expectations with a SD of about 20.5%. The data is very slightly skewed to the left. // 

sum ELAStatePerformance,d // This statistic shows that on average at the **State Level** 52.7% of students met or exceeded expectations in their performance on ELA assessments. This is a lower average of assessment expectations met or exceeded than when measuring at the district level by 4.2%. This trend continues in the upper quartile however at the state level a higer proportion of student met or exceeded assessment expectations at the lower quartile. //

sum MATHDistrictPerformance,d // On average at the district level 44.8% of students met or exceeded expectations on their performance on math assessments. At the upper and lower quartile students met or exceeded expectations at 30.7% and 61.1% respectively. The data is slightly skewed to the right. //

sum MATHStatePerformance, d // On average 43.9% of students met or exceed expectations on their performance on math assessments at the state level. This is only slightly less than the average at the district level. Overall, at the upper quartile 50.5% of students met or exceeded expectations and in the lower quartile only 23.7% met or exceeded expectations. //

*______________________________________________________________________________*

export excel using Education_Data,replace // Exports file into an Excel document //

export delimited using Education_Data,replace // Exports file into delimited text //

outfile using Education_Data,replace // Exports file into a debased file //

*______________________________________________________________________________*

log close // Closes Log //

clear //clears Stata //

*______________________________________________________________________________*

//////////////////////////
// **Beginning of PS2** //
//////////////////////////

use Education_Data, clear // Loads Data //

encode StudentGroup, generate(StudentGroup2) // Generates variable "StudentGroup2" as same variable but with numeric values associated with each category //

encode DistrictName, generate(DistrictName2) // Generates variable "DistrictName2" as same variable but with numeric values associated with each category //

recode DistrictName2 (9=1) (49=1) (55=1) (62=1) (76=1) (115=1) (126=1) (159=1) (166=1) (193=1) (208=1) (219=1) (224=1) (225=1) (261=1) (303=1) (330=1) (333=1) (337=1) (374=1) (378=1) (380=1) (385=1) (386=1) (392=1) (393=1) (436=1) (487=1) (490=1) (501=1) (526=1) (nonm = 0), gen(Abbot_SchoolDist)
// recodes DistrictName2 to identify Abbot School as 1 and NON-Abbot School as 0 then generates new var "Abbot_SchoolDist" to show this //

save Education_2, replace // Saves manipulated Data //

*______________________________________________________________________________*

// The purpose of this code is select a random sample to run descriptive statistics on //

use Education_2, clear // Tells Stata to use manipulated Data // 

keep ELADistrictPerformance MATHDistrictPerformance DistrictName2 StudentGroup2 Abbot_SchoolDist //Tells Stata which varibles to keep //

keep if StudentGroup2 == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
order DistrictName2 StudentGroup2 ELADistrictPerformance MATHDistrictPerformance Abbot_SchoolDist // Orders Data in an easily digestable manner //

sort DistrictName2 // Sorts DistrictName2 Alphabetically //
set seed 123456789 // Sets randomness to a constant //
sample 50, count // takes a random sample of 50 observations //

collapse ELADistrictPerformance MATHDistrictPerformance Abbot_SchoolD,by(DistrictName2) 

bys DistrictName2: sum *DistrictPerformance // This provides basic statistics on a random sample of school districts in New Jersey //

*______________________________________________________________________________*

// The purpose of this code is compare student achievement between Abbot Schools and Non-Abbot Schools in the 2018-2019 school year. 

use Education_2, clear // Reloads manipulated data //

keep ELADistrictPerformance MATHDistrictPerformance DistrictName2 StudentGroup2 Abbot_SchoolDist // Tells Stata keep these specific variables //

keep if StudentGroup2 == 4 // This keeps only district wide scores, and removes demographic groups that would have miscalcuated results //
order DistrictName2 StudentGroup2 ELADistrictPerformance MATHDistrictPerformance Abbot_SchoolDist
// Orders Data in an easily digestable manner //

collapse  ELADistrictPerformance MATHDistrictPerformance Abbot_SchoolD,by(DistrictName2) // This collpases all demographics in each school district into the average standardized test scores for but ELA and Math with an Abbot school designation associated with each district shown in "Abbot_SchoolD".

bys Abbot_SchoolD: sum *DistrictPerformance // This sorts each school district into an Abbot School or Non-Abbot school, then tabulates the percentage of students who met or exceeded expectations to provide descriptive statistics on student achievement comparing the two types of school districts. // 

ta DistrictName2 if MATHDistrictPerformance<11 // This details an investigation of a possible outlier on the lowest percentile of students who met or exceeded expectations in math testing (only 11% of students met or exceed expectations) from a non-Abbot school district. The school district responsbile for such low scores is the Trenton City School District. It's likely the same factors contributing to poor test results as Abbot schools are contributing to the poor results of the Trenton City School district. More research is required to determine if this is true. //

*______________________________________________________________________________*

use Education_2, clear // Reloads manipulated data //

keep ELADistrictPerformance MATHDistrictPerformance DistrictName2 StudentGroup2 Abbot_SchoolDist // Tells Stata keep these specific variables //

keep if Abbot_SchoolDist == 1 // Drops all Non-Abbot Schools
order DistrictName2 StudentGroup2 ELADistrictPerformance MATHDistrictPerformance Abbot_SchoolDist // Orders data easily digestable manner //
drop Abbot_SchoolDist // Drops the numeric repsentation for an Abbot School //

collapse ELADistrictPerformance MATHDistrictPerformance,by(StudentGroup2) // This shows how each demographic scored on standardized tests in Abbot Schools. On average, Black or African American students score lower on both math and reading than White students. Female students score signficantly higher than male students on the ELA portion of the test while male students score higher on the math portion than females. Interestingly, the demographic that scored the lowest are migrant students. Initally I had wondered if the reason behind this was that the tests were only administered in English. However, further research shows PARCC testing is adminstered in 10 languages suggesting the test was adminstered in the migrant student's native language. 

