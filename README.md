
<!-- README.md is generated from README.Rmd. Please edit that file -->

# siconfiBD

<!-- badges: start -->

<!-- badges: end -->

The goal of siconfiBD is to get public financial data from Brazillian
municipalities

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tchiluanda/siconfiBD")
```

## Example

This is a basic example which shows you how to get government functions
for municipalities of a given state vector:

``` r
library(siconfiBD)
## You need a Google Cloud Project and then set this project using the funcion below just before use the
## functions to retrieve data
#set_billing_id(<your_project_id>) 


exp_mun_state<- get_function_expenses_municipality_state(year=2019, state = "AP", gov_function = "Saúde", expense_stage= "Despesas Pagas")
#> SELECT * FROM `basedosdados.br_tesouro_finbra.despesas_por_funcao` where 1=1  and ano in (2019) and lower(sigla_uf) in ('ap') and lower(conta) in ('saúde') and lower(coluna) in ('despesas pagas')
#> ! Using an auto-discovered, cached token.
#>   To suppress this message, modify your code or options to clearly consent to
#>   the use of a cached token.
#>   See gargle's "Non-interactive auth" vignette for more details:
#>   <https://gargle.r-lib.org/articles/non-interactive-auth.html>
#> i The bigrquery package is using a cached token for 'fbarbalho@gmail.com'.

head(exp_mun_state)
#> # A tibble: 6 x 8
#>   id_municipio sigla_uf     ano populacao coluna         id_conta conta    valor
#>        <int64> <chr>    <int64>   <int64> <chr>          <chr>    <chr>    <dbl>
#> 1      1600105 AP          2019      9029 Despesas Pagas 10       Saúde   5.19e6
#> 2      1600154 AP          2019     15931 Despesas Pagas 10       Saúde   1.28e7
#> 3      1600238 AP          2019      7591 Despesas Pagas 10       Saúde   7.32e6
#> 4      1600253 AP          2019      5387 Despesas Pagas 10       Saúde   3.36e6
#> 5      1600303 AP          2019    493634 Despesas Pagas 10       Saúde   1.49e8
#> 6      1600402 AP          2019     21206 Despesas Pagas 10       Saúde   1.09e7
```

or maybe you want the data for some expense account of a given
municipality.

``` r
exp_mun<- get_budgetary_expenses_municipality(year = 2019,municipality = 3550308, account = "Pessoal e Encargos Sociais")
#> SELECT * FROM `basedosdados.br_tesouro_finbra.despesas_orcamentarias` where 1=1  and id_municipio in (3550308) and lower(conta) in ('pessoal e encargos sociais') and ano in (2019)

head(exp_mun)
#> # A tibble: 5 x 8
#>   id_municipio sigla_uf     ano populacao coluna      id_conta  conta      valor
#>        <int64> <chr>    <int64>   <int64> <chr>       <chr>     <chr>      <dbl>
#> 1      3550308 SP          2019  12176866 Despesas E~ 3.1.00.0~ Pessoal~ 2.51e10
#> 2      3550308 SP          2019  12176866 Despesas L~ 3.1.00.0~ Pessoal~ 2.47e10
#> 3      3550308 SP          2019  12176866 Despesas P~ 3.1.00.0~ Pessoal~ 2.47e10
#> 4      3550308 SP          2019  12176866 Inscrição ~ 3.1.00.0~ Pessoal~ 3.98e 8
#> 5      3550308 SP          2019  12176866 Inscrição ~ 3.1.00.0~ Pessoal~ 6.90e 6
```

if you are not sure what are the government functions available you can
use something like this:

``` r
gov_func<- get_distinct_function()
#> SELECT distinct id_conta, conta  FROM `basedosdados.br_tesouro_finbra.despesas_por_funcao` where ano =   2019

head(gov_func)
#> # A tibble: 6 x 2
#>   id_conta conta                             
#>   <chr>    <chr>                             
#> 1 <NA>     Despesas Exceto Intraorçamentárias
#> 2 01       Legislativa                       
#> 3 01.031   Ação Legislativa                  
#> 4 04       Administração                     
#> 5 04.122   Administração Geral               
#> 6 08       Assistência Social
```

## Credits

This package uses the library {basedosdados}. 

cff-version: 1.1.0
message: "If you use this software, please cite it as below."
authors:
  - family-names: Base dos Dados
url: "https://basedosdados.org"
year-original: 2019
year: 2021
