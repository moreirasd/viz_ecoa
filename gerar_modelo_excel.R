# Gera o modelo de graficos Ecoa para Excel: excel/modelo_graficos_ecoa.xlsx
# Os graficos sao nativos do Excel (editaveis): copie a aba ou o grafico para
# o seu arquivo e troque os dados.
# Requer: openxlsx2, mschart, officer

library(openxlsx2)
library(mschart)
library(officer)

# Cores do pacote
source("R/paletas.R")

if (!dir.exists("excel")) dir.create("excel")

roxo_escuro <- "#4A3549"
roxo_claro  <- "#AA6AEF"
pessego     <- "#F2AA84"
laranja     <- "#FF8C00"
cinza_grade <- "#D9D9D9"   # equivalente ao gray85 do R
cinza_fonte <- "#666666"

# Tema padrao Ecoa para graficos do Excel -------------------------------------
# Mesmo padrao do theme_ecoa() do R: so grade horizontal cinza-claro, linha do
# eixo X escura e mais grossa, sem linha no eixo Y, titulo em negrito, texto do
# eixo X em negrito, legenda embaixo.
tema_excel <- mschart_theme(
  main_title        = fp_text(bold = TRUE, font.size = 14),
  axis_title_x      = fp_text(font.size = 11),
  axis_title_y      = fp_text(font.size = 11),
  axis_text_x       = fp_text(bold = TRUE, font.size = 10),
  axis_text_y       = fp_text(font.size = 10),
  axis_ticks_x      = fp_border(color = "#000000", width = 2),
  axis_ticks_y      = fp_border(width = 0),
  grid_major_line_x = fp_border(width = 0),
  grid_major_line_y = fp_border(color = cinza_grade, width = 1),
  grid_minor_line   = fp_border(width = 0),
  legend_text       = fp_text(font.size = 10),
  legend_position   = "b",
  integer_fmt       = "#,##0",
  double_fmt        = "#,##0"
)

fonte_rotulo <- fp_text(bold = TRUE, font.size = 9)

# Workbook ---------------------------------------------------------------------

wb <- wb_workbook(creator = "Ecoa Consultoria Economica")

## Aba 1: Leia-me ---------------------------------------------------------------

wb$add_worksheet("Leia-me", grid_lines = FALSE)

leia_me <- c(
  "Modelo de Graficos Ecoa para Excel",
  "",
  "Como usar:",
  "1. Abra a aba do tipo de grafico desejado (Linha, Colunas, Barras ou Colunas Agrupadas).",
  "2. Copie o grafico (Ctrl+C / Ctrl+V) para o seu arquivo ou apresentacao.",
  "3. Clique com o botao direito no grafico > 'Selecionar Dados' e aponte para os seus dados,",
  "   ou edite a tabela ao lado do grafico (o grafico atualiza sozinho).",
  "4. Ajuste titulo e rotulos. A fonte (caption) fica em uma celula abaixo do grafico:",
  "   'Fonte: ... Elaboracao: Ecoa.' - mantenha alinhada a esquerda, em cinza.",
  "",
  "O padrao Ecoa (mesmo do R / pacote vizecoa):",
  "- Eixo Y comecando do zero, sem folga na base",
  "- Linha da origem do eixo X preta e um pouco mais grossa",
  "- Apenas grade horizontal em cinza-claro; sem grade vertical",
  "- Sem linha nem ticks no eixo Y",
  "- Titulo em negrito; subtitulo em fonte normal (caixa de texto ou celula, se necessario)",
  "- Texto do eixo X em negrito",
  "- Numeros em formato brasileiro (milhar com ponto: #.##0)",
  "- Legenda embaixo, sem titulo - ou rotulos direto nas series",
  "- Rotulos de valores em negrito; anotacoes sao encorajadas",
  "",
  "As cores da paleta estao na aba 'Cores' (copie o codigo hex).",
  "Guia completo: https://github.com/moreirasd/viz_ecoa/blob/main/GUIA_DE_USO.md"
)

wb$add_data(sheet = "Leia-me", x = data.frame(x = leia_me), start_col = 2, start_row = 2, col_names = FALSE)
wb$add_font("Leia-me", dims = "B2", bold = TRUE, size = 16, name = "Calibri")
wb$add_font("Leia-me", dims = "B4", bold = TRUE, size = 11, name = "Calibri")
wb$add_font("Leia-me", dims = "B13", bold = TRUE, size = 11, name = "Calibri")
wb$set_col_widths("Leia-me", cols = 2, widths = 110)

## Aba 2: Cores -------------------------------------------------------------------

wb$add_worksheet("Cores", grid_lines = FALSE)

escrever_paleta <- function(wb, titulo, cores, nomes, linha_inicial) {
  wb$add_data("Cores", x = titulo, start_col = 2, start_row = linha_inicial, col_names = FALSE)
  wb$add_font("Cores", dims = paste0("B", linha_inicial), bold = TRUE, size = 12)
  df <- data.frame(Cor = "", Hex = toupper(cores), Descricao = nomes)
  wb$add_data("Cores", x = df, start_col = 2, start_row = linha_inicial + 1)
  for (i in seq_along(cores)) {
    dims_celula <- paste0("B", linha_inicial + 1 + i)
    wb$add_fill("Cores", dims = dims_celula, color = wb_color(hex = cores[i]))
  }
  invisible(wb)
}

escrever_paleta(wb, "Cores base (4)", cores_ecoa,
                c("Roxo escuro", "Roxo claro", "Pessego", "Laranja"), 2)
escrever_paleta(wb, "Variacao com tons de cinza (6) - para mais categorias", cores_ecoa_cinza,
                c("Roxo escuro", "Roxo claro", "Cinza arroxeado", "Cinza claro", "Pessego", "Laranja"), 9)
escrever_paleta(wb, "Paleta interpolada (8)", paleta_ecoa(8),
                rep("", 8), 17)
wb$set_col_widths("Cores", cols = 2:4, widths = c(10, 12, 50))

## Aba 3: Linha --------------------------------------------------------------------

anos <- 2014:2024
df_linha <- data.frame(
  ano      = rep(as.character(anos), times = 3),
  segmento = rep(c("Desenvolvimento de Software", "Tratamento de Dados", "Consultoria em TI"), each = length(anos)),
  valor    = c(round(52000 * 1.09^(anos - 2014)),
               round(18000 * 1.14^(anos - 2014)),
               round(30000 * 1.04^(anos - 2014)))
)

cores_linha <- c(
  "Desenvolvimento de Software" = roxo_escuro,
  "Tratamento de Dados"         = laranja,
  "Consultoria em TI"           = roxo_claro
)

graf_linha <- ms_linechart(df_linha, x = "ano", y = "valor", group = "segmento") |>
  chart_data_stroke(values = cores_linha) |>
  chart_data_fill(values = cores_linha) |>
  chart_data_symbol(values = "none") |>
  chart_ax_x(major_tick_mark = "out") |>
  chart_ax_y(limit_min = 0, num_fmt = "#,##0", major_tick_mark = "none") |>
  chart_labels(title = "Vinculos formais por segmento", xlab = NULL, ylab = "N de Vinculos") |>
  set_theme(tema_excel)

wb$add_worksheet("Linha", grid_lines = FALSE)
wb$add_data("Linha", x = df_linha, start_col = 1, start_row = 1)
wb$add_mschart(sheet = "Linha", dims = "E2:N22", graph = graf_linha)
wb$add_data("Linha", x = "Fonte: RAIS. Elaboracao: Ecoa.", start_col = 5, start_row = 23, col_names = FALSE)
wb$add_font("Linha", dims = "E23", color = wb_color(hex = cinza_fonte), size = 9)

## Aba 4: Colunas com rotulos --------------------------------------------------------

df_col <- data.frame(
  ano     = as.character(2015:2024),
  deficit = cumsum(c(9000, 11000, 12500, 15000, 17000, 16000, 21000, 26000, 24000, 22000))
)

graf_col <- ms_barchart(df_col, x = "ano", y = "deficit") |>
  chart_settings(dir = "vertical", grouping = "clustered", gap_width = 40) |>
  chart_data_fill(values = roxo_escuro) |>
  chart_data_stroke(values = roxo_escuro) |>
  chart_data_labels(position = "outEnd", num_fmt = "#,##0", show_val = TRUE) |>
  chart_labels_text(fonte_rotulo) |>
  chart_ax_x(major_tick_mark = "out") |>
  chart_ax_y(limit_min = 0, num_fmt = "#,##0", major_tick_mark = "none") |>
  chart_labels(title = "Deficit acumulado de formacao", xlab = NULL, ylab = "Profissionais") |>
  set_theme(tema_excel)

wb$add_worksheet("Colunas", grid_lines = FALSE)
wb$add_data("Colunas", x = df_col, start_col = 1, start_row = 1)
wb$add_mschart(sheet = "Colunas", dims = "D2:M22", graph = graf_col)
wb$add_data("Colunas", x = "Fonte: RAIS e INEP. Elaboracao: Ecoa.", start_col = 4, start_row = 23, col_names = FALSE)
wb$add_font("Colunas", dims = "D23", color = wb_color(hex = cinza_fonte), size = 9)

## Aba 5: Barras horizontais com destaque -------------------------------------------

df_barh <- data.frame(
  setor    = c("Comercio Atacadista", "Construcao", "Energia e Utilidades", "Saude Humana",
               "Apoio Administrativo", "Comercio Varejista", "Telecomunicacoes",
               "Servicos Financeiros", "Educacao", "Servicos de TI"),
  tipo     = c(rep("Outros Setores", 9), "Setor de Dados"),
  vinculos = c(18000, 21000, 24000, 27000, 33000, 39000, 47000, 54000, 61000, 148000)
)
df_barh$setor <- factor(df_barh$setor, levels = df_barh$setor)

graf_barh <- ms_barchart(df_barh, x = "setor", y = "vinculos", group = "tipo") |>
  chart_settings(dir = "horizontal", grouping = "clustered", overlap = 100, gap_width = 40) |>
  chart_data_fill(values = c("Setor de Dados" = roxo_escuro, "Outros Setores" = laranja)) |>
  chart_data_stroke(values = c("Setor de Dados" = roxo_escuro, "Outros Setores" = laranja)) |>
  chart_data_labels(position = "outEnd", num_fmt = "#,##0", show_val = TRUE) |>
  chart_labels_text(fonte_rotulo) |>
  chart_ax_x(major_tick_mark = "out") |>
  chart_ax_y(limit_min = 0, num_fmt = "#,##0", major_tick_mark = "none") |>
  chart_labels(title = "Demanda por profissionais de dados por setor",
               xlab = NULL, ylab = "Numero de Vinculos") |>
  set_theme(tema_excel) |>
  # Barras horizontais: a grade util e a vertical (eixo de valores); sem grade horizontal
  chart_theme(grid_major_line_x = fp_border(color = cinza_grade, width = 1),
              grid_major_line_y = fp_border(width = 0),
              axis_ticks_x      = fp_border(width = 0),
              axis_ticks_y      = fp_border(color = "#000000", width = 2))

wb$add_worksheet("Barras", grid_lines = FALSE)
wb$add_data("Barras", x = df_barh, start_col = 1, start_row = 1)
wb$add_mschart(sheet = "Barras", dims = "E2:N22", graph = graf_barh)
wb$add_data("Barras", x = "Fonte: RAIS. Elaboracao: Ecoa.", start_col = 5, start_row = 23, col_names = FALSE)
wb$add_font("Barras", dims = "E23", color = wb_color(hex = cinza_fonte), size = 9)

## Aba 6: Colunas agrupadas ----------------------------------------------------------

df_grp <- data.frame(
  ano    = rep(as.character(2015:2024), times = 2),
  nivel  = rep(c("Superior", "Tecnico"), each = 10),
  lacuna = c(4200, 5100, 6300, 7800, 9500, 8200, 14500, 18200, 15800, 13400,
             1200,  800, 1500, 2900, 4100, 3600,  7800,  9600,  8100,  6400)
)

graf_grp <- ms_barchart(df_grp, x = "ano", y = "lacuna", group = "nivel") |>
  chart_settings(dir = "vertical", grouping = "clustered", gap_width = 60, overlap = -10) |>
  chart_data_fill(values = c("Superior" = roxo_escuro, "Tecnico" = laranja)) |>
  chart_data_stroke(values = c("Superior" = roxo_escuro, "Tecnico" = laranja)) |>
  chart_ax_x(major_tick_mark = "out") |>
  chart_ax_y(limit_min = 0, num_fmt = "#,##0", major_tick_mark = "none") |>
  chart_labels(title = "Lacuna anual (demanda - oferta) por nivel de formacao",
               xlab = NULL, ylab = "Profissionais/ano") |>
  set_theme(tema_excel)

wb$add_worksheet("Colunas Agrupadas", grid_lines = FALSE)
wb$add_data("Colunas Agrupadas", x = df_grp, start_col = 1, start_row = 1)
wb$add_mschart(sheet = "Colunas Agrupadas", dims = "E2:N22", graph = graf_grp)
wb$add_data("Colunas Agrupadas", x = "Fonte: RAIS e INEP. Elaboracao: Ecoa.", start_col = 5, start_row = 23, col_names = FALSE)
wb$add_font("Colunas Agrupadas", dims = "E23", color = wb_color(hex = cinza_fonte), size = 9)

# Salvar -----------------------------------------------------------------------------

wb$save("excel/modelo_graficos_ecoa.xlsx")
cat("Arquivo salvo: excel/modelo_graficos_ecoa.xlsx\n")
