#' Get government budget expenses for municipalities
#'
#' This function retrieves values of budget expenses for given municipalities.
#' @param year vector indicating the year or reference
#' @param state vector with state abbreviation
#' @param account vector with account names
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_budgetary_expenses_municipality_state(year = 2019,state = "AP", account = "Pessoal e Encargos Sociais", expense_stage="Despesas Pagas")
#' @export


get_budgetary_expenses_municipality_state<- function(year = 2019,state = NULL, account = NULL, expense_stage=NULL ) {

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_despesa, "` where 1=1 ")

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")
  }

  if (!is.null(state)) {
    query <- paste0(query, " and lower(sigla_uf) in (", str_to_lower(str_c("'",state,"'", collapse = "," )),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(conta) in (", str_to_lower(str_c("'",account,"'", collapse = "," )),")")
  }


  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(estagio_bd) in (", str_to_lower(str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  cat(query)
  basedosdados::read_sql(query)

}
