#' Get distinct budgetary expense accounts
#'
#' This function retrieves a set of budgetary expense accounts.
#' @param year number indicating the year or reference
#' @return A vector with expense accounts
#' @examples get_distinct_exp_account()
#' @export

get_distinct_exp_account <- function(year=2019){

  query<- paste0("SELECT distinct ano, ", pkg.env$coluna_id_siconfi,", conta FROM `",pkg.env$database,".",pkg.env$tabela_despesa, "` where 1=1 ")

  query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")

  #query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.despesas_orcamentarias` where ano =  ", year)

  cat(query)

  basedosdados::read_sql(query)
}
