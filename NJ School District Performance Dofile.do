*______________________________________________________________________________*

// Data Formats and Conversion Problem Set #1// (STARTS LINE 11)
// Manipulating Data Problem Set #2 // (STARTS LINE 110)
// Richard Connelly, Fall 2019 //
// Data Management//
// Professor: Dr. Adam Okulicz-Kozaryn//

*______________________________________________________________________________*

clear // clears any prior data that could have already been loaded into Stata //
set matsize 800 // Sets maximum number of variables in model to 800 //   
vers 15 //Sets the software version to Stata 14 //
set more off // tells Stata to not pause and show -more message- // 
cap log close // Allows the .dofile to continue despite possible error messages //

*______________________________________________________________________________*

mkdir "C:\Users\rjc361\Desktop/Stata_data/" //Creates a working directory to a public computer CHANGE BEFORE EXECUTING DOFILE // 

cd "C:\Users\rjc361\Desktop/Stata_data/" // Sets the working directory to aforementioned pathway CHANGE BEFORE EXECUTING DOFILE// 

log using log1, replace // Opens log //

*______________________________________________________________________________*

use "https://github.com/RickConnelly/Data-Management/blob/master/ELA%20PERFORMANCE.dta?raw=true", clear // This pulls data on NJ School District Student Performance from the NJ DOE. More specifically this data is about student performance in English Language Arts/Literacy (ELA) and Mathematics as measured by the Partnership for Assessment of Readiness for College and Careers assessment, also known as the PARCC test. The data displays PARCC results overall, by grade or test, and by school year. //

merge 1:1 CountyCode CountyName DistrictCode DistrictName StudentGroup using "https://github.com/RickConnelly/Data-Management/blob/master/MATH%20PERFORMANCE.dta?raw=true" // Merges Math Performance with ELA Performance Data //
drop _merge // drops variable created by merge command //

replace ELAValidScores="." if ELAValidScores=="*"
replace ELAValidScores="." if ELAValidScores=="N"
replace ELAParticipationPercent="." if ELAParticipationPercent=="*"
replace ELAParticipationPercent="." if ELAParticipationPercent=="N"  
replace ELADistrictPerformance="." if ELADistrictPerformance=="*"
replace ELADistrictPerformance="." if ELADistrictPerformance=="N"  
replace ELAStatePerformance="." if ELAStatePerformance=="*"
replace ELAStatePerformance="." if ELAStatePerformance=="N"  
replace ELAProfRateFederalAccountability="." if ELAProfRateFederalAccountability=="*"
replace ELAProfRateFederalAccountability="." if ELAProfRateFederalAccountability=="N"  
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
replace MATHProfRateFederalAccountabilit="." if MATHProfRateFederalAccountabilit=="*"
replace MATHProfRateFederalAccountabilit="." if MATHProfRateFederalAccountabilit=="N"  
replace MATHAnnualTarget="." if MATHAnnualTarget=="**"
replace MATHAnnualTarget="." if MATHAnnualTarget=="N"  
replace MATHMetTarget="." if MATHMetTarget=="**"
replace MATHMetTarget="." if MATHMetTarget=="N"  
replace MATHMetTarget="1" if MATHMetTarget=="Met Goal" 
replace MATHMetTarget="1" if MATHMetTarget=="Met Target†" 
replace MATHMetTarget="1" if MATHMetTarget=="Met Target" 
replace MATHMetTarget="0" if MATHMetTarget=="Not Met" 


// ^^^Since I don't know more elegant code to clean the data, I mannually cleaned each varialbe that had missing values in the form of "*" , "**" , and ".999" **ASK HOW TO SIMPLIFY //

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

export excel using Education_Data // Exports file into an Excel document //

export delimited using Education_Data // Exports file into delimited text //

outfile using Education_Data // Exports file into a debased file //

*______________________________________________________________________________*

log close // Closes Log //

*______________________________________________________________________________*

//////////////////////////
// **Beginning of PS2** //
//////////////////////////

******** LOADED DATA SET AND RAN CODE FROM LINE 27 TO LINE 70 ********

set seed 123456789 // Sets randomness to a constant //
sample 50, count // takes a random sample of 50 observations //
d // gives a basic description of the sample //
save Education_Data2, replace // Saves the data under one name //

use Education_Data2, replace

*______________________________________________________________________________*

drop ELAProfRateFederalAccountability // Drops unwanted variables // 
drop MATHProfRateFederalAccountabilit // Drops unwanted varialbes //

*______________________________________________________________________________*

encode StudentGroup, generate(StudentGroup2) // Generates variable "StudentGroup2" as same variable but with numeric values associated with each category //
drop StudentGroup // Drops old StudentGroup variable that was stored as a string //


recode StudentGroup2 (1=1) (2/19=0), gen(Native_American) // Generates new varialbe "Native_American" where 1 = Yes and 0 = No
recode StudentGroup2 (10=1) (7=0)(1/6=2) (8/9=2) (11/19=2), gen(Gender) // Generates new variable "Gender" 1 = Male, 0 = Female, and 2 = Other Category


gen group=_n // Generates blank variable //

bys StudentGroup2: egen SortedStudentGroup2=count(group) //Sorts StudentGroup by category //
drop group // Ask how to make this not have to happen OR why it is happening //
drop SortedStudentGroup2 // Ask how to make this not have to happen OR why it is happening //

gen group=_n // Generates blank variable //

bys CountyName: egen SortedCountyName=count(group)
drop group // Ask how to make this not have to happen OR why it is happening //
drop SortedCountyName // Ask how to make this not have to happen OR why it is happening //


bys StudentGroup2: egen ELA_Score_byGroup=mean(ELAStatePerformance) // This didn't show me anything of importance //