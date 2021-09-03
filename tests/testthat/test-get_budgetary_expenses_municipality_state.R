test_that("Get government budget expenses for municipalities", {
  get_budgetary_expenses_municipality_state(year = 2019,state = "AP", account = "Pessoal e Encargos Sociais", expense_stage="Despesas Pagas")
})
