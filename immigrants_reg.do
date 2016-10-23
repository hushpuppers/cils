/*	Research: Effects of parental knowledge of
		English on immigrant children's outcomes
	
	Data set:	ICPSR 20520
	Children of Immigrants Longitudinal Study,
		1991-2006
	
	Alberto Ortega, Tyler Ludwig
*/

* Regression file
* Run the immigrants_update_do first

* Regressions for each of the outcome variables
* Without the variables of interest
* Commented out to suppress output
//reg math_cent age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
//reg read_cent age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
//reg gpa age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
//reg yrs_ed age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
//reg gpa2 age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
//reg hschl_grad age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)

* Regressions for math percentile as outcome
* Combined to make easier comparison
quietly reg math_cent diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store r1
quietly reg math_cent home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store r2
quietly reg math_cent p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store r3
quietly reg math_cent p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store r4
estimates table r1 r2 r3 r4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for reading percentile as outcome
* Combined to make easier comparison
quietly reg read_cent diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store s1
quietly reg read_cent home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store s2
quietly reg read_cent p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store s3
quietly reg read_cent p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store s4
estimates table s1 s2 s3 s4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa as outcome
* Combined to make easier comparison
quietly reg gpa diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store t1
quietly reg gpa home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store t2
quietly reg gpa p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store t3
quietly reg gpa p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store t4
estimates table t1 t2 t3 t4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for yrs_ed as outcome
* Combined to make easier comparison
quietly reg yrs_ed diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store u1
quietly reg yrs_ed home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store u2
quietly reg yrs_ed p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store u3
quietly reg yrs_ed p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store u4
estimates table u1 u2 u3 u4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for gpa2 as outcome
* Combined to make easier comparison
quietly reg gpa2 diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store v1
quietly reg gpa2 home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store v2
quietly reg gpa2 p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store v3
quietly reg gpa2 p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store v4
estimates table v1 v2 v3 v4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)

* Regressions for graduating high school as outcome
* Combined to make easier comparison
quietly reg hschl_grad diff_lang_parents age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store w1
quietly reg hschl_grad home_foreign_use age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store w2
quietly reg hschl_grad p_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store w3
quietly reg hschl_grad p_partner_eng_score_scaled age1 female ninth_grade mother_edu_yrs father_edu_yrs both_bio_parents bio_step_parents one_parent other_guardian own_home cuban mexican central_amer carribean south_amer filipino se_asian e_or_s_asian schl_white schl_black schl_hisp schl_asian schl_lunch schl_log_pop schl_inner, robust cluster(schl_id)
estimates store w4
estimates table w1 w2 w3 w4, varwidth(25)  b(%6.3f) star(0.10 0.05 0.01) stats(N r2_a)
