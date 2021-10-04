test_that("Get government budgetary expense percentage for municipalities", {
  expect_gt(NROW(get_perc_budgetary_exp_municipality(year=2019, municipality = "3550308", account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Pagas" )),0)
})
