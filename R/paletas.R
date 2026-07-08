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

#' Cores da Ecoa com tons de cinza
#'
#' Variacao da paleta Ecoa com tons de cinza na transicao entre o roxo e o
#' laranja. Indicada para graficos com mais categorias, em que a paleta
#' original geraria cores intermediarias pouco distinguiveis.
#'
#' @format Um vetor de caracteres com 6 codigos hexadecimais:
#' \describe{
#'   \item{#4a3549}{Roxo escuro}
#'   \item{#aa6aef}{Roxo claro}
#'   \item{#948b9c}{Cinza arroxeado}
#'   \item{#cfc9c6}{Cinza claro}
#'   \item{#f2aa84}{Pessego}
#'   \item{#FF8C00}{Laranja}
#' }
#'
#' @examples
#' cores_ecoa_cinza
#' plot(1:6, col = cores_ecoa_cinza, pch = 19, cex = 3)
#'
#' @export
cores_ecoa_cinza <- c(
  "#4a3549",   # roxo escuro
  "#aa6aef",   # roxo claro
  "#948b9c",   # cinza arroxeado
  "#cfc9c6",   # cinza claro
  "#f2aa84",   # pessego
  "#FF8C00"    # laranja
)

#' Conjunto de paletas Ecoa
#'
#' Lista nomeada com todas as paletas de cores da Ecoa, no estilo do pacote
#' RColorBrewer. Consulte \code{\link{paletas_ecoa_info}} para o tipo e o
#' numero de cores de cada paleta, e \code{\link{mostrar_paletas}} para
#' visualizar todas.
#'
#' @format Uma lista nomeada de vetores de codigos hexadecimais:
#' \describe{
#'   \item{ecoa}{Paleta padrao: roxos e laranjas (4 cores)}
#'   \item{cinza}{Padrao com tons de cinza na transicao (6 cores)}
#'   \item{completa}{Qualitativa com roxos, azuis, lilas e laranjas do tema
#'     institucional, ordenada como espectro continuo (frios -> quentes) --
#'     para graficos com muitas categorias (10 cores)}
#'   \item{roxos}{Sequencial de tons de roxo, do escuro ao claro (5 cores)}
#'   \item{lilas}{Sequencial de tons de lilas/magenta (5 cores)}
#'   \item{azuis}{Sequencial de tons de azul (5 cores)}
#'   \item{laranjas}{Sequencial de tons de laranja (5 cores)}
#'   \item{frios}{Tons frios: azuis a lilas -- convencao para oferta/total (4 cores)}
#'   \item{quentes}{Tons quentes: laranjas a pessego -- convencao para demanda/destaque (4 cores)}
#'   \item{divergente}{Divergente: roxo, neutro claro e laranja (5 cores)}
#' }
#'
#' @examples
#' names(paletas_ecoa)
#' paletas_ecoa$roxos
#'
#' @export
paletas_ecoa <- list(
  ecoa       = c("#4A3549", "#AA6AEF", "#F2AA84", "#FF8C00"),
  cinza      = c("#4A3549", "#AA6AEF", "#948B9C", "#CFC9C6", "#F2AA84", "#FF8C00"),
  completa   = c("#4A3549", "#435570", "#7779B7", "#AA6AEF", "#B580D1",
                 "#A02B93", "#BE6611", "#FF8C00", "#FFB25B", "#F2AA84"),
  roxos      = c("#3A2A44", "#6A4590", "#AA6AEF", "#C9A2F2", "#E8DAF9"),
  lilas      = c("#5C1B55", "#A02B93", "#B580D1", "#D9B3E8", "#F2E4F9"),
  azuis      = c("#2C3A50", "#435570", "#7779B7", "#A9ABD1", "#D8D9EC"),
  laranjas   = c("#8A4A0C", "#BE6611", "#FF8C00", "#FFB25B", "#FFD9AC"),
  frios      = c("#435570", "#7779B7", "#AA6AEF", "#B580D1"),
  quentes    = c("#BE6611", "#FF8C00", "#FFB25B", "#F2AA84"),
  divergente = c("#4A3549", "#AA6AEF", "#F2F0EE", "#FFB25B", "#BE6611")
)

#' Informacoes sobre as paletas Ecoa
#'
#' Data frame com o tipo e o numero de cores de cada paleta de
#' \code{\link{paletas_ecoa}}, no estilo de \code{RColorBrewer::brewer.pal.info}.
#'
#' Tipos:
#' \itemize{
#'   \item \strong{principal}: paletas multiuso, interpoladas;
#'   \item \strong{qualitativa}: cores exatas para categorias (interpola so
#'     alem do maximo);
#'   \item \strong{sequencial}: gradiente do escuro ao claro, para dados ordenados;
#'   \item \strong{divergente}: dois extremos com neutro no centro, para
#'     desvios em torno de um valor central.
#' }
#'
#' @format Um data frame com as colunas \code{paleta}, \code{tipo} e
#'   \code{n_cores}.
#'
#' @examples
#' paletas_ecoa_info
#'
#' @export
paletas_ecoa_info <- data.frame(
  paleta  = names(paletas_ecoa),
  tipo    = c("principal", "principal", "qualitativa",
              "sequencial", "sequencial", "sequencial", "sequencial",
              "sequencial", "sequencial", "divergente"),
  n_cores = lengths(paletas_ecoa),
  row.names = NULL
)

#' Funcao de paleta Ecoa
#'
#' Gera n cores de uma das paletas Ecoa (veja \code{\link{paletas_ecoa}}).
#' Paletas do tipo qualitativa (\code{"completa"}) retornam cores exatas,
#' selecionadas em posicoes igualmente espacadas ao longo do espectro da
#' paleta (garantindo bom contraste mesmo com poucas categorias), enquanto
#' \code{n} nao excede o total disponivel; as demais paletas sao interpoladas
#' por \code{colorRampPalette}.
#'
#' @param n Numero de cores a serem geradas.
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}). Veja
#'   \code{names(paletas_ecoa)}.
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
#'
#' @return Um vetor de caracteres com codigos hexadecimais das cores.
#'
#' @examples
#' # Paleta padrao
#' paleta_ecoa(10)
#'
#' # Outras paletas
#' paleta_ecoa(8, paleta = "completa")
#' paleta_ecoa(4, paleta = "roxos")
#' paleta_ecoa(5, paleta = "azuis")
#'
#' # Usar em um grafico base
#' barplot(1:8, col = paleta_ecoa(8, paleta = "laranjas"))
#'
#' @export
paleta_ecoa <- function(n, paleta = "ecoa", cinza = FALSE) {
  if (cinza) paleta <- "cinza"
  paleta <- match.arg(paleta, names(paletas_ecoa))
  cores  <- paletas_ecoa[[paleta]]
  tipo   <- paletas_ecoa_info$tipo[paletas_ecoa_info$paleta == paleta]
  if (tipo == "qualitativa" && n <= length(cores)) {
    return(cores[round(seq(1, length(cores), length.out = n))])
  }
  grDevices::colorRampPalette(cores)(n)
}

#' Escala de preenchimento continua Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de preenchimento continua
#' em graficos ggplot2.
#'
#' @param n Numero de cores para o gradiente (padrao: 256).
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}). Para escalas
#'   continuas, as sequenciais (\code{"roxos"}, \code{"azuis"}, ...) e a
#'   \code{"divergente"} sao as mais indicadas.
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
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
#' # Com uma paleta sequencial
#' ggplot(df, aes(x = x, y = y, fill = z)) +
#'   geom_tile() +
#'   scale_fill_ecoa(paleta = "roxos")
#'
#' @export
scale_fill_ecoa <- function(n = 256, paleta = "ecoa", cinza = FALSE, ...) {
  ggplot2::scale_fill_gradientn(colors = paleta_ecoa(n, paleta = paleta, cinza = cinza), ...)
}

#' Escala de cor continua Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de cor continua
#' em graficos ggplot2.
#'
#' @param n Numero de cores para o gradiente (padrao: 256).
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}). Para escalas
#'   continuas, as sequenciais (\code{"roxos"}, \code{"azuis"}, ...) e a
#'   \code{"divergente"} sao as mais indicadas.
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
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
scale_color_ecoa <- function(n = 256, paleta = "ecoa", cinza = FALSE, ...) {
  ggplot2::scale_color_gradientn(colors = paleta_ecoa(n, paleta = paleta, cinza = cinza), ...)
}

#' Escala de preenchimento discreta Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de preenchimento discreta
#' em graficos ggplot2.
#'
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}). Para muitas
#'   categorias, use \code{"completa"} ou \code{"cinza"}.
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
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
#' # Para muitas categorias: paleta qualitativa completa
#' ggplot(df, aes(x = categoria, y = valor, fill = categoria)) +
#'   geom_col() +
#'   scale_fill_ecoa_d(paleta = "completa")
#'
#' @export
scale_fill_ecoa_d <- function(paleta = "ecoa", cinza = FALSE, ...) {
  ggplot2::discrete_scale("fill",
                          palette = function(n) paleta_ecoa(n, paleta = paleta, cinza = cinza), ...)
}

#' Escala de cor discreta Ecoa para ggplot2
#'
#' Aplica a paleta de cores Ecoa como escala de cor discreta
#' em graficos ggplot2.
#'
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}). Para muitas
#'   categorias, use \code{"completa"} ou \code{"cinza"}.
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
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
scale_color_ecoa_d <- function(paleta = "ecoa", cinza = FALSE, ...) {
  ggplot2::discrete_scale("colour",
                          palette = function(n) paleta_ecoa(n, paleta = paleta, cinza = cinza), ...)
}

#' Visualizar paleta discreta
#'
#' Cria um grafico mostrando n cores da paleta Ecoa com seus codigos hex.
#'
#' @param n Numero de cores a serem exibidas.
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}).
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
#'
#' @return Um objeto ggplot.
#'
#' @examples
#' # Mostrar 4 cores da paleta padrao
#' mostrar_paleta(4)
#'
#' # Mostrar 8 cores da paleta completa
#' mostrar_paleta(8, paleta = "completa")
#'
#' @export
mostrar_paleta <- function(n, paleta = "ecoa", cinza = FALSE) {
  cores <- paleta_ecoa(n, paleta = paleta, cinza = cinza)
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
                   text = ggplot2::element_text(face = "bold", size = 15)) +
    ggplot2::labs(title = paste0(n, " cores"))
}

#' Obter codigos hex da paleta
#'
#' Retorna os codigos hexadecimais para n cores da paleta Ecoa.
#' Util para usar as cores em PowerPoint ou outras aplicacoes.
#'
#' @param n Numero de cores desejadas.
#' @param paleta Nome da paleta (padrao: \code{"ecoa"}).
#' @param cinza Se TRUE, atalho para \code{paleta = "cinza"} (padrao: FALSE).
#' @param print Se TRUE (padrao), imprime os codigos no console.
#'
#' @return Um vetor de caracteres com os codigos hex (invisivelmente).
#'
#' @examples
#' # Obter 5 cores
#' hex_ecoa(5)
#'
#' # Obter 8 cores da paleta completa
#' hex_ecoa(8, paleta = "completa")
#'
#' # Obter 10 cores sem imprimir
#' cores <- hex_ecoa(10, print = FALSE)
#'
#' @export
hex_ecoa <- function(n, paleta = "ecoa", cinza = FALSE, print = TRUE) {
  cores <- paleta_ecoa(n, paleta = paleta, cinza = cinza)
  if (print) {
    cat(paste0(n, " cores (", if (cinza) "cinza" else paleta, "): ",
               paste(cores, collapse = ", "), "\n"))
  }
  invisible(cores)
}

#' Visualizar todas as paletas Ecoa
#'
#' Mostra todas as paletas do pacote em um unico grafico, no estilo de
#' \code{RColorBrewer::display.brewer.all()}.
#'
#' @return Um objeto ggplot.
#'
#' @examples
#' mostrar_paletas()
#'
#' @export
mostrar_paletas <- function() {
  df <- do.call(rbind, lapply(names(paletas_ecoa), function(nm) {
    cores <- paletas_ecoa[[nm]]
    data.frame(paleta = nm, pos = seq_along(cores), cor = cores)
  }))
  df$paleta <- factor(df$paleta, levels = rev(names(paletas_ecoa)))

  ggplot2::ggplot(df, ggplot2::aes(x = .data$pos, y = .data$paleta, fill = .data$cor)) +
    ggplot2::geom_tile(color = "white", linewidth = 1.5, width = 0.95, height = 0.8) +
    ggplot2::scale_fill_identity() +
    ggplot2::theme_void() +
    ggplot2::theme(
      axis.text.y = ggplot2::element_text(size = 11, face = "bold", hjust = 1),
      plot.title  = ggplot2::element_text(hjust = 0.5, size = 13, face = "bold"),
      plot.margin = ggplot2::margin(10, 20, 10, 10)
    ) +
    ggplot2::labs(title = "Paletas Ecoa")
}
