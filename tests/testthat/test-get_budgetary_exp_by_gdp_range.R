test_that("Get government budget expenses for municipalities on a rank of gdp", {

  projeto <- read_csv("~/Github/siconfiBD/projeto.csv")


  setup_siconfi(projeto$projeto)
  expect_gt(NROW(get_budgetary_exp_by_gdp_range(gdp_range=c(1,100), gdp_year=2018,exp_year = 2019, account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Empenhadas" )),0)
})
