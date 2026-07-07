# vizecoa

Paleta de cores e escalas ggplot2 para a **Ecoa Consultoria Economica**.

## Objetivo

O pacote `vizecoa` fornece uma paleta de cores personalizada baseada nas cores institucionais da Ecoa, com funcoes prontas para uso em graficos `ggplot2`. O objetivo e padronizar as visualizacoes de dados em projetos da consultoria.

> **Novo:** consulte o [**Guia de Uso**](GUIA_DE_USO.md) para o padrao completo de graficos Ecoa — tema padrao (`theme_ecoa`), formatacao de numeros pt-BR, convencoes de cores e exemplos prontos (linhas com rotulos, barras, anotacoes).

## Instalacao

### Via GitHub (recomendado)

```r
# Instalar devtools se necessario
install.packages("devtools")

# Instalar vizecoa do GitHub
devtools::install_github("moreirasd/viz_ecoa")
```


## Cores da Paleta

A paleta Ecoa e composta por 4 cores base que sao interpoladas para criar gradientes:

| Cor | Hex | Descricao |
|:---:|:---:|-----------|
| <img src="https://readme-swatches.vercel.app/4a3549" width="40" height="20"> | `#4a3549` | Roxo escuro |
| <img src="https://readme-swatches.vercel.app/aa6aef" width="40" height="20"> | `#aa6aef` | Roxo claro |
| <img src="https://readme-swatches.vercel.app/f2aa84" width="40" height="20"> | `#f2aa84` | Pessego |
| <img src="https://readme-swatches.vercel.app/FF8C00" width="40" height="20"> | `#FF8C00` | Laranja |

### Variacao com tons de cinza

Para graficos com muitas categorias, ha uma variacao da paleta com tons de cinza na transicao entre o roxo e o laranja. Os cinzas desaturam o meio da paleta, tornando as cores intermediarias mais distinguiveis entre si. Basta usar `cinza = TRUE` em qualquer funcao do pacote.

| Cor | Hex | Descricao |
|:---:|:---:|-----------|
| <img src="https://readme-swatches.vercel.app/4a3549" width="40" height="20"> | `#4a3549` | Roxo escuro |
| <img src="https://readme-swatches.vercel.app/aa6aef" width="40" height="20"> | `#aa6aef` | Roxo claro |
| <img src="https://readme-swatches.vercel.app/948b9c" width="40" height="20"> | `#948b9c` | Cinza arroxeado |
| <img src="https://readme-swatches.vercel.app/cfc9c6" width="40" height="20"> | `#cfc9c6` | Cinza claro |
| <img src="https://readme-swatches.vercel.app/f2aa84" width="40" height="20"> | `#f2aa84` | Pessego |
| <img src="https://readme-swatches.vercel.app/FF8C00" width="40" height="20"> | `#FF8C00` | Laranja |

<p align="center">
  <img src="man/figures/paleta_cinza.png" width="600">
</p>

## Funcoes Disponiveis

Todas as funcoes aceitam o argumento `cinza = TRUE` para usar a variacao com tons de cinza (padrao: `FALSE`).

| Funcao | Descricao |
|--------|-----------|
| `cores_ecoa` | Vetor com as 4 cores base da Ecoa |
| `cores_ecoa_cinza` | Vetor com as 6 cores da variacao com cinza |
| `paleta_ecoa(n)` | Gera n cores interpoladas da paleta |
| `scale_fill_ecoa()` | Escala de preenchimento continua para ggplot2 |
| `scale_color_ecoa()` | Escala de cor continua para ggplot2 |
| `scale_fill_ecoa_d()` | Escala de preenchimento discreta para ggplot2 |
| `scale_color_ecoa_d()` | Escala de cor discreta para ggplot2 |
| `mostrar_paleta(n)` | Visualiza n cores da paleta com codigos hex |
| `hex_ecoa(n)` | Retorna os codigos hex de n cores (util para PPT) |

## Visualizacao da Paleta

<p align="center">
  <img src="man/figures/paleta_completa.png" width="600">
</p>

### Carregar os pacotes

```r
library(vizecoa)
library(ggplot2)
library(patchwork)
```

### Paleta continua

```r
df_continua <- data.frame(x = 1:256, y = 1)

p1 <- ggplot(df_continua, aes(x = x, y = y, fill = x)) +
  geom_tile() +
  scale_fill_gradientn(colors = paleta_ecoa(256)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.margin = margin(10, 10, 10, 10)) +
  labs(title = "Paleta Continua")

print(p1)
```

### Paleta discreta

```r
# Visualizar diferentes quantidades de cores
p2 <- mostrar_paleta(4)
p3 <- mostrar_paleta(6)
p4 <- mostrar_paleta(8)

# Combinar visualizacoes
plot_paleta <- p1 / p2 / p3 / p4 +
  plot_annotation(
    title = "Paleta Customizada - Ecoa",
    theme = theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
  )

print(plot_paleta)
```

## Exemplos de Uso

### Exemplo 1: Heatmap (escala continua)

```r
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
```

<p align="center">
  <img src="man/figures/exemplo_heatmap.png" width="500">
</p>



### Exemplo 2: Grafico de barras (escala discreta)

```r
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

print(p_bar)
```
<p align="center">
  <img src="man/figures/exemplo_barras.png" width="500">
</p>


### Exemplo 3: Muitas categorias (paleta com cinza)

Quando ha muitas categorias, use `cinza = TRUE` para obter cores intermediarias mais distinguiveis:

```r
df_bar8 <- data.frame(
  categoria = LETTERS[1:8],
  valor = c(23, 45, 67, 34, 89, 56, 71, 48)
)

p_bar_cinza <- ggplot(df_bar8, aes(x = categoria, y = valor, fill = categoria)) +
  geom_col() +
  scale_fill_ecoa_d(cinza = TRUE) +
  theme_minimal() +
  labs(title = "Exemplo: Barras com 8 categorias") +
  theme(legend.position = "none")

print(p_bar_cinza)
```
<p align="center">
  <img src="man/figures/exemplo_barras_cinza.png" width="500">
</p>


### Exemplo 4: Scatter plot (escala continua de cor)

```r
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

print(p_scatter)
```
<p align="center">
  <img src="man/figures/exemplo_scatter.png" width="500">
</p>


#### Exemplo 5: Obter somente os HEX codes.

```r
hex_ecoa(4)
#> 4 cores: #4A3549, #AA6AEF, #F2AA84, #FF8C00

hex_ecoa(5)
#> 5 cores: ...

hex_ecoa(6)
#> 6 cores: ...

# Paleta com tons de cinza
hex_ecoa(8, cinza = TRUE)
#> 8 cores: #4A3549, #8E5ABF, #A078CB, #9C93A2, #C6C0C0, #E2B7A0, #F5A15E, #FF8C00

hex_ecoa(10)
#> 10 cores: ...
```

## Dependencias

- `ggplot2` (obrigatoria)
- `patchwork` (opcional, para combinar graficos)

