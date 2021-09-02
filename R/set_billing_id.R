#' Define your Project Id
#'
#' Define your project billing ids here so all your queries are authenticated and return data, not errors. If using in production or leaving code available at public repositories, dotenv is highly recommended.
#' @param project_id a single character value containing the string. Vectors with longer lengths and non-vectors will trigger an error.
#' @return No return
#' @examples set_billing_id(<your_project_id>)
#' @export


set_billing_id <- function(project_id){
  basedosdados::set_billing_id(project_id)
}
