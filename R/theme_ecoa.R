#' Tema padrao Ecoa para ggplot2
#'
#' Aplica o padrao visual dos graficos da Ecoa: eixo Y comecando do zero,
#' apenas grade horizontal em cinza-claro, linha da origem do eixo X mais
#' escura e grossa, sem linha nem ticks no eixo Y, titulo em negrito,
#' subtitulo em fonte normal, caption em cinza no canto inferior esquerdo,
#' texto do eixo X em negrito, legenda embaixo sem titulo e numeros em
#' formato brasileiro (milhar com ponto, decimal com virgula).
#'
#' O tema ja inclui a \code{scale_y_continuous} padrao. Ajuste o eixo Y
#' pelos argumentos \code{y_*}, e nao adicionando outra escala:
#' \itemize{
#'   \item Barras com rotulos em cima:
#'     \code{theme_ecoa(y_expand = ggplot2::expansion(mult = c(0, 0.1)))}
#'   \item Linhas partindo do zero:
#'     \code{theme_ecoa(y_limits = c(0, NA),
#'                      y_expand = ggplot2::expansion(mult = c(0, 0.05)))}
#'   \item Valores negativos:
#'     \code{theme_ecoa(y_expand = ggplot2::expansion(mult = c(0.08, 0.12)))}
#'     mais \code{geom_hline(yintercept = 0)}
#'   \item Eixo em percentual:
#'     \code{theme_ecoa(y_labels = scales::label_percent(decimal.mark = ","))}
#' }
#'
#' Para graficos de barras horizontais (eixo continuo no X), nao use este
#' tema; ajuste o tema manualmente conforme o Guia de Uso do pacote.
#'
#' @param base_size Tamanho base da fonte (padrao: 12).
#' @param y_limits Limites do eixo Y (padrao: NULL, automatico).
#' @param y_breaks Quebras do eixo Y (padrao: automatico).
#' @param y_labels Funcao de formatacao dos rotulos do eixo Y
#'   (padrao: numeros em formato brasileiro).
#' @param y_expand Expansao do eixo Y (padrao: sem folga, grafico
#'   comecando do zero).
#'
#' @return Uma lista com o tema e a escala Y, que pode ser adicionada a um
#'   ggplot com \code{+}.
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(
#'   ano   = factor(2020:2024),
#'   valor = c(23000, 31000, 45000, 52000, 61000)
#' )
#'
#' # Barras com rotulos: folga extra no topo
#' ggplot(df, aes(x = ano, y = valor)) +
#'   geom_col(fill = cores_ecoa[1], width = 0.72) +
#'   geom_text(aes(label = valor), vjust = -0.4, fontface = "bold") +
#'   labs(title = "Titulo em negrito", subtitle = "Subtitulo normal",
#'        caption = "Fonte: RAIS. Elaboracao: Ecoa.", x = NULL, y = NULL) +
#'   theme_ecoa(y_expand = expansion(mult = c(0, 0.1)))
#'
#' @importFrom ggplot2 %+replace%
#' @export
theme_ecoa <- function(base_size = 12,
                       y_limits  = NULL,
                       y_breaks  = ggplot2::waiver(),
                       y_labels  = scales::label_number(big.mark = ".", decimal.mark = ","),
                       y_expand  = ggplot2::expansion(mult = c(0, 0))) {
  list(
    ggplot2::theme_classic(base_size = base_size) %+replace%
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_line(color = "gray85", linewidth = 0.75),
        panel.grid.minor.y = ggplot2::element_blank(),
        axis.line.y        = ggplot2::element_blank(),
        axis.ticks.y       = ggplot2::element_blank(),
        axis.line.x        = ggplot2::element_line(linetype = "solid", linewidth = 0.9),
        axis.ticks         = ggplot2::element_line(),
        axis.text.x        = ggplot2::element_text(face = "bold"),
        legend.title       = ggplot2::element_blank(),
        legend.position    = "bottom",
        plot.title         = ggplot2::element_text(face = "bold", size = base_size + 2, hjust = 0),
        plot.subtitle      = ggplot2::element_text(hjust = 0),
        plot.caption       = ggplot2::element_text(hjust = 0, colour = "grey40", size = base_size - 3)
      ),
    ggplot2::scale_y_continuous(
      limits = y_limits,
      breaks = y_breaks,
      labels = y_labels,
      expand = y_expand
    )
  )
}
