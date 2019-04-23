.onLoad <- function (libname, pkgname){
  #set package options
  op <- options()
  op.devtools <- list(
    devtools.path = "~/R-dev",
    devtools.install.args = "",
    devtools.name = "Thorben Hellweg",
    devtools.desc.author = "First Last <first.last@example.com> [aut, cre]",
    devtools.desc.license = "What license is it under?",
    devtools.desc.suggests = NULL,
    devtools.desc = list()
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])

  invisible()

  #is Anaconda installed on host system?
  path = checkAnaconda();
  if (!is.null(path) && path != ''){
    if (path != "%GLOBAL%"){
      reticulate::use_condaenv(path);
      reticulate::use_python(reticulate::py_config()$python)
    }
  }
  # check Python
  checkPythonVersion();

  # check TPOT
  if (!has_package("tpot")) install_package("tpot");
}

.onUnload <- function(libpath){
  # ...
}


.onAttach <- function(libname, pkgname){
  packageStartupMessage("Welcome to TPOT in R")
}

