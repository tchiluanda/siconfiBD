test_that("Get government functions for municipalities by population rank", {
  expect_gt(NROW(get_function_exp_by_pop_range(pop_range=c(1,100), pop_year=2018, exp_year = 2019, gov_function = "saúde" )),0)

})
