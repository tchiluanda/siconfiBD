#' Define your Project Id and dataset parameters
#'
#' Define your project billing ids here so all your queries are authenticated and return data, not errors. If using in production or leaving code available at public repositories, dotenv is highly recommended.
#' @param project_id a single character value containing the string. Vectors with longer lengths and non-vectors will trigger an error.
#' @return No return
#' @examples setup_siconfi(<your_project_id>)
#' @export

pkg.env <- new.env()

#' @export
setup_siconfi <- function(project_id=NULL, database="basedosdados-dev.br_me_siconfi", tabela_despesa ="municipio_despesas_orcamentarias", tabela_receita="municipio_receitas_orcamentarias", tabela_funcao="municipio_despesas_funcao", coluna_estagio= "estagio_bd", coluna_id_siconfi="portaria" ){
  basedosdados::set_billing_id(project_id)


  pkg.env$database <- database
  pkg.env$tabela_despesa <- tabela_despesa
  pkg.env$tabela_funcao <- tabela_funcao
  pkg.env$tabela_receita<- tabela_receita
  pkg.env$coluna_estagio<- coluna_estagio
  pkg.env$coluna_id_siconfi<-coluna_id_siconfi

}
