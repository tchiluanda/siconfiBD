#' Get budgetary expenses for municipalities
#'
#' This function retrieves values of govenrment functions for given municipalities.
#' @param year vector indicating the year or reference
#' @param municipality vector with state abbreviation
#' @param account vector with account names
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_budgetary_expenses_municipality(year = 2019,municipality = 3550308, account = "Pessoal e Encargos Sociais")
#' @export


get_budgetary_expenses_municipality<- function(year = 2019,municipality = NULL, account = NULL, expense_stage=NULL ) {

  query<- "SELECT * FROM `basedosdados.br_tesouro_finbra.despesas_orcamentarias` where 1=1 "

  if (!is.null(municipality)) {
    query <- paste0(query, " and id_municipio in (", str_c(municipality, collapse = "," ),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (", str_to_lower( str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(coluna) in (", str_to_lower( str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  cat(query)
  basedosdados::read_sql(query)

}
