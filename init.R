## I like to keep things seperate...

# Function to install package if needed and load afterwards
pkg <- function(package) {
  package <- deparse(substitute(package))

  if (!(package %in% installed.packages())) {
    install.packages(package)
  }
  library(package, character.only = TRUE)
}

# ready toolbox
pkg(tidyverse)
pkg(tadaatoolbox)

# load and set custom ggplot theme
source("https://tobi.tadaa-data.de/theme_tut.R")
theme_set(theme_tut(style = "light", size = 18))

#### Chunk options ####
knitr::opts_chunk$set(fig.path = "assets/plots/")
