#' Overrides basedadosdados::read_sql function
#'
#' Define new default value to page_seize
#' @param query a string containing a valid SQL query.
#' @param page_size bigrquery internal, how many rows per page should there be. Defaults to 10000, consider increasing if running into performance issues or big queries.
#' @return A tibble containing the query's output.
#' @examples read_sql(query,page_size = 1e+04)
#' @export

read_sql <- function(query,  page_size = pkg.env$page_size){

  basedosdados::read_sql(query)


}
