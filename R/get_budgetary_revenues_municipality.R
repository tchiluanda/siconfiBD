#' Get budgetary revenues for municipalities
#'
#' This function retrieves values of government functions for given municipalities.
#' @param year vector indicating the reference years
#' @param municipality vector with IBGE ids for municipalities
#' @param account vector with account names
#' @return A tibble with data about budgetary revenues
#' @examples get_budgetary_revenues_municipality(year = 2019,municipality = 3550308,account = "Impostos")
#' @export


get_budgetary_revenues_municipality<- function(year = 2019,municipality = NULL, account = NULL) {

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_receita, "` where 1=1 ")

  if (!is.null(municipality)) {
    query <- paste0(query, " and cast(id_municipio as string) in (", stringr::str_c("'",municipality,"'", collapse = "," ),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (", stringr::str_to_lower( stringr::str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", stringr::str_c(year, collapse = "," ),")")
  }


  cat(query)
  read_sql(query)

}
