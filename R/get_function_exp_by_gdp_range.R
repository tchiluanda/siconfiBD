#' Get government functions for municipalities by gdp rank
#'
#' This function retrieves values of government functions for given municipalities by gdp rank.
#' @param gdp_range vector with two positions indicating the gdp rank range
#' @param gdp_year vector indicating the year of reference for gdp rank
#' @param exp_year vector indicating the reference year
#' @param gov_function vector with government functions
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_function_exp_by_gdp_range(gdp_range=c(1,100), gdp_year=2018, exp_year = 2019, gov_function = "saúde", expense_stage= "Despesas Liquidadas"  )
#' @export


get_function_exp_by_gdp_range<- function(gdp_range=c(1,100), gdp_year=2018, exp_year = 2019, gov_function = NULL, expense_stage=NULL ) {

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_funcao, "` where 1=1 ")


  if (!is.null(gov_function)) {
    query <- paste0(query, " and lower(conta) in (",str_to_lower(  str_c("'",gov_function,"'", collapse = "," )),")")
  }

  if (!is.null(exp_year)) {
    query <- paste0(query, " and ano in (", str_c(exp_year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(estagio_bd) in (", str_to_lower( str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  query <- paste0(query, " and id_municipio in ")

  query_gdp<-
    paste("(SELECT cast(id_municipio as string) FROM (SELECT id_municipio, ROW_NUMBER() OVER (ORDER BY pib desc) R FROM basedosdados.br_ibge_pib.municipio
   where ano=",gdp_year,") WHERE R BETWEEN", gdp_range[1]," and ",gdp_range[2],")")

  query <- paste0(query, query_gdp)

  cat(query)
  read_sql(query)

}
