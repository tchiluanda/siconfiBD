#' Get government budget expenses for municipalities by population rank
#'
#' This function retrieves values of government functions for given municipalities by gdp rank.
#' @param pop_range vector with two positions indicating the gdp rank range
#' @param pop_year vector indicating the year of reference for gdp rank
#' @param exp_year vector indicating the reference year
#' @param account vector with accounts
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_budgetary_exp_by_pop_range(pop_range=c(1,100), pop_year=2018, exp_year = 2019, account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Empenhadas")
#' @export


get_budgetary_exp_by_pop_range<- function(pop_range=c(1,100), pop_year=2018, exp_year = 2019, account = NULL, expense_stage=NULL ) {

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_despesa, "` where 1=1 ")


  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (",stringr::str_to_lower(  stringr::str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(exp_year)) {
    query <- paste0(query, " and ano in (", stringr::str_c(exp_year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(estagio_bd) in (", stringr::str_to_lower( stringr::str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  query <- paste0(query, " and id_municipio in ")

  query_pop<-
    paste("(SELECT cast(id_municipio as string) FROM (SELECT id_municipio, ROW_NUMBER() OVER (ORDER BY populacao desc) R FROM basedosdados.br_ibge_populacao.municipio
   where ano=",pop_year,") WHERE R BETWEEN", pop_range[1]," and ",pop_range[2],")")

  query <- paste0(query, query_pop)

  cat(query)
  read_sql(query)

}
