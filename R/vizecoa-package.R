#' vizecoa: Paleta de Cores Ecoa para ggplot2
#'
#' O pacote vizecoa fornece uma paleta de cores personalizada da Ecoa
#' Consultoria Economica e funcoes para integracao com ggplot2.
#'
#' @section Funcoes principais:
#' \describe{
#'   \item{\code{\link{cores_ecoa}}}{Vetor com as 4 cores base da Ecoa}
#'   \item{\code{\link{paleta_ecoa}}}{Funcao para gerar paletas continuas}
#'   \item{\code{\link{scale_fill_ecoa}}}{Escala de preenchimento continua}
#'   \item{\code{\link{scale_color_ecoa}}}{Escala de cor continua}
#'   \item{\code{\link{scale_fill_ecoa_d}}}{Escala de preenchimento discreta}
#'   \item{\code{\link{scale_color_ecoa_d}}}{Escala de cor discreta}
#'   \item{\code{\link{mostrar_paleta}}}{Visualizar a paleta}
#'   \item{\code{\link{hex_ecoa}}}{Obter codigos hex}
#' }
#'
#' @docType package
#' @name vizecoa-package
#' @aliases vizecoa
#' @keywords internal
"_PACKAGE"

# Evitar NOTE sobre variaveis globais no ggplot2
utils::globalVariables(c(".data"))
