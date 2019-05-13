findUninstalledPackages <- function(packages){
  s = sapply(packages, function(p){
    !reticulate::py_module_available(p)
  })
  packages = packages[s]
  return(packages)
}

checkPythonVersion <- function(){
  v = reticulate::py_config()$version
  v = as.numeric_version(v)
  if (v < 3.7){
    stopf("The python version used in your Anaconda installation is outdated.\n
    Please update to 3.7 or higher.");
  }
}

checkAnaconda <- function(){
  result = system2("conda", "--version")
  if (result == 0){
    print("Anaconda found in system path")
    return("%GLOBAL%");
  } else{
    if (result == 127L){
      print("Could not find Anaconda in system path, searching in default installation paths...");
      local = checkAnacondaLocal()
      if (local == 0){
        print("Anaconda found in local installation path");t
        return(getDefaultPath());
      } else {
        err = "Could not find a working installation of Anaconda packet manager. \n
             Please make sure that Anaconda is installed, \n
             and add it to your systems environment path."
        BBmisc::stopf(err);
      }
    }
  }
}

checkAnacondaLocal <- function(){
  path = getDefaultPath();

  result = system2(paste0(path, "conda"), "--version");
  return (result)
}

getDefaultPath <- function(){
  os = get_os();
  checkmate::assertString(os);
  usr = Sys.info()['user']
  checkmate::assertString(usr);
  switch(os,
         linux = {paste0("/home/",usr,"/anaconda3/bin/")},
         osx =  {paste0("/Users/",usr,"/anaconda3")},
         windows = {paste0("C:\\Users\\",usr,"\\Anaconda3\\")})
}



has_package <- function(pkg){
  return(reticulate::py_module_available(pkg))
}

install_package <- function(pkg){
  printf("Installing py package 'TPOT'...")
  return(reticulate::py_install(pkg))
}
