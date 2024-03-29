% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_exp_account_by_name.R
\name{get_exp_account_by_name}
\alias{get_exp_account_by_name}
\title{Get budgetary expense accounts by name}
\usage{
get_exp_account_by_name(year = 2019, name)
}
\arguments{
\item{year}{number indicating the year or reference}

\item{name}{account name that will be searched}
}
\value{
A vector with expense accounts
}
\description{
This function searchs budgetary expense accounts by a given name.
}
\examples{
get_exp_account_by_name(name = "pessoal")
}
