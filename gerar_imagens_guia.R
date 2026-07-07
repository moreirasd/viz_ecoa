# Script para gerar as imagens do GUIA_DE_USO.md
# Execute este script na raiz do repositorio.
# Os blocos de codigo abaixo sao os mesmos apresentados no guia.

library(ggplot2)
library(dplyr)
library(forcats)
library(ggrepel)
library(scales)

# Carregar as funcoes do pacote (inclui theme_ecoa)
source("R/paletas.R")
source("R/theme_ecoa.R")

if (!dir.exists("man/figures/guia")) {
  dir.create("man/figures/guia", recursive = TRUE)
}

# Helper de formatacao pt-BR
fmt <- function(x) trimws(format(round(x), big.mark = ".", decimal.mark = ",", scientific = FALSE))

# Exemplo 1: linha com rotulos no fim ---------------------------------------

set.seed(42)
anos      <- 2014:2024
segmentos <- c("Desenvolvimento\nsob Encomenda", "Tratamento\nde Dados",
               "Consultoria\nem TI", "Portais e\nConteúdo")
base_vals <- c(52000, 18000, 30000, 9000)
cresc     <- c(1.09, 1.14, 1.04, 1.02)

df_linha <- do.call(rbind, lapply(seq_along(segmentos), function(i) {
  data.frame(
    ano      = anos,
    segmento = segmentos[i],
    valor    = round(base_vals[i] * cresc[i]^(anos - 2014) * exp(rnorm(length(anos), 0, 0.02)))
  )
}))

dados_label <- df_linha |>
  filter(ano == max(ano)) |>
  mutate(label = paste0(segmento, "\n(", fmt(valor), ")"))

p1 <- df_linha |>
  ggplot(aes(x = ano, y = valor, colour = segmento)) +
  geom_line(linewidth = 0.9) +
  geom_text_repel(
    data        = dados_label,
    aes(label   = label),
    nudge_x     = 0.5,
    hjust       = 0,
    direction   = "y",
    size        = 3,
    fontface    = "bold",
    lineheight  = 0.85,
    show.legend = FALSE
  ) +
  scale_color_ecoa_d() +
  scale_x_continuous(
    breaks = seq(2014, 2024, 2),
    expand = expansion(mult = c(0.02, 0.22))
  ) +
  coord_cartesian(clip = "off") +
  labs(
    x = NULL, y = "Nº de Vínculos",
    title    = "Vínculos formais por segmento",
    subtitle = "2014-2024 | Dados fictícios para ilustração",
    caption  = "Fonte: RAIS. Elaboração: Ecoa."
  ) +
  theme_ecoa(y_limits = c(0, NA), y_expand = expansion(mult = c(0, 0.05))) +
  theme(legend.position = "none")

ggsave("man/figures/guia/guia_linha_rotulos.png", p1, width = 8.5, height = 5.2, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/guia/guia_linha_rotulos.png\n")

# Exemplo 2: barras com rotulos ----------------------------------------------

df_deficit <- data.frame(
  ano     = 2015:2024,
  deficit = cumsum(c(9000, 11000, 12500, 15000, 17000, 16000, 21000, 26000, 24000, 22000))
)

p2 <- df_deficit |>
  ggplot(aes(x = factor(ano), y = deficit)) +
  geom_col(fill = cores_ecoa[1], width = 0.72) +
  geom_text(aes(label = fmt(deficit)), vjust = -0.4, size = 3, fontface = "bold") +
  labs(
    x = NULL, y = "Profissionais",
    title    = "Déficit acumulado de formação",
    subtitle = "2015-2024 | Dados fictícios para ilustração",
    caption  = "Fonte: RAIS e INEP. Elaboração: Ecoa."
  ) +
  theme_ecoa(y_expand = expansion(mult = c(0, 0.1)))

ggsave("man/figures/guia/guia_barras_rotulos.png", p2, width = 8, height = 5, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/guia/guia_barras_rotulos.png\n")

# Exemplo 3: barras horizontais ordenadas com destaque ------------------------

df_setores <- data.frame(
  setor    = c("Serviços de TI", "Educação", "Serviços Financeiros",
               "Telecomunicações", "Comércio Varejista", "Apoio Administrativo",
               "Saúde Humana", "Energia e Utilidades", "Construção", "Comércio Atacadista"),
  vinculos = c(148000, 61000, 54000, 47000, 39000, 33000, 27000, 24000, 21000, 18000)
) |>
  mutate(
    tipo  = ifelse(setor == "Serviços de TI", "Setor de Dados", "Outros Setores"),
    perc  = vinculos / sum(vinculos),
    setor = fct_reorder(setor, vinculos),
    label = paste0(fmt(vinculos), " (", percent(perc, accuracy = 0.1, decimal.mark = ","), ")")
  )

p3 <- df_setores |>
  ggplot(aes(x = vinculos, y = setor, fill = tipo)) +
  geom_col() +
  geom_text(aes(label = label), hjust = -0.05, size = 3.2, fontface = "bold") +
  scale_fill_manual(values = c("Setor de Dados" = "#4a3549", "Outros Setores" = "#FF8C00")) +
  scale_x_continuous(
    labels = label_number(big.mark = ".", decimal.mark = ","),
    expand = expansion(mult = c(0, 0.30))
  ) +
  labs(
    x = "Número de Vínculos", y = NULL, fill = NULL,
    title    = "Demanda por profissionais de dados por setor",
    subtitle = "2024 | Dados fictícios para ilustração",
    caption  = "Fonte: RAIS. Elaboração: Ecoa."
  ) +
  theme_minimal() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.line.x        = element_line(linetype = "solid", linewidth = 0.9),
    axis.line.y        = element_blank(),
    axis.ticks.x       = element_line(),
    axis.ticks.y       = element_blank(),
    axis.text.x        = element_text(face = "bold"),
    legend.title       = element_blank(),
    legend.position    = "bottom",
    plot.title         = element_text(face = "bold"),
    plot.caption       = element_text(hjust = 0, colour = "grey40"),
    plot.margin        = margin(t = 10, r = 40, b = 10, l = 10)
  )

ggsave("man/figures/guia/guia_barras_horizontais.png", p3, width = 8.5, height = 5.2, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/guia/guia_barras_horizontais.png\n")

# Exemplo 4: barras agrupadas com faixa sombreada -----------------------------

pal        <- paleta_ecoa(5)
col_niveis <- c("Superior" = pal[1], "Técnico" = pal[5])

df_gap <- data.frame(
  ano    = rep(2015:2024, times = 2),
  nivel  = rep(c("Superior", "Técnico"), each = 10),
  lacuna = c( 4200,  5100,  6300,  7800,  9500,  8200, 14500, 18200, 15800, 13400,
             -1200,   800,  1500,  2900,  4100,  3600,  7800,  9600,  8100,  6400)
)

labels_fim <- df_gap |> filter(ano == max(ano))

p4 <- df_gap |>
  ggplot(aes(x = factor(ano), y = lacuna, fill = nivel)) +
  annotate("rect", xmin = 6.5, xmax = 8.5, ymin = -Inf, ymax = Inf,
           fill = "grey88", alpha = 0.5) +
  geom_col(position = position_dodge(width = 0.75), width = 0.68) +
  geom_hline(yintercept = 0, linewidth = 0.4, colour = "grey40") +
  geom_text(
    data = labels_fim,
    aes(label = fmt(lacuna)),
    position = position_dodge(width = 0.75),
    vjust = -0.4, size = 3, fontface = "bold", show.legend = FALSE
  ) +
  scale_fill_manual(values = col_niveis) +
  labs(
    x = NULL, y = "Profissionais/ano",
    title    = "Lacuna anual (demanda − oferta) por nível de formação",
    subtitle = "Valores positivos = déficit no ano. Faixa cinza = boom 2021-22.\nDados fictícios para ilustração",
    caption  = "Fonte: RAIS e INEP. Elaboração: Ecoa."
  ) +
  theme_ecoa(y_expand = expansion(mult = c(0.08, 0.12)))

ggsave("man/figures/guia/guia_barras_agrupadas.png", p4, width = 8.5, height = 5.2, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/guia/guia_barras_agrupadas.png\n")

# Exemplo 5: anotacoes (ribbon + colchete) ------------------------------------

anos_inf <- 2015:2024
formais  <- round(80000 * 1.07^(anos_inf - 2015))
taxa     <- seq(0.36, 0.29, length.out = length(anos_inf))

df_inf <- data.frame(
  ano     = anos_inf,
  formais = formais,
  total   = round(formais / (1 - taxa))
) |>
  mutate(taxa = (total - formais) / total)

fim <- df_inf |> filter(ano == max(ano))

p5 <- df_inf |>
  ggplot(aes(x = ano)) +
  geom_ribbon(aes(ymin = formais, ymax = total, fill = "Informalidade"), alpha = 0.30) +
  geom_line(aes(y = total,   colour = "Total (formais + não-formais)"), linewidth = 1.1) +
  geom_line(aes(y = formais, colour = "Formais (RAIS)"), linewidth = 1.1) +
  # Rotulos nas pontas das series
  geom_text(
    data = df_inf |> filter(ano %in% range(ano)),
    aes(y = total, label = fmt(total),
        hjust = if_else(ano == min(ano), 1.2, -0.2)),
    vjust = -0.9, colour = "#4a3549", size = 3.5, fontface = "bold"
  ) +
  geom_text(
    data = df_inf |> filter(ano %in% range(ano)),
    aes(y = formais, label = fmt(formais),
        hjust = if_else(ano == min(ano), 1.2, -0.2)),
    vjust = 1.8, colour = "#FF8C00", size = 3.5, fontface = "bold"
  ) +
  # Colchete anotando a diferenca no ultimo ano
  annotate("segment",
           x = fim$ano + 0.45, xend = fim$ano + 0.45,
           y = fim$formais, yend = fim$total, colour = "#4a3549", linewidth = 0.6) +
  annotate("segment",
           x = fim$ano + 0.35, xend = fim$ano + 0.45,
           y = fim$formais, yend = fim$formais, colour = "#4a3549", linewidth = 0.6) +
  annotate("segment",
           x = fim$ano + 0.35, xend = fim$ano + 0.45,
           y = fim$total, yend = fim$total, colour = "#4a3549", linewidth = 0.6) +
  annotate("text",
           x = fim$ano + 0.57,
           y = fim$formais + (fim$total - fim$formais) * 0.5,
           label = paste0("Informalidade\n",
                          label_percent(accuracy = 0.1, decimal.mark = ",")(fim$taxa)),
           hjust = 0, colour = "#4a3549", fontface = "bold", size = 3.3) +
  scale_colour_manual(
    values = c("Total (formais + não-formais)" = "#4a3549",
               "Formais (RAIS)"                = "#FF8C00")
  ) +
  scale_fill_manual(values = c("Informalidade" = "#aa6aef")) +
  scale_x_continuous(
    breaks = anos_inf,
    expand = expansion(mult = c(0.10, 0.18))
  ) +
  coord_cartesian(clip = "off") +
  labs(
    x = NULL, y = "Postos de trabalho", colour = NULL, fill = NULL,
    title    = "Emprego formal e total",
    subtitle = "A área sombreada representa a informalidade estimada.\nDados fictícios para ilustração",
    caption  = "Fonte: RAIS e PNAD Contínua/IBGE. Elaboração: Ecoa."
  ) +
  theme_ecoa(y_limits = c(0, NA), y_expand = expansion(mult = c(0, 0.08)))

ggsave("man/figures/guia/guia_anotacoes.png", p5, width = 9, height = 5.5, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/guia/guia_anotacoes.png\n")

cat("\n--- Todas as imagens do guia foram geradas! ---\n")
