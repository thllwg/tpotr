reticulate::source_python(system.file("python", "pipeline_generator.py", package = "tpotr"))

fit <- function(obj, features, classes) {
  UseMethod("fit")
}

score <- function(obj, testing_features, testing_classes) {
  UseMethod("score")
}

export <- function(obj, path) {
  UseMethod("export")
}

##################

TPOTClassifier <- function(generations=100,
                           population_size=100,
                           offspring_size=NULL,
                           mutation_rate=0.9,
                           crossover_rate=0.1,
                           scoring='accuracy',
                           cv=5,
                           subsample=1.0,
                           n_jobs=1,
                           max_time_mins=NULL,
                           max_eval_time_mins=5,
                           random_state=NULL,
                           config_dict=NULL,
                           warm_start=FALSE,
                           memory=NULL,
                           use_dask=FALSE,
                           periodic_checkpoint_folder=NULL,
                           early_stop=NULL,
                           verbosity=0,
                           disable_update_check=FALSE) {
  # parameter validation
  checkmate::assertInt(generations, lower = 1, null.ok = FALSE)
  checkmate::assertInt(population_size, lower = 1, null.ok = FALSE)
  checkmate::assertInt(offspring_size, lower = 1, null.ok = TRUE)
  checkmate::assertDouble(mutation_rate, lower = 0.0, upper = 1.0, null.ok = FALSE)
  checkmate::assertDouble(crossover_rate, lower = 0.0, upper = 1.0, null.ok = FALSE)
  checkmate::assertString(scoring, null.ok = FALSE) #actual choice asserting is handled by tpot
  checkmate::assertInt(cv, lower = 1, null.ok = FALSE)
  checkmate::assertDouble(subsample, lower = 0.1, upper = 1.0, null.ok = FALSE)
  if (!(n_jobs == -1 || n_jobs >= 1)) stopf ("Error: n_jobs is neither -1 nor greater than 1.")
  checkmate::assertInt(max_time_mins, null.ok = TRUE, lower = 1)
  checkmate::assertDouble(max_eval_time_mins, lower = 0.0001, null.ok = FALSE)
  checkmate::assertInt(random_state, lower = 0, null.ok = TRUE)
  checkmate::assertString(config_dict, null.ok = TRUE)
  checkmate::assertLogical(warm_start)
  checkmate::assertString(memory, null.ok = TRUE)
  checkmate::assertLogical(use_dask)
  checkmate::assertString(periodic_checkpoint_folder, null.ok = TRUE)
  checkmate::assertInt(early_stop, null.ok = TRUE, lower = 1)
  checkmate::assertInt(verbosity, lower = 0, upper = 3, null.ok = FALSE)
  checkmate::assertLogical(disable_update_check)

  inputClassifier <- list("generations" = generations,
                          "population_size" = population_size,
                          "offspring_size" = offspring_size,
                          "mutation_rate" = mutation_rate,
                          "crossover_rate" = crossover_rate,
                          "scoring" = scoring,
                          "cv" = cv,
                          "subsample" = subsample,
                          "n_jobs" = n_jobs,
                          "max_time_mins" = max_time_mins,
                          "max_eval_time_mins" = max_eval_time_mins,
                          "random_state" = random_state,
                          "config_dict" = config_dict,
                          "warm_start" = warm_start,
                          "memory" = memory,
                          "use_dask" = use_dask,
                          "periodic_checkpoint_folder" = periodic_checkpoint_folder,
                          "early_stop" = early_stop,
                          "verbosity" = verbosity,
                          "disable_update_check" = disable_update_check)
  return(structure(list("Attributes" = inputClassifier,"TPOTObject" = createClassifier(inputClassifier)), class = "TPOTClassifier"))
}

fit.TPOTClassifier <- function(obj, features, classes) {
  fitTPOT(obj$TPOTObject, features, classes)
}

predict.TPOTClassifier <- function(obj, features) {
  predictTPOT(obj$TPOTObject, features)
}

score.TPOTClassifier <- function(obj, testing_features, testing_classes) {
  scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
}

export.TPOTClassifier <- function(obj, path) {
  exportTPOT(obj$TPOTObject, path)
}

##################

TPOTRegressor <- function(generations=100,
                          population_size=100,
                          offspring_size=NULL,
                          mutation_rate=0.9,
                          crossover_rate=0.1,
                          scoring='accuracy',
                          cv=5,
                          subsample=1.0,
                          n_jobs=1,
                          max_time_mins=NULL,
                          max_eval_time_mins=5,
                          random_state=NULL,
                          config_dict=NULL,
                          warm_start=FALSE,
                          memory=NULL,
                          use_dask=FALSE,
                          periodic_checkpoint_folder=NULL,
                          early_stop=NULL,
                          verbosity=0,
                          disable_update_check=FALSE) {

  # parameter validation
  checkmate::assertInt(generations, lower = 1, null.ok = FALSE)
  checkmate::assertInt(population_size, lower = 1, null.ok = FALSE)
  checkmate::assertInt(offspring_size, lower = 1, null.ok = TRUE)
  checkmate::assertDouble(mutation_rate, lower = 0.0, upper = 1.0, null.ok = FALSE)
  checkmate::assertDouble(crossover_rate, lower = 0.0, upper = 1.0, null.ok = FALSE)
  checkmate::assertString(scoring, null.ok = FALSE) #actual choice asserting is handled by tpot
  checkmate::assertInt(cv, lower = 1, null.ok = FALSE)
  checkmate::assertDouble(subsample, lower = 0.1, upper = 1.0, null.ok = FALSE)
  if (!(n_jobs == -1 || n_jobs >= 1)) stopf ("Error: n_jobs is neither -1 nor greater than 1.")
  checkmate::assertInt(max_time_mins, null.ok = TRUE, lower = 1)
  checkmate::assertDouble(max_eval_time_mins, lower = 0.0001, null.ok = FALSE)
  checkmate::assertInt(random_state, lower = 0, null.ok = TRUE)
  checkmate::assertString(config_dict, null.ok = TRUE)
  checkmate::assertLogical(warm_start)
  checkmate::assertString(memory, null.ok = TRUE)
  checkmate::assertLogical(use_dask)
  checkmate::assertString(periodic_checkpoint_folder, null.ok = TRUE)
  checkmate::assertInt(early_stop, null.ok = TRUE, lower = 1)
  checkmate::assertInt(verbosity, lower = 0, upper = 3, null.ok = FALSE)
  checkmate::assertLogical(disable_update_check)

  inputRegressor <- list("generations" = generations,
                         "population_size" = population_size,
                         "offspring_size" = offspring_size,
                         "mutation_rate" = mutation_rate,
                         "crossover_rate" = crossover_rate,
                         "scoring" = scoring,
                         "cv" = cv,
                         "subsample" = subsample,
                         "n_jobs" = n_jobs,
                         "max_time_mins" = max_time_mins,
                         "max_eval_time_mins" = max_eval_time_mins,
                         "random_state" = random_state,
                         "config_dict" = config_dict,
                         "warm_start" = warm_start,
                         "memory" = memory,
                         "use_dask" = use_dask,
                         "periodic_checkpoint_folder" = periodic_checkpoint_folder,
                         "early_stop" = early_stop,
                         "verbosity" = verbosity,
                         "disable_update_check" = disable_update_check)
  return(structure(list("Attributes" = inputRegressor,"TPOTObject" = createRegressor(inputRegressor)), class = "TPOTRegressor"))
}

fit.TPOTRegressor <- function(obj, features, classes) {
  fitTPOT(obj$TPOTObject, features, classes)
}

predict.TPOTRegressor <- function(obj, features) {
  predictTPOT(obj$TPOTObject, features)
}

score.TPOTRegressor <- function(obj, testing_features, testing_classes) {
  scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
}

export.TPOTRegressor <- function(obj, path) {
  exportTPOT(obj$TPOTObject, path)
}
