topt <- NULL

#' Install TPOT and its dependencies
#'
#' @inheritParams reticulate::conda_list
#'
#' @param method Installation method. By default, "auto" tries to finds a
#'   method that will work in the local environment. Change the default to force
#'   a specific installation method.
#'
#' @param version TPOT version to install. Specify "default" to install
#'   the latest release version.
#'   You can also provide a full major.minor.patch specification (e.g. "1.1.0").
#'
#' @param envname Name of Python environment to install within. Default is "r-tpot".
#'
#' @param extra_packages Additional Python packages to install along with
#'   TPOT.
#'
#' @param restart_session Restart R session after installing (note this will
#'   only occur within RStudio).
#'
#' @export
install_tpot <- function(method = c("auto", "conda"),
                         conda = "auto",
                         version = "default",
                         envname = "r-tpot",
                         extra_packages = NULL,
                         extra_pip_packages = NULL,
                         restart_session = TRUE){

  # unroll version
  ver <- parse_tpot_version(version)
  version <- ver$version

  # extra packages
  packages <- unique(c(extra_packages, c("numpy", "scipy", "scikit-learn", "pandas")))
  packagesPip = unique(c(extra_pip_packages, c("deap", "update_checker", "tqdm", "stopit", "xgboost", "tpot"))) # "scikit-mdr", "skrebate",

  # verify os

  if (is_windows() || (!is_osx() && !is_linux())) {
    stop("Unable to install TPOT on this platform. ",
         "Installation is available for OS X and Linux only.")
  }

  # resolve and validate method
  #can be used to install into virtualenv at a later time
  method <- match.arg(method)

  conda_path = reticulate::conda_binary(conda = conda)
  if (is.null(conda_path)) {
    stop("Could not find location of main conda binary. Please make sure Anaconda is installed!")
  }
  python_path = reticulate::conda_list(conda = conda)[1,]

  # create conda env
  env = list(name = envname)

  if (!any(grepl(env$name, reticulate::conda_list()[,1]))){
    reticulate::conda_create(envname = env$name)
  }

  reticulate::use_condaenv(env$name, required = TRUE)

  packages = findUninstalledPackages(packages)
  packagesPip = findUninstalledPackages(packagesPip)

  if (length(packages) > 0) reticulate::conda_install(envname = env$name, packages = packages, conda = conda_path)
  if (length(packagesPip) > 0) reticulate::conda_install(envname = env$name, packages = packagesPip, pip = TRUE, conda = conda_path)

  if (!reticulate::py_module_available("tpot")) {
    stopf("Module 'tpot' has not been installed successfully. Please retry installation. If this problem persists, please contact the maintainer.")
  }

  #topt <<- reticulate::import("tpot", delay_load = TRUE)
  reticulate::source_python(system.file("python", "pipeline_generator.py", package = "tpotr"), envir = parent.env(environment()))
}

parse_tpot_version <- function(version) {

  # defaults
  ver <- list(
    version = "default",
    packages = NULL
  )

  if (identical(version, "default")) {
    ver$version <- "0.10.0"
  } else {
    ver$version <- version
  }

  # return
  ver
}
