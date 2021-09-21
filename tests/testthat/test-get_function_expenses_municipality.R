test_that("Get government functions for municipalities", {
  expect_gt(NROW(get_function_expenses_municipality(year=2019, municipality = "3550308", gov_function = "saúde" )),0)

})
