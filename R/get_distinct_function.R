#' Get distinct functions
#'
#' This function retrieves a set of government functions and/or sub-functions.
#' Notice that the functions are distinct.
#' Users may get all the functions and sub-functions, just the subset of functions
#' as well as just the subset of sub-functions
#' @param year number indicating the year or reference
#' @param scope char ("a", "f", "s") indicates the scope "a" - functions and sub- fuctions, "s" just subfunctions, "f" just functions
#' @return A vector with functions and/or subfunctions
#' @examples get_distinct_function()
#' @export

get_distinct_function <- function(year=2019,scope="a"){

  query<- paste0("SELECT distinct ano, ", pkg.env$coluna_id_siconfi,", conta FROM `",pkg.env$database,".",pkg.env$tabela_funcao, "` where 1=1 ")

  #query<- paste("SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.despesas_por_funcao` where ano =  ", year)

  query <- paste0(query, " and ano in (", stringr::str_c(year, collapse = "," ),")")

  if (scope == "f"){
    query<- paste(query," and CHAR_LENGTH(",pkg.env$coluna_id_siconfi,") <= 2")

  } else if (scope =="s"){
    query<- paste(query," and CHAR_LENGTH(",pkg.env$coluna_id_siconfi,") > 2")
  }

  cat(query)

  read_sql(query)
}

