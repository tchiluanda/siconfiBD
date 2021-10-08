#' Get budgetary expense accounts by name
#'
#' This function searchs budgetary expense accounts by a given name.
#' @param year number indicating the year or reference
#' @param name account name that will be searched
#' @return A vector with expense accounts
#' @examples get_exp_account_by_name(name = "pessoal")
#' @export

get_exp_account_by_name <- function(year=2019, name){

  query<- paste0("SELECT distinct ano, portaria, conta FROM `",pkg.env$database,".",pkg.env$tabela_despesa, "` where 1=1 ")

  query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")

  #query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.despesas_orcamentarias` where ano =  ", year)

  query<- paste0(query," and lower(conta) like '%", str_to_lower(name) , "%'")

  cat(query)

  read_sql(query)
}
