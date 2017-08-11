#! /usr/bin/env Rscript

t_start <- Sys.time()
cat("\n\nRendering things…\n")

rmarkdown::render(input         = "index.Rmd",
                  output_format = "revealjs::revealjs_presentation",
                  output_file   = "index.html", encoding = "UTF-8")



cat("\nChecking who you are…\n")
current_user <- Sys.info()[["user"]]
cat(paste0("I hope you're really ", current_user), "\n")

if (current_user == "Lukas") {
  slides_dir <- "~/Sync/public.tadaa-data.de/r-intro/slides"
} else if (current_user == "tobi") {
  slides_dir <- "~/Dokumente/syncthing/public.tadaa-data.de/r-intro/slides"
} else {
  slides_dir <- NA
}

if (is.na(slides_dir)) {
  cat("No output directory defined, leaving everything as is.\n")
} else {
  files <- c("assets", "index.html")
  file.copy(files, slides_dir, overwrite = TRUE, recursive = TRUE)
}

#### Done ####
cat("\nAll done!\n")
t_finish <- Sys.time()
t_diff   <- round(as.numeric(difftime(t_finish, t_start, "s")), 0)
cat("Took about", t_diff, "seconds", "\n")
timestamp()
