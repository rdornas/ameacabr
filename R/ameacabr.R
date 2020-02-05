#' ameacabr
#'
#' Pesquisa os status de ameaça das espécies da fauna brasileira incluindo as listas estaduais do país (atualmente estão disponíveis as seguintes UF/opções: Brasil, BA, ES, MG, PA, RJ, SC, SP)
#'
#'
#' @param x Vetor contendo as espécies a serem avaliadas. Se quiser pesquisar pela lista completa de espécies do banco de dados, utilize a opção "todas".
#' @param ufs Estados a serem pesquisados. Algumas opções especiais estão disponíveis: "UF" exibe apenas as listas estaduais, "BR" mostra apenas o resultado da lista nacional e "todas" realiza a pesquisa em todas as opções citadas acima.
#' @param subsp O vetor das espécies contempla subespécies?
#' @param tabela O resultado gerado deve estar em formato de tabela?
#'
#' @author Rubem Dornas \email{(rapdornas@@gmail.com)}
#'
#' @details
#' **AVISO**: Várias das bases de dados utilizadas estão defasadas em termos taxonômicos ou mesmo na utilização padrão das siglas de categoria de ameaca. Na medida do possível, faço alterações, mas não detenho conhecimento de toda a fauna para realizar substituições da nomenclatura científica. Use o pacote com cautela e redobre a atenção aos resultados. Se encontrar erros, me mande um e-mail para que eu possa corrigir.
#'
#' O resultado do data frame obtido é o seguinte (além das colunas das UF):
#'
#' * **nome_cientifico**: Nome científico da espécie.
#' * **nome_cientifico_subsp**: Nome científico da espécie, podendo ou não conter a subespécie elencada na lista vermelha.
#' * **categoria**: Categoria de ameaça da espécie.
#'
#' @importFrom magrittr "%>%"
#'
#' @export

ameacabr <- function(x, ufs, subsp = F, tabela = T){

  suppressWarnings(
    if(x == "todas"){
      especies_pesquisa <- unique(ameaca$nome_cientifico)
    }
    else{
      especies_pesquisa <- unique(x)
    }
  )
  # UF <- ameaca %>%
  #   dplyr::filter(uf != "Brasil") %>%
  #   dplyr::pull(.)

  todas <- ameaca %>%
    dplyr::distinct(uf) %>%
    dplyr::pull(.)

  ameaca <- ameaca %>%
    dplyr::select(-sinonimo_ou_erro)

  suppressWarnings(
  if(subsp == T){
    if(ufs == "todas"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa |
                        nome_cientifico %in% especies_pesquisa) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria) %>%
        tidyr::complete(uf,
                        tidyr::nesting(nome_cientifico, nome_cientifico_subsp),
                        fill = list(categoria = NA_character_))
    }

    else if(ufs == "UF"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa | nome_cientifico %in% especies_pesquisa) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria) %>%
        tidyr::complete(uf, tidyr::nesting(nome_cientifico, nome_cientifico_subsp),
                        fill = list(categoria = NA_character_)) %>%
        dplyr::filter(uf != "Brasil")
    }

    else if(ufs == "BR"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa | nome_cientifico %in% especies_pesquisa,
                      uf == "Brasil") %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }

    else{
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa | nome_cientifico %in% especies_pesquisa,
                      uf %in% ufs) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }
  }

  else{
    if(ufs == "todas"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico %in% especies_pesquisa) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria) %>%
        tidyr::complete(uf, tidyr::nesting(nome_cientifico, nome_cientifico_subsp),
                        fill = list(categoria = NA_character_))
    }
    else if(ufs == "UF"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico %in% especies_pesquisa) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria) %>%
        tidyr::complete(uf, tidyr::nesting(nome_cientifico, nome_cientifico_subsp),
                        fill = list(categoria = NA_character_)) %>%
        dplyr::filter(uf != "Brasil")
    }
    else if(ufs == "BR"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico %in% especies_pesquisa,
                      uf == "Brasil") %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }
    else{
      result <- ameaca %>%
        dplyr::filter(nome_cientifico %in% especies_pesquisa,
                      uf %in% ufs) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }
  }
  )

  if(tabela == F){
    return(result)
  }

  else{
    result %>%
      tidyr::pivot_wider(.,
                         names_from = "uf",
                         values_from = "categoria",
                         values_fill = list(~ NA_character_)) %>%
      dplyr::select(nome_cientifico, nome_cientifico_subsp, order(colnames(.)))
  }
}
