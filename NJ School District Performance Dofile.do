*______________________________________________________________________________*

// Data Formats and Conversion Problem Set #1//
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

mkdir "C:\Users\uiser\Desktop/Stata_data/" //Creates a working directory to a public computer CHANGE BEFORE EXECUTING DOFILE // 

cd "C:\Users\uiser\Desktop/Stata_data/" // Sets the working directory to aforementioned pathway CHANGE BEFORE EXECUTING DOFILE// 

log using log1, replace // Opens log //

*______________________________________________________________________________*

use "https://github.com/RickConnelly/Data-Management/blob/master/NJSchoolDistrictPerformanceELA_Math_Clean.dta?raw=true", clear
destring, replace
destring LALValidScores, replace force
destring LALParticipationPercent, replace force
destring LALDistrictPerformance, replace force
destring LALStatePerformance, replace force
destring LALProfRateFederalAccountability, replace force
destring LALAnnualTarget, replace force
destring LALMetTarget, replace force
destring MATHValidScores, replace force
destring MATHParticipationPercent, replace force
destring MATHDistrictPerformance, replace force
destring MATHStatePerformance, replace force
destring MATHProfRateFederalAccountabilit, replace force
destring MATHAnnualTarget, replace force
destring MATHMetTarget, replace force
 //pulls data set from github and destrings varialbes //

save Education_Data, replace // Saves the data under one name //

mvdecode LALDistrictPerformance, mv(.999)
mvdecode LALStatePerformance, mv(.999)
mvdecode MATHDistrictPerformance, mv(.999)
mvdecode MATHStatePerformance, mv(.999)

// The following commands show basic descriptive statistics //
sum LALDistrictPerformance,d
sum LALStatePerformance,d
sum MATHDistrictPerformance,d 
sum MATHStatePerformance, d

*______________________________________________________________________________*

export excel using Education_Data // Exports file into an Excel document //

export delimited using Education_Data // Exports file into delimited text //

outfile using Education_Data // Exports file into a debased file //

*______________________________________________________________________________*

log close 
