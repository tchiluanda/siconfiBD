#' Get distinct budgetary revenue accounts
#'
#' This function retrieves a set of budgetary expense accounts.
#' @param year number indicating the year or reference
#' @return A vector with expense accounts
#' @examples get_distinct_rev_account()
#' @export

get_distinct_rev_account <- function(year=2019){

  query<- paste0("SELECT distinct ano, ", pkg.env$coluna_id_siconfi,", conta FROM `",pkg.env$database,".",pkg.env$tabela_receita, "` where 1=1 ")

  query <- paste0(query, " and ano in (", stringr::str_c(year, collapse = "," ),")")

  #query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` where ano =  ", year)

  cat(query)

  read_sql(query)
}
