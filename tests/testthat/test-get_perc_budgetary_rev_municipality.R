test_that("retrieves values of government functions in % for given municipalities", {
  expect_gt(NROW( get_perc_budgetary_rev_municipality(year=2019, municipality = "3550308", account = "Impostos")),0 )
})
