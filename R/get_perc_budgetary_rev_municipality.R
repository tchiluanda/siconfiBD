#' Get government budgetary revenues percentage for municipalities
#'
#' This function retrieves values of government functions in % for given municipalities.
#' @param year vector indicating the reference year
#' @param municipality vector with ibge municipality id
#' @param account vector with accounts
#' @return A tibble with data about budgetary expenses
#' @examples get_perc_budgetary_rev_municipality(year=2019, municipality = "3550308", account = "Impostos" )
#' @export


get_perc_budgetary_rev_municipality<- function(year = 2019,municipality = NULL, account = NULL, expense_stage=NULL ) {

  query_total<- "with query_total as  (select a.ano, a.id_municipio, a.coluna, sum(a.valor) as total FROM `basedosdados.br_tesouro_finbra.receitas_orcamentarias` a where 1=1 "

  if (!is.null(municipality)) {
    query_total <- paste0(query_total, " and id_municipio in (", str_c(municipality, collapse = "," ),")")
  }

  if (!is.null(year)) {
    query_total <- paste0(query_total, " and ano in (", str_c(year, collapse = "," ),")")
  }


  # Usa apenas as contas totais para evitar dupla contagem
  filtra_contas_totais<- " and id_conta is null "

  query_total <- paste0(query_total, filtra_contas_totais)


  query_total <- paste0(query_total, " group by a.ano, a.id_municipio, a.coluna having sum(a.valor) != 0)")

  query<- " select df.*, (df.valor / qt.total)*100 as perc from  `basedosdados.br_tesouro_finbra.receitas_orcamentarias` df inner join query_total qt on df.ano = qt.ano and df.id_municipio = qt.id_municipio and df.coluna = qt.coluna  where 1=1 "

  if (!is.null(municipality)) {
    query <- paste0(query, " and df.id_municipio in (", str_c(municipality, collapse = "," ),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(df.conta) in (",str_to_lower(  str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and df.ano in (", str_c(year, collapse = "," ),")")
  }


  query_completa<- paste0(query_total, query)

  cat(query_completa)
  basedosdados::read_sql(query_completa)

}
