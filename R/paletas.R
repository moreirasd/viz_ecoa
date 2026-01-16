#' Cores base da Ecoa Consultoria
#'
#' Vetor com as 4 cores institucionais da Ecoa Consultoria Economica.
#'
#' @format Um vetor de caracteres com 4 codigos hexadecimais:
#' \describe{
#'   \item{#4a3549}{Roxo escuro}
#'   \item{#aa6aef}{Roxo claro}
#'   \item{#f2aa84}{Pessego}
#'   \item{#FF8C00}{Laranja}
#' }
#'
#' @examples
#' cores_ecoa
#' plot(1:4, col = cores_ecoa, pch = 19, cex = 3)
#'
#' @export
cores_ecoa <- c(
  "#4a3549",   # roxo escuro
  "#aa6aef",   # roxo claro
  "#f2aa84",   # pessego
  "#FF8C00"    # laranja
)

#' Funcao de paleta continua Ecoa
#'
#' Gera uma funcao que interpola as cores da Ecoa para criar gradientes.
#'
#' @param n Numero de cores a serem geradas na paleta.
#'
#' @return Um vetor de caracteres com codigos hexadecimais das cores.
#'
#' @examples
#' # Gerar 10 cores
#' paleta_ecoa(10)
#'
#' # Usar em um grafico base
#' barplot(1:8, col = paleta_ecoa(8))
#'
#' @export
paleta_ecoa <- grDevices::colorRampPalette(cores_ecoa)

#' Escala de preenchimento continua Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de preenchimento continua
#' em graficos ggplot2.
#'
#' @param n Numero de cores para o gradiente (padrao: 256).
#' @param ... Argumentos adicionais passados para
#'   \code{\link[ggplot2]{scale_fill_gradientn}}.
#'
#' @return Um objeto de escala ggplot2.
#'
#' @examples
#' library(ggplot2)
#'
#' # Heatmap
#' df <- expand.grid(x = 1:10, y = 1:10)
#' df$z <- df$x * df$y
#'
#' ggplot(df, aes(x = x, y = y, fill = z)) +
#'   geom_tile() +
#'   scale_fill_ecoa()
#'
#' @export
scale_fill_ecoa <- function(n = 256, ...) {
  ggplot2::scale_fill_gradientn(colors = paleta_ecoa(n), ...)
}

#' Escala de cor continua Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de cor continua
#' em graficos ggplot2.
#'
#' @param n Numero de cores para o gradiente (padrao: 256).
#' @param ... Argumentos adicionais passados para
#'   \code{\link[ggplot2]{scale_color_gradientn}}.
#'
#' @return Um objeto de escala ggplot2.
#'
#' @examples
#' library(ggplot2)
#'
#' # Scatter plot com cor continua
#' df <- data.frame(x = rnorm(100), y = rnorm(100))
#' df$dist <- sqrt(df$x^2 + df$y^2)
#'
#' ggplot(df, aes(x = x, y = y, color = dist)) +
#'   geom_point(size = 3) +
#'   scale_color_ecoa()
#'
#' @export
scale_color_ecoa <- function(n = 256, ...) {
  ggplot2::scale_color_gradientn(colors = paleta_ecoa(n), ...)
}

#' Escala de preenchimento discreta Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de preenchimento discreta
#' em graficos ggplot2.
#'
#' @param ... Argumentos adicionais passados para
#'   \code{\link[ggplot2]{discrete_scale}}.
#'
#' @return Um objeto de escala ggplot2.
#'
#' @examples
#' library(ggplot2)
#'
#' # Grafico de barras
#' df <- data.frame(
#'   categoria = LETTERS[1:6],
#'   valor = c(23, 45, 67, 34, 89, 56)
#' )
#'
#' ggplot(df, aes(x = categoria, y = valor, fill = categoria)) +
#'   geom_col() +
#'   scale_fill_ecoa_d()
#'
#' @export
scale_fill_ecoa_d <- function(...) {
  ggplot2::discrete_scale("fill", "ecoa", palette = function(n) paleta_ecoa(n), ...)
}

#' Escala de cor discreta Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de cor discreta
#' em graficos ggplot2.
#'
#' @param ... Argumentos adicionais passados para
#'   \code{\link[ggplot2]{discrete_scale}}.
#'
#' @return Um objeto de escala ggplot2.
#'
#' @examples
#' library(ggplot2)
#'
#' # Scatter plot com grupos
#' df <- data.frame(
#'   x = rnorm(60),
#'   y = rnorm(60),
#'   grupo = rep(c("A", "B", "C"), each = 20)
#' )
#'
#' ggplot(df, aes(x = x, y = y, color = grupo)) +
#'   geom_point(size = 3) +
#'   scale_color_ecoa_d()
#'
#' @export
scale_color_ecoa_d <- function(...) {
  ggplot2::discrete_scale("colour", "ecoa", palette = function(n) paleta_ecoa(n), ...)
}

#' Visualizar paleta discreta
#'
#' Cria um grafico mostrando n cores da paleta Ecoa com seus codigos hex.
#'
#' @param n Numero de cores a serem exibidas.
#'
#' @return Um objeto ggplot.
#'
#' @examples
#' # Mostrar 4 cores
#' mostrar_paleta(4)
#'
#' # Mostrar 8 cores
#' mostrar_paleta(8)
#'
#' @export
mostrar_paleta <- function(n) {
  cores <- paleta_ecoa(n)
  df <- data.frame(
    x = factor(1:n),
    y = 1,
    cor = cores
  )

  ggplot2::ggplot(df, ggplot2::aes(x = .data$x, y = .data$y, fill = .data$cor)) +
    ggplot2::geom_tile(color = "white", linewidth = 2) +
    ggplot2::scale_fill_identity() +
    ggplot2::geom_text(ggplot2::aes(label = .data$cor), color = "white",
                       size = 3.5, fontface = "bold") +
    ggplot2::theme_void() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, size = 11),
                   plot.margin = ggplot2::margin(5, 10, 5, 10),
                   text = element_text(face = "bold", size = 15)) +
    ggplot2::labs(title = paste0(n, " cores"))
}

#' Obter codigos hex da paleta
#'
#' Retorna os codigos hexadecimais para n cores da paleta Ecoa.
#' Util para usar as cores em PowerPoint ou outras aplicacoes.
#'
#' @param n Numero de cores desejadas.
#' @param print Se TRUE (padrao), imprime os codigos no console.
#'
#' @return Um vetor de caracteres com os codigos hex (invisivelmente).
#'
#' @examples
#' # Obter 5 cores
#' hex_ecoa(5)
#'
#' # Obter 10 cores sem imprimir
#' cores <- hex_ecoa(10, print = FALSE)
#'
#' @export
hex_ecoa <- function(n, print = TRUE) {
  cores <- paleta_ecoa(n)
  if (print) {
    cat(paste0(n, " cores: ", paste(cores, collapse = ", "), "\n"))
  }
  invisible(cores)
}
