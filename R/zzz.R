.onLoad <- function (libname, pkgname){
  #set package options
  op <- options()
  op.devtools <- list(
    devtools.path = "~/R-dev",
    devtools.install.args = "",
    devtools.name = "Thorben Hellweg",
    devtools.desc.author = "Thorben Hellweg <thorben.hellweg@uni-muenster.de> [aut, cre]",
    devtools.desc.license = "GPL-3",
    devtools.desc.suggests = NULL,
    devtools.desc = list()
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])

  invisible()

  install_tpot()

}

.onUnload <- function(libpath){
  # ...
}


.onAttach <- function(libname, pkgname){
  packageStartupMessage("Welcome to TPOT in R")
}

