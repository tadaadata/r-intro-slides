#! /usr/bin/env Rscript

rmarkdown::render(input         = "intro_slides.Rmd",
                  output_format = "revealjs::revealjs_presentation",
                  output_file   = "index.html")



current_user <- Sys.info()[["user"]]

if (current_user == "Lukas") {
  slides_dir <- "~/Sync/public.tadaa-data.de/r-intro/slides"
} else if (current_user == "tobi") {
  slides_dir <- "~/Dokumente/syncthing/public.tadaa-data.de/r-intro/slides"
} else {
  slides_dir <- NA
}

if (is.na(slides_dir)) {
  message("No output directory defined, leaving everything as is.")
} else {
  files <- c("assets", "index.html")
  file.copy(files, slides_dir, overwrite = TRUE, recursive = TRUE)
}

