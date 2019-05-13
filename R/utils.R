is_windows <- function(){
  return(get_os() == "windows");
}

is_osx <- function(){
  return(get_os() == "osx");
}

is_linux <- function(){
  return(get_os() == "linux");
}

is_unix <- function(){
  return(is_linux() || is_osx())
}

get_os <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}

