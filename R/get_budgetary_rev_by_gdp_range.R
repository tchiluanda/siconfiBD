#' Get government budget revenues for municipalities on a rank of gdp.
#'
#' This function retrieves values of budget expenses for municipalities on a rank of gdp..
#' @param gdp_range vector with two positions indicating the gdp rank range
#' @param gdp_year vector indicating the year of reference for gdp rank
#' @param rev_year vector indicating the reference year
#' @param account vector with accounts
#' @return A tibble with data about budgetary revenues
#' @examples get_budgetary_rev_by_gdp_range(gdp_range=c(1,100), gdp_year=2018, rev_year = 2019, account = "Impostos" )
#' @export


get_budgetary_rev_by_gdp_range<- function(gdp_range=c(1,100), gdp_year=2018, rev_year = 2019, account = NULL ) {

  query<- "SELECT * FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` where 1=1 "


  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (",str_to_lower(  str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(rev_year)) {
    query <- paste0(query, " and ano in (", str_c(rev_year, collapse = "," ),")")
  }


  query <- paste0(query, " and id_municipio in ")

  query_gdp<-
    paste("(SELECT cast(id_municipio as integer) FROM (SELECT id_municipio, ROW_NUMBER() OVER (ORDER BY pib desc) R FROM basedosdados.br_ibge_pib.municipio
   where ano=",gdp_year,") WHERE R BETWEEN", gdp_range[1]," and ",gdp_range[2],")")

  query <- paste0(query, query_gdp)

  cat(query)
  basedosdados::read_sql(query)

}
