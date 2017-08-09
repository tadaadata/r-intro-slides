## I like to keep things seperate...
# ready toolbox
library(tidyverse)
library(tadaatoolbox)

# load and set custom ggplot theme
source("https://tobi.tadaa-data.de/theme_tut.R")
theme_set(theme_tut(style = "light", size = 18))

#### Chunk options ####
knitr::opts_chunk$set(fig.path = "assets/plots/")
