
# ameacabr

<!-- badges: start -->
<!-- badges: end -->

O objetivo do `ameacabr` é prover uma base de dados de listas vermelhas estaduais e nacional, possibilitando pesquisar e obter os _status_ de ameaça das espécies (e subespécies) da fauna brasileira ameaçadas de extinção.

## Instalação

A instalação do pacote se dá por intermédio do acesso ao repositório no Github, conforme instruções abaixo:

``` r
#install.packages("devtools")
devtools::install_github("rdornas/ameacabr")
```

Uma vez que ao atualizar os pacotes pelo R não ocorre atualização dos pacotes não instalados pelo CRAN, sugiro que, sempre que possível, rode o comando para atualizar pacotes advindos do Github:

``` r
devtools::install_github("hrbrmstr/dtupdate")
dtupdate::github_update()
```

## Exemplo

Esse é um exemplo básico da utilização do pacote:

``` r
library(ameacabr)

ameacabr(x = "Alouatta guariba", ufs = c("MG", "SP"), subsp = T, tabela = T)
```

