/*	Research: Effects of parental knowledge of
		English on immigrant children's outcomes
	
	Data set:	ICPSR 20520
	Children of Immigrants Longitudinal Study,
		1991-2006
	
	Alberto Ortega, Tyler Ludwig
*/

* Regression file, better/upgraded version
* Run the immigrants_do_v3 first

* Defining macros to make output more readable/changeable
local controlVars parents_usaborn age1 female ninth_grade parents_edyrs both_bio_parents bio_step_parents one_parent other_guardian own_home schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner i.V2
local langVars diff_lang_parents home_foreign_use home_foreign_use_always p_scld p_part_scld p_avg_eng_score p_foreign_child p_foreign_residence pref_eng_nonenghome
* langVars2 drops the home_foreign_use variables since
* they don't make sense for a reg where home_foreign_use_always == 1
local langVars2 diff_lang_parents p_scld p_part_scld p_avg_eng_score p_foreign_child p_foreign_residence pref_eng_nonenghome
local timeVars usa_time_less5yrs usa_time_5to9yrs usa_time_10plusyrs

* Creating interaction effects
foreach v in `langVars' {
gen `v'_less5 = `v'*usa_time_less5yrs
}
foreach v in `langVars' {
gen `v'_5to9 = `v'*usa_time_5to9yrs
}
foreach v in `langVars' {
gen `v'_10plus = `v'*usa_time_10plusyrs
}

* Regressions for math percentile as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg math_cent `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for reading percentile as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg read_cent `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg gpa `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for yrs_ed as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg yrs_ed `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa2 as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg gpa2 `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for graduating high school as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly areg hschl_grad `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* A sample regression with only students w/out English at home
* Just using math std score to test
local i = 1
foreach v in `langVars2' {
quietly areg math_cent `v' `timeVars' `controlVars' `v'_less5 `v'_5to9 `v'_10plus, robust a(V21) cluster(schl_id) if home_foreign_use_always == 1
estimates store reg`i'
local ++i
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)
