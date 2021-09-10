test_that("Get government budget revenues for municipalities by population rank", {
  get_function_rev_by_pop_range(pop_range=c(1,100), gdp_year=2018, exp_year = 2019, account = "Impostos" )
})
