test_that("Get government functions for municipalities of a given state vector", {
  expect_gt(NROW(get_function_expenses_municipality_state(year=2019, state = "AP", gov_function = "Saúde", expense_stage= "Despesas Pagas")),0)

})
