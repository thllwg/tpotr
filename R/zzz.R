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

  conda_path = reticulate::conda_binary(conda = "auto")
  python_path = reticulate::conda_list(conda = "auto")[1,]

  # create conda env
  #env = yaml::read_yaml(system.file("environment.yml", package = "tpotr"))
  env = list(name = "tpotr")
  packages = c("numpy", "scipy", "scikit-learn", "pandas")
  packagesPip = c("deap", "update_checker", "tqdm", "stopit", "xgboost", "scikit-mdr", "skrebate", "tpot")

  if (!any(grepl(env$name, reticulate::conda_list()[,1]))){
    reticulate::conda_create(envname = env$name)
  }

  reticulate::use_condaenv(env$name, required = TRUE)

  packages = findUninstalledPackages(packages)
  packagesPip = findUninstalledPackages(packagesPip)

  if (length(packages) > 0) reticulate::conda_install(envname = env$name, packages = packages, conda = conda_path)
  if (length(packagesPip) > 0) reticulate::conda_install(envname = env$name, packages = packagesPip, pip = TRUE, conda = conda_path)

  if (!reticulate::py_module_available("tpot")) {
    # throw error message
  }
}

.onUnload <- function(libpath){
  # ...
}


.onAttach <- function(libname, pkgname){
  packageStartupMessage("Welcome to TPOT in R")
}

