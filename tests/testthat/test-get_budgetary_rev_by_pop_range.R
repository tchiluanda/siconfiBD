test_that("Get government budget revenues for municipalities by population rank", {
  expect_gt(NROW(get_budgetary_rev_by_pop_range(pop_range=c(1,100), pop_year=2018, rev_year = 2019, account = "Impostos" )),0)

})
