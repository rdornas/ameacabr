
# ameacabr

<!-- badges: start -->
<!-- badges: end -->

O objetivo do `ameacabr` é prover uma base de dados de listas vermelhas estaduais e nacional, possibilitando pesquisar e obter os _status_ de ameaça das espécies (e subespécies) da fauna brasileira ameaçadas de extinção.

## Instalação

A instalação do pacote se dá por intermédio do acesso ao repositório no github:

``` r
#install.packages("devtools")
devtools::install_github("rdornas/ameacabr")
```

## Exemplo

Esse é um exemplo básico da utilização do pacote:

``` r
library(ameacabr)

ameacabr(x = "Alouatta guariba", ufs = c("MG", "SP"), subsp = T, tabela = T)
```

