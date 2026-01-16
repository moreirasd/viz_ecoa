#_______________________________________________________________________________
# - Objetivo: Padronização das cores Ecoa
# - Autor: Miguel Moreira
# - Data: 13/08/2025
# - Fontes: Grupo salta, GIC e internet
#_______________________________________________________________________________


library(ggplot2)

# Cores base 
cores_ecoa <- c(
  "#4a3549",   # roxo escuro
  "#aa6aef",   # roxo claro
  "#f2aa84",   # pêssego
  "#FF8C00"    # laranja
)

# Criar função de paleta contínua
paleta_ecoa <- colorRampPalette(cores_ecoa)

# Funções para GGPLOT -----------------------------------------------------



# Escala contínua - fill
scale_fill_ecoa <- function(n = 256, ...) {
  scale_fill_gradientn(colors = paleta_ecoa(n), ...)
}

# Escala contínua - color
scale_color_ecoa <- function(n = 256, ...) {
  scale_color_gradientn(colors = paleta_ecoa(n), ...)
}

# Escala discreta - fill
scale_fill_ecoa_d <- function(...) {
  discrete_scale("fill", "ecoa", palette = function(n) paleta_ecoa(n), ...)
}

# Escala discreta - color
scale_color_ecoa_d <- function(...) {
  discrete_scale("colour", "ecoa", palette = function(n) paleta_ecoa(n), ...)
}



# Viz da paleta -----------------------------------------------------------


# 1. Paleta contínua
df_continua <- data.frame(x = 1:256, y = 1)

p1 <- ggplot(df_continua, aes(x = x, y = y, fill = x)) +
  geom_tile() +
  scale_fill_gradientn(colors = paleta_ecoa(256)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.margin = margin(10, 10, 10, 10)) +
  labs(title = "Paleta Contínua")

# 2. Função para mostrar paleta discreta
mostrar_discreta <- function(n) {
  cores <- paleta_ecoa(n)
  df <- data.frame(
    x = factor(1:n),
    y = 1,
    cor = cores
  )
  
  ggplot(df, aes(x = x, y = y, fill = cor)) +
    geom_tile(color = "white", linewidth = 2) +
    scale_fill_identity() +
    geom_text(aes(label = cor), color = "white", size = 2.5, fontface = "bold") +
    theme_void() +
    theme(plot.title = element_text(hjust = 0.5, size = 11),
          plot.margin = margin(5, 10, 5, 10)) +
    labs(title = paste0(n, " cores"))
}

p2 <- mostrar_discreta(4)
p3 <- mostrar_discreta(6)
p4 <- mostrar_discreta(8)

# Combinar plots
library(patchwork)

plot_paleta <- p1 / p2 / p3 / p4 +
  plot_annotation(
    title = "Paleta Viridis Customizada - Ecoa",
    theme = theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
  )

print(plot_paleta)




# Exemplos de uso ---------------------------------------------------------


# Exemplo 1: Escala contínua (heatmap)
set.seed(42)
df_heat <- expand.grid(x = 1:20, y = 1:20)
df_heat$z <- with(df_heat, sin(x/3) * cos(y/3) + rnorm(400, sd = 0.1))

p_heat <- ggplot(df_heat, aes(x = x, y = y, fill = z)) +
  geom_tile() +
  scale_fill_ecoa() +
  theme_minimal() +
  labs(title = "Exemplo: Heatmap", fill = "Valor") +
  coord_equal()

print(p_heat)

# Exemplo 2: Escala discreta (barras)
df_bar <- data.frame(
  categoria = LETTERS[1:6],
  valor = c(23, 45, 67, 34, 89, 56)
)

p_bar <- ggplot(df_bar, aes(x = categoria, y = valor, fill = categoria)) +
  geom_col() +
  scale_fill_ecoa_d() +
  theme_minimal() +
  labs(title = "Exemplo: Gráfico de Barras") +
  theme(legend.position = "none")

print(p_bar)

# Exemplo 3: Scatter plot contínuo
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
  labs(title = "Exemplo: Scatter Plot", color = "Distância")

print(p_scatter)



# HEX Ccodes para PPT -----------------------------------------------------


cat("4 cores:", paste(paleta_ecoa(4), collapse = ", "), "\n")
cat("5 cores:", paste(paleta_ecoa(5), collapse = ", "), "\n")
cat("6 cores:", paste(paleta_ecoa(6), collapse = ", "), "\n")
cat("8 cores:", paste(paleta_ecoa(8), collapse = ", "), "\n")
cat("10 cores:", paste(paleta_ecoa(10), collapse = ", "), "\n")

