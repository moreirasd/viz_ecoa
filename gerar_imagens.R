# Script para gerar imagens do README
# Execute este script no RStudio para criar as imagens

library(ggplot2)
library(patchwork)

# Carregar as funcoes do pacote
source("R/paletas.R")

# Criar pasta se nao existir
if (!dir.exists("man/figures")) {
 dir.create("man/figures", recursive = TRUE)
}

# 1. Paleta continua
df_continua <- data.frame(x = 1:256, y = 1)

p1 <- ggplot(df_continua, aes(x = x, y = y, fill = x)) +
 geom_tile() +
 scale_fill_gradientn(colors = paleta_ecoa(256)) +
 theme_void() +
 theme(legend.position = "none",
       plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
       plot.margin = margin(10, 10, 10, 10)) +
 labs(title = "Paleta Continua")

# 2. Paletas discretas
p2 <- mostrar_paleta(4)
p3 <- mostrar_paleta(6)
p4 <- mostrar_paleta(8)

# 3. Combinacao de paletas
plot_paleta <- p1 / p2 / p3 / p4 +
 plot_annotation(
   title = "Paleta Customizada - Ecoa",
   theme = theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
 )

ggsave("man/figures/paleta_completa.png", plot_paleta, width = 8, height = 8, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/paleta_completa.png\n")

# 3b. Paleta com tons de cinza
df_continua_cinza <- data.frame(x = 1:256, y = 1)

p1c <- ggplot(df_continua_cinza, aes(x = x, y = y, fill = x)) +
 geom_tile() +
 scale_fill_gradientn(colors = paleta_ecoa(256, cinza = TRUE)) +
 theme_void() +
 theme(legend.position = "none",
       plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
       plot.margin = margin(10, 10, 10, 10)) +
 labs(title = "Paleta Continua (com cinza)")

p2c <- mostrar_paleta(6, cinza = TRUE)
p3c <- mostrar_paleta(8, cinza = TRUE)
p4c <- mostrar_paleta(10, cinza = TRUE)

plot_paleta_cinza <- p1c / p2c / p3c / p4c +
 plot_annotation(
   title = "Paleta com Tons de Cinza - Ecoa",
   theme = theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
 )

ggsave("man/figures/paleta_cinza.png", plot_paleta_cinza, width = 8, height = 8, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/paleta_cinza.png\n")

# 3c. Exemplo barras com muitas categorias (paleta com cinza)
df_bar_cinza <- data.frame(
 categoria = LETTERS[1:8],
 valor = c(23, 45, 67, 34, 89, 56, 71, 48)
)

p_bar_cinza <- ggplot(df_bar_cinza, aes(x = categoria, y = valor, fill = categoria)) +
 geom_col() +
 scale_fill_ecoa_d(cinza = TRUE) +
 theme_minimal() +
 labs(title = "Exemplo: Barras com 8 categorias (cinza = TRUE)") +
 theme(legend.position = "none")

ggsave("man/figures/exemplo_barras_cinza.png", p_bar_cinza, width = 6, height = 4, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/exemplo_barras_cinza.png\n")

# 3d. Todas as paletas do pacote
p_todas <- mostrar_paletas()
ggsave("man/figures/paletas_todas.png", p_todas, width = 8, height = 6, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/paletas_todas.png\n")

# 4. Exemplo Heatmap
set.seed(42)
df_heat <- expand.grid(x = 1:20, y = 1:20)
df_heat$z <- with(df_heat, sin(x/3) * cos(y/3) + rnorm(400, sd = 0.1))

p_heat <- ggplot(df_heat, aes(x = x, y = y, fill = z)) +
 geom_tile() +
 scale_fill_ecoa() +
 theme_minimal() +
 labs(title = "Exemplo: Heatmap", fill = "Valor") +
 coord_equal()

ggsave("man/figures/exemplo_heatmap.png", p_heat, width = 6, height = 6, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/exemplo_heatmap.png\n")

# 5. Exemplo Barras
df_bar <- data.frame(
 categoria = LETTERS[1:6],
 valor = c(23, 45, 67, 34, 89, 56)
)

p_bar <- ggplot(df_bar, aes(x = categoria, y = valor, fill = categoria)) +
 geom_col() +
 scale_fill_ecoa_d() +
 theme_minimal() +
 labs(title = "Exemplo: Grafico de Barras") +
 theme(legend.position = "none")

ggsave("man/figures/exemplo_barras.png", p_bar, width = 6, height = 4, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/exemplo_barras.png\n")

# 6. Exemplo Scatter
set.seed(123)
df_scatter <- data.frame(
 x = rnorm(300),
 y = rnorm(300)
)
df_scatter$dist <- sqrt(df_scatter$x^2 + df_scatter$y^2)

p_scatter <- ggplot(df_scatter, aes(x = x, y = y, color = dist)) +
 geom_point(size = 2.5, alpha = 0.8) +
 scale_color_ecoa() +
 theme_minimal() +
 labs(title = "Exemplo: Scatter Plot", color = "Distancia")

ggsave("man/figures/exemplo_scatter.png", p_scatter, width = 6, height = 5, dpi = 150, bg = "white")
cat("Imagem salva: man/figures/exemplo_scatter.png\n")

cat("\n--- Todas as imagens foram geradas! ---\n")
cat("Agora faca o commit e push das imagens.\n")
