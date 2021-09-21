#' Get government budget revenues for municipalities by population rank
#'
#' This function retrieves values of government functions for given municipalities by gdp rank.
#' @param pop_range vector with two positions indicating the gdp rank range
#' @param pop_year vector indicating the year of reference for gdp rank
#' @param rev_year vector indicating the reference year
#' @param account vector with accounts
#' @return A tibble with data about budgetary expenses
#' @examples get_budgetary_rev_by_pop_range(pop_range=c(1,100), pop_year=2018, rev_year = 2019, account = "Impostos" )
#' @export


get_budgetary_rev_by_pop_range<- function(pop_range=c(1,100), pop_year=2018, rev_year = 2019, account = NULL) {

  query<- "SELECT * FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` where 1=1 "


  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (",str_to_lower(  str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(rev_year)) {
    query <- paste0(query, " and ano in (", str_c(rev_year, collapse = "," ),")")
  }


  query <- paste0(query, " and id_municipio in ")

  query_pop<-
    paste("(SELECT cast(id_municipio as integer) FROM (SELECT id_municipio, ROW_NUMBER() OVER (ORDER BY populacao desc) R FROM basedosdados.br_ibge_populacao.municipio
   where ano=",pop_year,") WHERE R BETWEEN", pop_range[1]," and ",pop_range[2],")")

  query <- paste0(query, query_pop)

  cat(query)
  basedosdados::read_sql(query)

}
