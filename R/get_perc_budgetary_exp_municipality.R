#' Get government budgetary expense percentage for municipalities
#'
#' This function retrieves values of government functions in % for given municipalities.
#' @param year vector indicating the reference year
#' @param municipality vector with ibge municipality id
#' @param account vector with accounts
#' @param expense_stage vector with expense stages c("Despesas Empenhadas", "Despesas Liquidadas","Despesas Pagas")
#' @return A tibble with data about budgetary expenses
#' @examples get_perc_budgetary_exp_municipality(year=2019, municipality = "3550308", account = "Pessoal e Encargos Sociais", expense_stage= "Despesas Pagas")
#' @export


get_perc_budgetary_exp_municipality<- function(year = 2019,municipality = NULL, account = NULL, expense_stage=NULL ) {

  query_total<- paste0("with query_total as  (select a.ano, a.id_municipio, a.",pkg.env$coluna_estagio,", sum(a.valor) as total FROM `",pkg.env$database, ".",pkg.env$tabela_despesa, "` a where 1=1 ")

  if (!is.null(municipality)) {
    query_total <- paste0(query_total, " and cast(id_municipio as string) in (", stringr::str_c("'",municipality,"'", collapse = "," ),")")
  }

  if (!is.null(year)) {
    query_total <- paste0(query_total, " and ano in (", stringr::str_c(year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query_total <- paste0(query_total, " and lower(",pkg.env$coluna_estagio,") in (",stringr::str_to_lower( stringr::str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  # Usa apenas as contas totais para evitar dupla contagem
  filtra_contas_totais<- paste0(" and ",pkg.env$coluna_id_siconfi ," is null ")

  query_total <- paste0(query_total, filtra_contas_totais)


  query_total <- paste0(query_total, " group by a.ano, a.id_municipio, a.",pkg.env$coluna_estagio, " having sum(a.valor) != 0)")

  query<- paste0(" select df.*, (df.valor / qt.total)*100 as perc from  `",pkg.env$database, ".",pkg.env$tabela_despesa, "` df inner join query_total qt on df.ano = qt.ano and df.id_municipio = qt.id_municipio and df.",pkg.env$coluna_estagio, " = qt.",pkg.env$coluna_estagio, "  where 1=1 ")

  if (!is.null(municipality)) {
    query <- paste0(query, " and cast(df.id_municipio as string) in (", stringr::str_c("'",municipality,"'", collapse = "," ),")")
  }

  if (!is.null(account)) {
    query <- paste0(query, " and lower(df.conta) in (",stringr::str_to_lower(  stringr::str_c("'",account,"'", collapse = "," )),")")
  }

  if (!is.null(year)) {
    query <- paste0(query, " and df.ano in (", stringr::str_c(year, collapse = "," ),")")
  }

  if (!is.null(expense_stage)) {
    query <- paste0(query, " and lower(df.",pkg.env$coluna_estagio,") in (",stringr::str_to_lower( stringr::str_c("'",expense_stage, "'", collapse = "," )),")")
  }

  query_completa<- paste0(query_total, query)

  cat(query_completa)
  read_sql(query_completa)

}
