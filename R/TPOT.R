#' @title Fitting a model to the data
#' @description
#' Uses genetic programming to optimize a machine learning pipeline that
#' maximizes score on the provided features and target. Performs internal
#' k-fold cross-validaton to avoid overfitting on the provided data. The
#' best pipeline is then trained on the entire set of provided samples.
#'
#' @param obj A \code{TPOTClassifier} or a \code{TPOTRegressor}
#' @param feature A \code{data.frame} of observations
#' @param target List of class labels for prediction
#' @param sample_weights Per-sample weights. Higher weights indicate more importance. If specified,
#' sample_weight will be passed to any pipeline element whose fit() function accepts
#' a sample_weight argument. By default, using sample_weight does not affect tpot's
#' scoring functions, which determine preferences between pipelines.
#' @param group Group labels for the samples used when performing cross-validation.
#' This parameter should only be used in conjunction with sklearn's Group cross-validation
#' functions, such as sklearn.model_selection.GroupKFold
#' @return Returns a copy of the fitted TPOT Object
#' @export fit
fit <- function(obj, features, target, sample_weight = NULL, group = NULL) {
  UseMethod("fit")
}

#' @title Call fit and predict in sequence.
#' @description Call fit and predict in sequence.
#' @inheritParams fit
#' @export fit_predict
fit_predict <- function(obj, features, target, sample_weight = NULL, group = NULL) {
  UseMethod("fit_predict")
}

#' @title  Use the optimized pipeline to predict the target for a feature set
#' @description
#' @param obj A \code{TPOTClassifier} or a \code{TPOTRegressor}
#' @param feature A \code{data.frame} of observations
#' @return Predicted target for the samples in the feature matrix
#' @export
predict <- function(obj, ...){
  #print(class(obj))
  if (class(obj) == "WrappedModel")
    {stats::predict(obj, ...)}
  else {
    UseMethod("predict")
  }
}

#' @title  Use the optimized pipeline to estimate the class probabilities for a feature set.
#' @description
#' @param obj A \code{TPOTClassifier} or a \code{TPOTRegressor}
#' @param feature A \code{data.frame} of observations
#' @return The class probabilities of the input samples
#' @export predict_proba
predict_proba <- function(obj, features){
  UseMethod("predict_proba")
}

clean_pipeline_string <- function(obj, individual){
  UseMethod("clean_pipeline_string")
}

#' @title  Return the score on the given testing data using the user-specified scoring function.
#' @description
#' @param obj A \code{TPOTClassifier} or a \code{TPOTRegressor}
#' @param testing_features A \code{data.frame} of the testing set
#' @param testing_classes A \code{list} of class labels for prediction in the testing set
#' @return float The estimated test set accuracy
#' @export score
score <- function(obj, testing_features, testing_classes) {
  UseMethod("score")
}

#' @title Export the optimized pipeline as Python code
#' @description
#' @param obj A \code{TPOTClassifier} or a \code{TPOTRegressor}
#' @param path \code{String} containing the path and file name of the desired output file
#' @return The class probabilities of the input samples
#' @export export
export <- function(obj, path) {
  UseMethod("export")
}



##################
#' @export TPOTRClassifier
TPOTRClassifier <- function(generations=100,
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
  return(structure(list("Attributes" = inputClassifier,"TPOTObject" = createClassifier(inputClassifier)), class = "TPOTRClassifier"))
}

#' @export fit.TPOTRClassifier
fit.TPOTRClassifier <- function(obj, features, target, sample_weight = NULL, groups = NULL) {
  capture <- reticulate::py_capture_output(obj$TPOTObject <- fitTPOT(obj$TPOTObject, features, target, sample_weight, groups), c("stdout"))
  obj$capture <- capture
  return(obj)
}

#' @export fit_predict.TPOTRClassifier
fit_predict.TPOTRClassifier <- function(obj, features, target, sample_weight = NULL, groups = NULL) {
  fit_predictTPOT(obj$TPOTObject, features, target, sample_weight, groups)
}

#' @export predict.TPOTRClassifier
predict.TPOTRClassifier <- function(obj, features) {
  predictTPOT(obj$TPOTObject, features)
}

#' @export predict_proba.TPOTRClassifier
predict_proba.TPOTRClassifier <- function(obj, features) {
  predict_probaTPOT(obj$TPOTObject, features)
}

#' @export score.TPOTRClassifier
score.TPOTRClassifier <- function(obj, testing_features, testing_classes) {
  scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
}

clean_pipeline_string.TPOTRClassifier <- function(obj, individual) {
  clean_pipeline_stringTPOT(obj$TPOTObject, individual)
}

#' @export export.TPOTRClassifier
export.TPOTRClassifier <- function(obj, path) {
  exportTPOT(obj$TPOTObject, path)
}

##################

#' @export TPOTRRegressor
TPOTRRegressor <- function(generations=100,
                          population_size=100,
                          offspring_size=NULL,
                          mutation_rate=0.9,
                          crossover_rate=0.1,
                          scoring='neg_mean_squared_error',
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
  return(structure(list("Attributes" = inputRegressor,"TPOTObject" = createRegressor(inputRegressor)), class = "TPOTRRegressor"))
}

#' @export fit.TPOTRRegressor
fit.TPOTRRegressor <- function(obj, features, target, sample_weight = NULL, groups = NULL) {
  capture <- reticulate::py_capture_output(obj$TPOTObject <- fitTPOT(obj$TPOTObject, features, target, sample_weight, groups), c("stdout"))
  obj$capture <- capture
  return(obj)
}

#' @export fit_predict.TPOTRRegressor
fit_predict.TPOTRRegressor <- function(obj, features, target, sample_weight = NULL, groups = NULL) {
  fit_predictTPOT(obj$TPOTObject, features, target, sample_weight, groups)
}

#' @export predict.TPOTRRegressor
predict.TPOTRRegressor <- function(obj, features) {
  predictTPOT(obj$TPOTObject, features)
}

#' @export predict_proba.TPOTRRegressor
predict_proba.TPOTRRegressor <- function(obj, features) {
  predict_probaTPOT(obj$TPOTObject, features)
}

#' @export score.TPOTRRegressor
score.TPOTRRegressor <- function(obj, testing_features, testing_classes) {
  scoreTPOT(obj$TPOTObject, testing_features, testing_classes)
}

clean_pipeline_string.TPOTRRegressor <- function(obj, individual) {
  clean_pipeline_stringTPOT(obj$TPOTObject, individual)
}

#' @export export.TPOTRRegressor
export.TPOTRRegressor <- function(obj, path) {
  exportTPOT(obj$TPOTObject, path)
}

#' @export printPipeline
printPipeline <- function(obj){
  UseMethod("printPipeline")
}

#' @export printPipeline.WrappedModel
printPipeline.WrappedModel <- function(mod){
  cat(mod$learner.model$capture)
}

#' @export printPipeline.TPOTRRegressor
printPipeline.TPOTRRegressor <- function(obj){
  cat(obj$capture)
}

#' @export printPipeline.TPOTRClassifier
printPipeline.TPOTRClassifier <- function(obj){
  cat(obj$capture)
}

#' @export getGenerations
getGenerations <- function(obj){
  UseMethod("getGenerations")
}

#' @export getGenerations.WrappedModel
getGenerations.WrappedModel <- function(mod){
  capture = mod$learner.model$capture
  generations_list <- lapply(stringr::str_extract_all(capture, "score: 0.\\d+"), function(x){ #"score: 0. doesnt work with regression"
    as.numeric(sub("score: ", "", x))
  })
  generations <- unlist(generations_list)
}

#' @export getPipeline
getPipeline <- function(obj){
  UseMethod("getPipeline")
}

#' @export getPipeline.WrappedModel
getPipeline.WrappedModel <- function(mod){
  capture = mod$learner.model$capture
  pipeline <- gsub("^\\s+|\\s+$", "", sub(".*pipeline:", "", capture))
}

#' @export getPipeline.TPOTRRegressor
getPipeline.TPOTRRegressor <- function(obj){
  pipeline <- gsub("^\\s+|\\s+$", "", sub(".*pipeline:", "", obj$capture))
}

#' @export getPipeline.TPOTRClassifier
getPipeline.TPOTRClassifier <- function(obj){
  pipeline <- gsub("^\\s+|\\s+$", "", sub(".*pipeline:", "", obj$capture))
}


