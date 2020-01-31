#' ameacabr
#'
#' Avalia os status de ameaça das espécies da fauna brasileiras, incluindo as listas estaduais do país
#'
#' @param x Vetor contendo as espécies a serem avaliadas.
#' @param ufs Estados a serem pesquisados.
#' @param subsp O vetor das espécies contempla subespécies?
#' @param tabela O resultado gerado deve estar em formato de tabela?
#'
#' @author Rubem Dornas \email{(rapdornas@@gmail.com)}
#'
#' @details
#' **AVISO**: Várias das bases de dados utilizadas estão defasadas em termos taxonômicos ou mesmo na utilização padrão das siglas de categoria de ameaca. Na medida do possível, faço alterações, mas não detenho conhecimento de toda a fauna para realizar substituições da nomenclatura científica. Use o pacote com cautela e redobre a atenção aos resultados. Se encontrar erros, me mande um e-mail para que eu possa corrigir.
#'
#' * **nome_cientifico**: Nome científico da espécie.
#' * **nome_cientifico_subsp**: Nome científico da espécie, podendo ou não conter a subespécie elencada na lista vermelha.
#' * **categoria**: Categoria de ameaça da espécie.
#'
#' @importFrom magrittr "%>%"
#'
#' @export

ameacabr <- function(x, ufs, subsp = F, tabela = T){

  if(x == "todas"){
    especies_pesquisa <- unique(ameaca$nome_cientifico)
  }
  else{
    especies_pesquisa <- unique(x)
  }

  # UF <- ameaca %>%
  #   dplyr::filter(uf != "Brasil") %>%
  #   dplyr::pull(.)

  todas <- ameaca %>%
    dplyr::distinct(uf) %>%
    dplyr::pull(.)

  suppressWarnings(
  if(subsp == T){
    if(ufs == "todas"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa | nome_cientifico %in% especies_pesquisa,
                      uf %in% todas) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }
    else if(ufs == "UF"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico_subsp %in% especies_pesquisa | nome_cientifico %in% especies_pesquisa,
                      uf != "Brasil") %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
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
        dplyr::filter(nome_cientifico %in% especies_pesquisa,
                      uf %in% todas) %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
    }
    else if(ufs == "UF"){
      result <- ameaca %>%
        dplyr::filter(nome_cientifico %in% especies_pesquisa,
                      uf != "Brasil") %>%
        dplyr::select(uf, nome_cientifico, nome_cientifico_subsp, categoria)
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
