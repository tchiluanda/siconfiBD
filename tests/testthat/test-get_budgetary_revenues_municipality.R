test_that("retrieve budgetary revenues data", {
  expect_gt(NROW(get_budgetary_revenues_municipality(year = 2019,municipality = 3550308,account = "Impostos")),0)

})
