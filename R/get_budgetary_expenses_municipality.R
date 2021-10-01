#' Get budgetary expenses for municipalities
#'
#' This function retrieves values of govenrment functions for given municipalities.
#' @param year vector indicating the year or reference
#' @param municipality vector with state abbreviation
#' @param account vector with account names
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_budgetary_expenses_municipality(year = 2019,municipality = 3550308, account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Empenhadas")
#' @export


get_budgetary_expenses_municipality<- function(year = 2019,municipality = NULL, account = NULL, expense_stage=NULL ) {

  print(pkg.env$database)

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_despesa, "` where 1=1 ")

  if (!is.null(municipality)) {
    query <- paste0(query, " and cast(id_municipio as string) in (", str_c("'",municipality,"'", collapse = "," ),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (", str_to_lower( str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(estagio_bd) in (", str_to_lower( str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  cat(query)
  basedosdados::read_sql(query)

}
