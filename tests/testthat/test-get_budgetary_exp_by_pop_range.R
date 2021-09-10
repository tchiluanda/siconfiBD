test_that("Get government budget expenses for municipalities by population rank", {
  get_function_exp_by_gdp_range(pop_range=c(1,100), gdp_year=2018, exp_year = 2019, account = "Pessoal e Encargos Sociais" )
})
