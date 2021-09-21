test_that("Get government budget revenues for municipalities on a rank of gdp", {
  expect_gt(NROW(get_budgetary_rev_by_gdp_range(gdp_range=c(1,100), gdp_year=2018, rev_year = 2019, account = "Impostos" )),0)

})
