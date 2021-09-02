#' Get distinct budgetary revenue accounts
#'
#' This function retrieves a set of budgetary expense accounts.
#' @param year number indicating the year or reference
#' @return A vector with expense accounts
#' @examples get_distinct_rev_account()
#' @export

get_distinct_rev_account <- function(year=2019){

  query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` where ano =  ", year)

  cat(query)

  basedosdados::read_sql(query)
}
