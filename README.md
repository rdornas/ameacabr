
# ameacabr

<!-- badges: start -->
<!-- badges: end -->

O objetivo do `ameacabr` é prover uma base de dados de listas vermelhas estaduais e nacional, possibilitando pesquisar e obter os _status_ de ameaça das espécies (e subespécies) da fauna brasileira ameaçadas de extinção.

## AVISO
Várias das bases de dados utilizadas estão defasadas em termos taxonômicos ou mesmo na utilização padrão das siglas de categoria de ameaca. Na medida do possível, faço alterações, mas não detenho conhecimento de toda a fauna para realizar substituições da nomenclatura científica. Use o pacote com cautela e redobre a atenção aos resultados. Se encontrar erros, me mande um e-mail para que eu possa corrigir.

## Instalação

A instalação do pacote se dá por intermédio do acesso ao repositório no Github, conforme instruções abaixo:

``` r
#install.packages("devtools")
devtools::install_github("rdornas/ameacabr")
```

Uma vez que ao atualizar os pacotes pelo R não ocorre atualização dos pacotes não instalados pelo CRAN, sugiro que, sempre que possível, rode o comando para atualizar pacotes advindos do Github:

``` r
devtools::install_github("hrbrmstr/dtupdate")
dtupdate::github_update(auto.install = T)
```

## Exemplo

Esse é um exemplo básico da utilização do pacote:

``` r
library(ameacabr)

ameacabr(x = "Alouatta guariba", ufs = c("MG", "SP"), subsp = F, tabela = T)
```

## Citação

Se você acreditar que esse pacote é útil, por favor, utilize a citação:

``` r
citation("ameacabr")
```
ou simplesmente:

Dornas, R. 2020. ameacabr: Status de ameaça das espécies da fauna brasileira. R package version 0.0.1. https://github.com/rdornas/ameacabr
