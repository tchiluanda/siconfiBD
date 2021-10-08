test_that("Get government functions expense percentage for municipalities", {
  expect_gt(NROW(get_perc_function_exp_municipality(year=2019, municipality = "3550308", gov_function = "saúde", expense_stage="Despesas Pagas" )),0)
})
