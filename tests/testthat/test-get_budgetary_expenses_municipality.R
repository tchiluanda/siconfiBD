test_that("Get budgetary expenses for municipalities works", {
  expect_gt(NROW(get_budgetary_expenses_municipality(year = 2019,municipality = 3550308, account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Empenhadas")),0)

})
