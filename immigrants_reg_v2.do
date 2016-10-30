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
local controlVars age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner
local langVars diff_lang_parents home_foreign_use home_foreign_use_always p_eng_score_scaled p_partner_eng_score_scaled p_foreign_child p_foreign_residence
local timeVars usa_time_less5yrs usa_time_5to9yrs usa_time_10plusyrs

* Regressions for math percentile as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg math_cent `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for reading percentile as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg read_cent `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg gpa `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for yrs_ed as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg yrs_ed `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa2 as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg gpa2 `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for graduating high school as outcome
* Combined to make easier comparisons of values/significance
local i = 1
foreach v in `langVars' {
quietly reg hschl_grad `v' `timeVars' `controlVars', robust cluster(schl_id)
estimates store reg`i'
local ++i
}
estimates table reg1 reg2 reg3 reg4 reg5 reg6 reg7, varwidth(15) b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)
