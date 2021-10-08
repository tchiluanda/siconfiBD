#' Get government functions for municipalities of a given state vector
#'
#' This function retrieves values of govenrment functions for given municipalities.
#' @param year vector indicating the reference year
#' @param state vector with state abbreviation
#' @param gov_function vector with government funcions ids
#' @param expense_stage vctor with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about expanses on functions governments
#' @examples get_function_expenses_municipality_state(year=2019, state = "AP", gov_function = "Saúde", expense_stage= "Despesas Pagas")
#' @export


get_function_expenses_municipality_state<- function(year=2019, state = NULL, gov_function = NULL, expense_stage=NULL ) {


  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_funcao, "` where 1=1 ")

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")
  }


  if (!is.null(state)) {
    query <- paste0(query, " and lower(sigla_uf) in (", str_to_lower( str_c("'",state,"'", collapse = "," )),")")
  }

  if (!is.null(gov_function)) {
    query <- paste0(query, " and lower(conta) in (", str_to_lower( str_c("'",gov_function,"'", collapse = "," )),")")
  }


  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(",pkg.env$coluna_estagio,") in (",str_to_lower( str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  cat(query)
  read_sql(query)


}


