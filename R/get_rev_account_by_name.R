#' Get budgetary revenue accounts by name
#'
#' This function searchs budgetary expense accounts by a given name.
#' @param year number indicating the year or reference
#' @param name account name that will be searched
#' @return A vector with expense accounts
#' @examples get_rev_account_by_name(name="imposto")
#' @export

get_rev_account_by_name <- function(year=2019, name){

  query<- paste0("SELECT distinct ano,", pkg.env$coluna_id_siconfi, ", conta FROM `",pkg.env$database,".",pkg.env$tabela_receita, "` where 1=1 ")


  #query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` where ano =  ", year)

  query <- paste0(query, " and ano in (", str_c(year, collapse = "," ),")")

  query<- paste0(query," and lower(conta) like '%", str_to_lower(name) , "%'")

  cat(query)

  basedosdados::read_sql(query)
}
