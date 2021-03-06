####                                                     ####
####                Web Scraping Ejemplo                 ####
#### Construcci�n de base de datos top 50 peliculas IMDB ####
####                                                     ####
####                                                     ####

# Instalar los paquetes a impelmentar:
install.packages("rvest", dependencies = T)
install.packages("robotstxt", dependencies = T)
install.packages("selectr", dependencies = T)
install.packages("xml2", dependencies = T)
install.packages("dplyr", dependencies = T)
install.packages("stringr", dependencies = T)
install.packages("forcats", dependencies = T)
install.packages("magrittr", dependencies = T)
install.packages("tidyr", dependencies = T)
install.packages("ggplot2", dependencies = T)
install.packages("lubridate", dependencies = T)
install.packages("purrr", dependencies = T)
install.packages("readr", dependencies = T)

# Cargar los paquetes:
library(rvest)
library(robotstxt)
library(selectr)
library(xml2)
library(dplyr)
library(stringr)
library(forcats)
library(magrittr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(tibble)
library(purrr)
library(readr)

# Guardar en un objeto el url de la p�gina que se scrapear�:
url <- "https://www.imdb.com/search/title/?groups=top_250&sort=user_rating"

# Averiguar si tenemos acceso para hacer web scraping en la p�gina web:
paths_allowed(paths = url)

# Guardar c�digo html de la p�gina web en objeto:
html_web <- read_html(url) 

# Scrape 1: T�tulo
titulo <- html_nodes(html_web, ".lister-item-header a")
titulo <- html_text(titulo)
# Equivalente:
titulo <- html_web %>% html_nodes(".lister-item-header a") %>% html_text()

# Scrape 2: A�o de estreno
a�o_estreno <- html_web %>% 
  html_nodes(".lister-item-year.text-muted.unbold") %>% 
  html_text() %>% 
  str_sub(start = 2, end = 5) %>%
  as.numeric()

# Scrape 3: Minutos que dura
duracion <- html_web %>% 
  html_nodes(".runtime") %>% 
  html_text() %>%
  str_split(" ") %>%
  map_chr(1) %>%
  as.numeric()

# Scrape 4: G�nero
genero <- html_web %>%
  html_nodes(".genre") %>%
  html_text() %>%
  str_trim()
  
# Scrape 5: Rating
rating <- html_web %>%
  html_nodes(".inline-block.ratings-imdb-rating strong") %>%
  html_text()

# Se juntan todas las variables creadas en un data set:
top_50 <- tibble(Pelicula = titulo,
                     A�o = a�o_estreno,
                     Duraci�n_min = duracion,
                     Genero = genero,
                     Rating = rating)

# Exportar a excel:
write.csv2(top_50, "top_50.csv")









