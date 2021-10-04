test_that("Get government functions for municipalities by gdp rank", {
  expect_gt(NROW(get_function_exp_by_gdp_range(gdp_range=c(1,100), gdp_year=2018, exp_year = 2019, gov_function = "saúde", expense_stage= "Despesas Liquidadas"  )),0)

})
