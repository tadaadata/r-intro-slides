## Das tidyverse:
## eine Sammlung vieler Pakete aus der gleichen Schmiede, die einem das Leben vereinfachen:
## unter und vor allem: ggplot2, dplyr, readr & haven


##### Installation ####
# kann, auf alten oder sehr leistungsschwachen Rechnern bi zu 30 Min dauern

install.packages("tidyverse")       # Pakete müssen nur ein mal INSTALLIERT...
library(tidyverse)                  # ...aber nach jedem Start von RStudio neu GELADEN werden



#### Datensätze laden (per Code) ####

# RDS Datensätze müssen immer mehr oder weniger direkt angesteuert werden
qm  <- file.choose() %>% readRDS()

# Oder "manuell"
qm  <- readRDS("data/qm-survey-2017-R.rds")



# csv Daten (o.ä.) können bequem das erste mal durch klicken ('Import Dataset', rechts) geladen werden,
# der Code wird dabei angegeben: copy&paste und beim zweiten mal ist es nur ein Tastendruck
got <- read_csv("data/gotdeaths_books.csv")



#### Datenmanipulation ####

got <- got %>%
  rename(
    Loyalität = Allegiances, Todesjahr = `Death Year`, Todesbuch = `Book of Death`,
    Todeskapitel = `Death Chapter`, Vorstellungskapitel = `Book Intro Chapter`, Geschlecht = Gender,
    Adel = Nobility, Game_of_Thrones = GoT, Clash_of_Kings = CoK, Storm_of_Swords = SoS, Feast_for_Crows = FfC,
    Dance_with_Dragons = DwD
  ) %>%
  mutate(
    Loyalität  = stringr::str_replace_all(Loyalität, "House\\ ", ""),
    Geschlecht = factor(recode(Geschlecht, `1` = "Männlich", `0` = "Weiblich")),
    Adel       = factor(recode(Adel, `1` = "Ja", `0` = "Nein"))
  )



#### Ein paar hübsche Plots bauen ####

# Tode in den ASOIAF-Büchern nach Häusern (u.a.)
got %>%
  filter(!is.na(Todesjahr)) %>%
  count(Loyalität) %>%
  ggplot(aes(x = reorder(Loyalität, n), y = n)) +
    geom_col() +
    labs(y = "Tode", x = "Loyalität", title = "Tode in Game of Thrones",
         subtitle = "basierend auf den Büchern") +
    coord_flip()


# Anzahl Sexualpartnerschaften nach Parteipräferenz
qm %>%
  filter(partnerinnen <= 15, !is.na(partei)) %>%
  ggplot(aes(x = partei, y = partnerinnen, fill = partei)) +
    geom_boxplot() +
    scale_color_brewer(palette = "Set1") +
    labs(x = "Partei", y = "Anzahl Sexualpartnerschaften") +
    coord_flip() +
    theme(legend.position = "none")


# Freunde & so
qm %>%
  filter(freundeeng <= 15, freundeskreis <= 100) %>%
  ggplot(aes(x = freundeskreis, y = freundeeng)) +
  geom_point(shape = 21) +
  geom_smooth(method = "lm", se = F)
