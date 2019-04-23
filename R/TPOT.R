# install.packages("reticulate")
# require("reticulate")
# use_python("PATH") #e.g. /Users/christianwerner/anaconda3/bin/python
# source_python("PATH") #e.g. /Users/christianwerner/Git/LearnPython/LearnTPOT/pipeline_generator.py
#
# fit <- function(obj, features, classes) {
#   UseMethod("fit")
# }
#
# score <- function(obj, testing_features, testing_classes) {
#   UseMethod("score")
# }
#
# export <- function(obj, path) {
#   UseMethod("export")
# }
#
# ##################
#
# TPOTClassifier <- function(generations=100,
#                            population_size=100,
#                            offspring_size=NULL,
#                            mutation_rate=0.9,
#                            crossover_rate=0.1,
#                            scoring='accuracy',
#                            cv=5,
#                            subsample=1.0,
#                            n_jobs=1,
#                            max_time_mins=NULL,
#                            max_eval_time_mins=5,
#                            random_state=NULL,
#                            config_dict=NULL,
#                            warm_start=FALSE,
#                            memory=NULL,
#                            use_dask=FALSE,
#                            periodic_checkpoint_folder=NULL,
#                            early_stop=NULL,
#                            verbosity=0,
#                            disable_update_check=FALSE) {
#   #if (!is.numeric(x)) stop("X must be numeric") #handles validation
#   inputClassifier <- list("generations" = generations,
#                           "population_size" = population_size,
#                           "offspring_size" = offspring_size,
#                           "mutation_rate" = mutation_rate,
#                           "crossover_rate" = crossover_rate,
#                           "scoring" = scoring,
#                           "cv" = cv,
#                           "subsample" = subsample,
#                           "n_jobs" = n_jobs,
#                           "max_time_mins" = max_time_mins,
#                           "max_eval_time_mins" = max_eval_time_mins,
#                           "random_state" = random_state,
#                           "config_dict" = config_dict,
#                           "warm_start" = warm_start,
#                           "memory" = memory,
#                           "use_dask" = use_dask,
#                           "periodic_checkpoint_folder" = periodic_checkpoint_folder,
#                           "early_stop" = early_stop,
#                           "verbosity" = verbosity,
#                           "disable_update_check" = disable_update_check)
#   return(structure(list("Attributes" = inputClassifier,"TPOTObject" = createClassifier(inputClassifier)), class = "TPOTClassifier"))
# }
#
# fit.TPOTClassifier <- function(obj, features, classes) {
#   fitTPOT(obj$TPOTObject, features, classes)
# }
#
# predict.TPOTClassifier <- function(obj, features) {
#   predictTPOT(obj$TPOTObject, features)
# }
#
# score.TPOTClassifier <- function(obj, testing_features, testing_classes) {
#   scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
# }
#
# export.TPOTClassifier <- function(obj, path) {
#   exportTPOT(obj$TPOTObject, path)
# }
#
# ##################
#
# TPOTRegressor <- function(generations=100,
#                           population_size=100,
#                           offspring_size=NULL,
#                           mutation_rate=0.9,
#                           crossover_rate=0.1,
#                           scoring='accuracy',
#                           cv=5,
#                           subsample=1.0,
#                           n_jobs=1,
#                           max_time_mins=NULL,
#                           max_eval_time_mins=5,
#                           random_state=NULL,
#                           config_dict=NULL,
#                           warm_start=FALSE,
#                           memory=NULL,
#                           use_dask=FALSE,
#                           periodic_checkpoint_folder=NULL,
#                           early_stop=NULL,
#                           verbosity=0,
#                           disable_update_check=FALSE) {
#   #if (!is.numeric(x)) stop("X must be numeric") #handles validation
#   inputRegressor <- list("generations" = generations,
#                          "population_size" = population_size,
#                          "offspring_size" = offspring_size,
#                          "mutation_rate" = mutation_rate,
#                          "crossover_rate" = crossover_rate,
#                          "scoring" = scoring,
#                          "cv" = cv,
#                          "subsample" = subsample,
#                          "n_jobs" = n_jobs,
#                          "max_time_mins" = max_time_mins,
#                          "max_eval_time_mins" = max_eval_time_mins,
#                          "random_state" = random_state,
#                          "config_dict" = config_dict,
#                          "warm_start" = warm_start,
#                          "memory" = memory,
#                          "use_dask" = use_dask,
#                          "periodic_checkpoint_folder" = periodic_checkpoint_folder,
#                          "early_stop" = early_stop,
#                          "verbosity" = verbosity,
#                          "disable_update_check" = disable_update_check)
#   return(structure(list("Attributes" = inputRegressor,"TPOTObject" = createRegressor(inputRegressor)), class = "TPOTRegressor"))
# }
#
# fit.TPOTRegressor <- function(obj, features, classes) {
#   fitTPOT(obj$TPOTObject, features, classes)
# }
#
# predict.TPOTRegressor <- function(obj, features) {
#   predictTPOT(obj$TPOTObject, features)
# }
#
# score.TPOTRegressor <- function(obj, testing_features, testing_classes) {
#   scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
# }
#
# export.TPOTRegressor <- function(obj, path) {
#   exportTPOT(obj$TPOTObject, path)
# }
