#' Get government functions expenses for municipalities
#'
#' This function retrieves values of govenrment functions for given municipalities.
#' @param year vector indicating the reference year
#' @param municipality vector with ibge municipality id
#' @param gov_function vector with government funcions ids
#' @param expense_stage vector with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about expanses on functions governments
#' @examples get_function_expenses_municipality(year=2019, municipality = "3550308", gov_function = "saúde" , expense_stage="Despesas Pagas")
#' @export


get_function_expenses_municipality<- function(year = 2019,municipality = NULL, gov_function = NULL, expense_stage=NULL ) {

  query<- paste0("SELECT * FROM `",pkg.env$database,".",pkg.env$tabela_funcao, "` where 1=1 ")

  if (!is.null(municipality)) {
    query <- paste0(query, " and cast(id_municipio as string) in (", stringr::str_c("'",municipality,"'", collapse = "," ),")")
  }

  if (!is.null(gov_function)) {
    query <- paste0(query, " and lower(conta) in (",stringr::str_to_lower(  stringr::str_c("'",gov_function,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and ano in (", stringr::str_c(year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(estagio_bd) in (", stringr::str_to_lower( stringr::str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  cat(query)
  read_sql(query)

}
