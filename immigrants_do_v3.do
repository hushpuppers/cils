/*	Research: Effects of parental knowledge of
		English on immigrant children's outcomes
	
	Data set:	ICPSR 20520
	Children of Immigrants Longitudinal Study,
		1991-2006
	
	Alberto Ortega, Tyler Ludwig
*/

* Load data into memory; change this
use "\\Client\C$\College Documents\Research\Children of Immigrants\20520-0001-Data.dta", clear

* Creating dummy for gender
gen female = 0 //Doing it this way is fine, no missing values.
replace female = 1 if V18 == 2
label var female "1 == respondent is female"
label define femalel 0 "male" 1 "female"
label values female femalel

* Copying age, time in US at wave 1 for ease of use
clonevar age1 = V19
label var age1 "Age, 1st wave"

clonevar usa_time = V22
label var usa_time "Length of stay in US, wave 1"

* Creating dummy for time in US at wave 1: 1 for whole life
clonevar usa_dummy = V22
replace usa_dummy = 1 if V22 == 1
replace usa_dummy = 0 if V22 == 2 | V22 == 3 | V22 == 4
label var usa_dummy "1 if resp. in US entire life, wave 1"
label define usa_dummyl 0 "Not all my life" 1 "All my life"
label values usa_dummy usa_dummyl

* Creating a variable for respondent English ability; essentially an
* unscaled version of C4.  One other difference, however, is that C4 
* includes people who are not scored in all 4 categories, but less 
* (1.67 or 2.33) as possible values wouldnt occur otherwise). The 
* difference is only a couple observations (22 missing vs. 4 missing)

* Update: copy of scaled variable.
gen resp_eng_score = V24 + V25 + V26 + V27
label var resp_eng_score "Combined resp. score of speak/understand/read/write English. 4-16"

gen resp_eng_score_scaled = C4
label var resp_eng_score_scaled "Combined resp. score of speak/understand/read/write English. Scaled 1-4"

* Creating a variable for respondent foreign language ability;
* essentially same thing as before, not quite the same as C6
* However, there are 456 missing values vs 32 in C6.
gen resp_foreign_score = V51 + V52 + V53 + V54
label var resp_foreign_score "Combined resp. score of speak/understand/read/write a non-English language. 4-16"

* Copying variables for mother + father highest education, wave 1
* Could rescale or make into dummies, they run 1-6 (elem. vs college grad)
clonevar father_edu = V36
label var father_edu "Father's highest education level, wave 1"
clonevar mother_edu = V41
label var mother_edu "Mother's highest education level, wave 1"

* Update: mother and father education, rescaled into years
* Chose 17 for college grad or more, could also be 16
clonevar father_edu_yrs = father_edu
replace father_edu_yrs = 3 if father_edu == 1
replace father_edu_yrs = 7 if father_edu == 2
replace father_edu_yrs = 10 if father_edu == 3
replace father_edu_yrs = 12 if father_edu == 4
replace father_edu_yrs = 14 if father_edu == 5
replace father_edu_yrs = 17 if father_edu == 6
label var father_edu "Father's highest education level, in years, wave 1"
label define father_edu_yrsl 3 "Elementary school or less" 7 "Middle school or less" 10 "Some high school" 12 "High school graduate" 14 "Some college/university" 17 "College graduate or more"
label values father_edu father_edu_yrsl

clonevar mother_edu_yrs = mother_edu
replace mother_edu_yrs = 3 if mother_edu == 1
replace mother_edu_yrs = 7 if mother_edu == 2
replace mother_edu_yrs = 10 if mother_edu == 3
replace mother_edu_yrs = 12 if mother_edu == 4
replace mother_edu_yrs = 14 if mother_edu == 5
replace mother_edu_yrs = 17 if mother_edu == 6
label var mother_edu "Mother's highest education level, in years, wave 1"
label define mother_edu_yrsl 3 "Elementary school or less" 7 "Middle school or less" 10 "Some high school" 12 "High school graduate" 14 "Some college/university" 17 "College graduate or more"
label values mother_edu mother_edu_yrsl

* Creating dummy for use of foreign language in home
clonevar home_foreign_use = V57
replace home_foreign_use = 1 if V57 == 3 | V57 == 4
replace home_foreign_use = 0 if V57 == 1 | V57 == 2
label var home_foreign_use "1 if people in home use non_Eng lang often/always, wave 1"
label define home_foreign_usel 0 "Seldom/Time-to-time" 1 "Often/Always"
label values home_foreign_use home_foreign_usel

* Creating dummy for use of foreign language with parents
clonevar resp_foreign_parents = V58
replace resp_foreign_parents = 1 if V58 > 0 & V58 <28 //English is already coded 0
label var resp_foreign_parents "1 if uses non-English when speaking to parents, wave 1"
label define resp_foreign_parentsl 0 "English with parents" 1 "Other language with parents"
label values resp_foreign_parents resp_foreign_parentsl

* Creating dummy for respondent language preference
clonevar resp_pref = V59
replace resp_pref = 1 if V59 > 0 & V59 <28 //English coded 0
label var resp_pref "1 if resp. prefers speaking in another language, wave 1"
label define resp_prefl 0 "Prefers English" 1 "Prefers another language"
label values resp_pref resp_prefl

* Combining previous two dummies to see those that prefer English but
* speak with their parents in another language
gen diff_lang_parents = resp_foreign_parents*resp_pref
replace diff_lang_parents = 1 if resp_foreign_parents == 1 & resp_pref == 0 //resp prefers English but uses another lang with parents
replace diff_lang_parents = 0 if resp_foreign_parents == 1 & resp_pref == 1 //both prefer another language; could be population of interest with another dummy
label var diff_lang_parents "1 if resp. pref. English but speaks with parents in foreign lang, wave 1"
label define diff_lang_parentsl 0 "Not different, or resp. pref. foreign lang but speaks with parents in Eng" 1 "Respondent prefers Eng but speaks with parents in foreign lang"
label values diff_lang_parents diff_lang_parentsl

* Outcome variables: percentile achievement on Stanford Achievement test
* in reading and math, as well as GPA
clonevar math_cent = V132
clonevar read_cent = V134
clonevar gpa = V139
label var math_cent "Stanford Math Achievement percentile, wave 1"
label var read_cent "Stanford Reading Achievement percentile, wave 1"
label var gpa "Grade point average, wave 1"

* Copying dummy for attending a minority school
clonevar minority_school = V144
label var minority_school "1 if 60% or more Black/Hispanic"

* Control variable for SES
clonevar ses = V148

* Dummy for inclusion in wave 2; not everyone returned from wave 1
clonevar wave2 = V203

* Creating another dummy for time in US as before; may not be useful
clonevar usa_dummy2 = V222
replace usa_dummy = 1 if V222 == 1
replace usa_dummy2 = 0 if V222 == 2 | V222 == 3 | V222 == 4
label var usa_dummy2 "1 if resp. in US entire life, wave 2"
label define usa_dummy2l 0 "Not all my life" 1 "All my life"
label values usa_dummy2 usa_dummy2l

* Creating a variable for resp. English ability at wave 2. Same as before.
gen resp_eng_score2 = V224 + V225 + V226 + V227
label var resp_eng_score2 "Combined resp. score of speak/understand/read/write English. 4-16. Wave 2"

* Creating dummy for language used with parents, wave 2.
clonevar resp_foreign_parents2 = V258
replace resp_foreign_parents2 = 1 if V258 > 0 & V258 < 30
label var resp_foreign_parents2 "1 if uses non-English when speaking to parents, wave 2"
label define resplab 0 "English" 1 "Other language"
label values resp_foreign_parents2 resplab

* Creating dummy for resp. language preference, wave 2.
clonevar resp_pref2 = V259
replace resp_pref2 = 1 if V259 > 0 & V259 < 29
label var resp_pref2 "1 if resp. prefers speaking in another language, wave 2"
label define resp_pref2l 0 "Prefers English" 1 "Prefers another language"
label values resp_pref2 resp_pref2l

* As before, combining previous two for English preference but another language
* used with parents
gen diff_lang_parents2 = resp_foreign_parents2*resp_pref2
replace diff_lang_parents2 = 1 if resp_foreign_parents2 == 1 & resp_pref2 == 0
replace diff_lang_parents2 = 0 if resp_foreign_parents2 == 1 & resp_pref2 == 1
label var diff_lang_parents2 "1 if resp. pref. English but speaks with parents in foreign lang, wave 2"
label define diff2 0 "Not different, or resp. pref. foreign lang but speaks with parents in Eng" 1 "Respondent prefers Eng but speaks with parents in foreign lang"
label values diff_lang_parents2 diff2

* Another potential outcome variable: GPA in 1995 based on school records.
* Notably, only 108 missing values. Though, there is a minimum of 0.00 which
* might be wrongly inputted, hard to tell.
clonevar gpa2 = V332

* Dummy for parent interview, since only ~half were interviewed
clonevar p_interview = P1
label var p_interview "1 if interview with parents"

* Dummy for parent's answer to what language used in home
clonevar p_foreign_residence = P26A
replace p_foreign_residence = 1 if P26A > 0 & P26A < 78
label var p_foreign_residence "1 if non-Eng language spoken most in residence. Parent int."
label define pfr 0 "English spoken most in residence" 1 "Non-English spoken most in residence"
label values p_foreign_residence pfr

* Dummy for tendency of using non-English with children
clonevar p_foreign_child = P27A
replace p_foreign_child = 1 if P27A > 0 & P27A < 78
label var p_foreign_child "1 if non-Eng language mostly spoken with child. Parent int."
label define pfc 0 "English mostly spoken with child" 1 "Non-English language spoken most with child"
label values p_foreign_child pfc

* 1) Unscaled version of C20. Exactly same o.w.
* 2) A composite of partner/spouses English ability. There is not another 
* version of this in the data set.
* 3) Update: scaled versions of both.
gen p_eng_score = P28A + P28B + P28C + P28D
label var p_eng_score "Combined parent score of speak/understand/read/write English. 4-16"

gen p_eng_score_scaled = C20
label var p_eng_score_scaled "Combined parent score of speak/understand/read/write English. Scaled 1-4"

gen p_partner_eng_score = P29A + P29B + P29C + P29D
label var p_partner_eng_score "Combined spouse/partner score of speak/understand/read/write English. 4-16"

gen p_partner_eng_score_scaled = p_partner_eng_score / 4
label var p_partner_eng_score_scaled "Combined spouse/partner score of speak/understand/read/write English. Scaled 1-4"

* Dummies for the above scores.  1 if good or very good in all 4 English ability
* categories (3 or 4), and 0 if low ability (1 or 2) in any of the categories
clonevar p_eng_dummy = p_eng_score
replace p_eng_dummy = 1 if P28A == 3 | P28A == 4 | P28B == 3 | P28B == 4 | P28C == 3 | P28C == 4 | P28D == 3 | P28D == 4
replace p_eng_dummy = 0 if P28A == 1 | P28A == 2 | P28B == 1 | P28B == 2 | P28C == 1 | P28C == 2 | P28D == 1 | P28D == 2
/* Note: by going in this order of replacement, the result should be same as if
 it was P28A = 3 or 4 & P28B = 3 or 4 etc. but its easier to do this way.
*/
label var p_eng_dummy "1 if parent Eng ability good for all speak/understand/read/write"
label define ped 0 "Little or not at all in any Eng ability category" 1 "Well or very well in all Eng ability categories"
label values p_eng_dummy ped
* Another note: this could be redone with C20, but the end result is exactly 
* the same; this is easily verified.

clonevar p_partner_eng_dummy = p_partner_eng_score
replace p_partner_eng_dummy = 1 if P29A == 3 | P29A == 4 | P29B == 3 | P29B == 4 | P29C == 3 | P29C == 4 | P29D == 3| P29D == 4
replace p_partner_eng_dummy = 0 if P29A == 1 | P29A == 2 | P29B == 1 | P29B == 2 | P29C == 1 | P29C == 2 | P29D == 1| P29D == 2
label var p_partner_eng_dummy "1 if spouse/partner Eng ability good for all speak/understand/read/write"
label define pped 0 "Little or not at all in any Eng ability category" 1 "Well or very well in all Eng ability categories"
label values p_partner_eng_dummy pped

* Copying control variable for income, as stated by parents
clonevar p_income = P56

* Outcome variable for the years of education attained, from wave 3
clonevar yrs_ed = V407A

* More variables!

* Dummy variable for parent's home ownership, wave 1
clonevar own_home = V42
replace own_home = 0 if V42 > 1 & V42 < 6
label var own_home "1 if parent's own their home, wave 1"
label define own_homel 0 "Parent's do not own home" 1 "Parent's own home"
label values own_home own_homel

* Dummy for grade, 1 if ninth, 0 if 8th, wave 1.
* Drops the single 7th grader, and the single 10th grader.
gen ninth_grade = .
replace ninth_grade = 0 if V5 == 8
replace ninth_grade = 1 if V5 == 9
label var ninth_grade "1 if resp. in ninth grade, wave 1"
label define ninth_gradel 0 "Eighth grade" 1 "Ninth grade"
label values ninth_grade ninth_gradel

* Dummies for country/region of respondent's national origin (8 of them)
* My gen of variables is fine, since there are no missing values
gen cuban = 0
replace cuban = 1 if V21 == 1
label var cuban "1 if resp. identifies Cuban, wave 1"
label define cubanl 0 "Not Cuban" 1 "Cuban"
label values cuban cubanl

gen mexican = 0
replace mexican = 1 if V21 == 2
label var mexican "1 if resp. identifies Mexican, wave 1"
label define mexicanl 0 "Not Mexican" 1 "Mexican"
label values mexican mexicanl

gen central_amer = 0
replace central_amer = 1 if V21 == 3 | V21 == 8 | V21 == 9 | V21 == 10 | V21 == 11 | V21 == 12
label var central_amer "1 if resp. identifies Central American, wave 1"
label define central_amerl 0 "Not Central American" 1 "Central American"
label values central_amer central_amerl

gen carribean = 0
replace carribean = 1 if V21 == 7 | V21 == 21 | V21 == 22 | V21 == 23
label var carribean "1 if resp. identifies Carribean, wave 1"
label define carribeanl 0 "Not Carribean" 1 "Carribean"
label values carribean carribeanl

gen south_amer = 0
replace south_amer = 1 if V21 == 4 | V21 == 13 | V21 == 14 | V21 == 15 | V21 == 16 | V21 == 17 | V21 == 18
label var south_amer "1 if resp. identifies South American, wave 1"
label define south_amerl 0 "Not South American" 1 "South American"
label values south_amer south_amerl

gen filipino = 0
replace filipino = 1 if V21 == 30
label var filipino "1 if resp. identifies Filipino, wave 1"
label define filipinol 0 "Not Filipino" 1 "Filipino"
label values filipino filipinol

gen se_asian = 0
replace se_asian = 1 if V21 == 31 | V21 == 32 | V21 == 33 | V21 == 34
label var se_asian "1 if resp. identifies Southeast Asian, wave 1"
label define se_asianl 0 "Not Southeast Asian" 1 "Southeast Asian"
label values se_asian se_asianl

gen e_or_s_asian = 0
replace e_or_s_asian = 1 if V21 == 36 | V21 == 37 | V21 == 38 | V21 == 39 | V21 == 40 | V21 == 41 | V21 == 42
label var e_or_s_asian "1 if resp. identifies East or South Asian, wave 1"
label define e_or_s_asianl 0 "Not East or South Asian" 1 "East or South Asian"
label values e_or_s_asian e_or_s_asianl

* Dummies for family structure (4 of them)
clonevar both_bio_parents = V28
replace both_bio_parents = 1 if V28 == 1
replace both_bio_parents = 0 if V28 > 1 & V28 < 9
label var both_bio_parents "1 if resp. lives w/ both biological parents, wave 1"
label define both_bio_parentsl 0 "Not both biological parents" 1 "Both biological parents"
label values both_bio_parents both_bio_parentsl

clonevar bio_step_parents = both_bio_parents 
* This method is easier since most vals already set to 0.
replace bio_step_parents = 1 if V28 == 2 | V28 == 3
replace bio_step_parents = 0 if V28 == 1
label var bio_step_parents "1 if resp. lives w/ a biological parent and a step parent, wave 1"
label define bio_step_parentsl 0 "Not bio w/ step parent" 1 "Biological parent with step parent"
label values bio_step_parents bio_step_parentsl

clonevar one_parent = both_bio_parents 
* This method is easier since most vals already set to 0.
replace one_parent = 1 if V28 == 4 | V28 == 5
replace one_parent = 0 if V28 == 1
label var one_parent "1 if resp. lives w/ father or mother alone, wave 1"
label define one_parentl 0 "Not only with one parent" 1 "One parent alone"
label values one_parent one_parentl

clonevar other_guardian = both_bio_parents 
* This method is easier since most vals already set to 0.
replace other_guardian = 1 if V28 == 7
replace other_guardian = 0 if V28 == 1
label var other_guardian "1 if resp. lives w/ an adult guardian, wave 1"
label define other_guardianl 0 "Not with a guardian" 1 "Adult guardian"
label values other_guardian other_guardianl

* Copying variables for percent race/ethnicity in schools, wave 1
clonevar schl_white = V140
label var schl_white "Percent of white students in school, wave 1"

clonevar schl_black = V141
label var schl_black "Percent of black students in school, wave 1"

clonevar schl_hisp = V142
label var schl_hisp "Percent of Hispanic students in school, wave 1"

clonevar schl_asian = V143
label var schl_asian "Percent of Asian students in school, wave 1"

* Copying variable for percent eligible for subs. lunch in schools, wave 1
clonevar schl_lunch = V145
label var schl_lunch "Percent of students eligible for subs. lunch in school, wave 1"

* Copying variable for total school population, wave 1
clonevar schl_pop = V146
label var schl_pop "Total school population, wave 1"

* Creating log of total school population, wave 1
gen schl_log_pop = log(schl_pop)
label var schl_log_pop "Log of total school population, wave 1"

* Copying dummy for inner-city school, wave 1
clonevar schl_inner = V147
label var schl_inner "1 if resp. attending inner-city school, wave 1"

* Copying variable for school ID, wave 1; for clustering
clonevar schl_id = V4
label var schl_id "ID number for resp. school, wave 1"

* Outcome dummy for graduating high school, from wave 3
clonevar hschl_grad = V407A
replace hschl_grad = 1 if V407A > 11 | V407A < 19
replace hschl_grad = 0 if V407A == 10
label var hschl_grad "1 if resp. grad from high school, wave 3"
label define hschl_gradl 0 "Did not graduate high school" 1 "Graduated high school"
label values hschl_grad hschl_gradl

* Pairwise correlations between the proxies for parent language knowledge
pwcorr diff_lang_parents home_foreign_use p_eng_score p_eng_score_scaled p_partner_eng_score p_partner_eng_score_scaled

* Some more variables for regressions (added 10/30/2016)

* Additional dummies for resp. time in US
clonevar usa_time_less5yrs = usa_time
replace usa_time_less5yrs = 1 if usa_time == 4
replace usa_time_less5yrs = 0 if usa_time == 1 | usa_time == 2 | usa_time == 3
label var usa_time_less5yrs "1 if resp. in US for less than 5 years, wave 1"
label define usa_time5l 0 "5 years or more" 1 "Less than 5 years"
label values usa_time_less5yrs usa_time5l

clonevar usa_time_5to9yrs = usa_time
replace usa_time_5to9yrs = 1 if usa_time == 3
replace usa_time_5to9yrs = 0 if usa_time == 1 | usa_time == 2 | usa_time == 4
label var usa_time_5to9yrs "1 if resp. in US for 5 to 9 years, wave 1"
label define usa_time5to9l 0 "Not 5 to 9 years" 1 "5 to 9 years"
label values usa_time_5to9yrs usa_time5to9l

clonevar usa_time_10plusyrs = usa_time
replace usa_time_10plusyrs = 1 if usa_time == 2
replace usa_time_10plusyrs = 0 if usa_time == 1 | usa_time == 3 | usa_time == 4
label var usa_time_10plusyrs "1 if resp. in US for 10 or more years, wave 1"
label define usa_time10l 0 "Not 10 years or more, inc. all life" 1 "10 years or more"
label values usa_time_10plusyrs usa_time10l

* Splitting up Often/always in prev dummy for new dummy
clonevar home_foreign_use_always = V57
replace home_foreign_use_always = 1 if V57 == 4
replace home_foreign_use_always = 0 if V57 == 1 | V57 == 2 | V57 == 3
label var home_foreign_use_always "1 if people in home use non_Eng lang always, wave 1"
label define home_foreign_use_alwaysl 0 "Seldom/Time-to-time/Often" 1 "Always"
label values home_foreign_use_always home_foreign_use_alwaysl
