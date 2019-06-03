makeRLearner.classif.tpot <- function(){
  makeRLearnerClassif(
    cl = "classif.tpot",
    package = "tpotr",
    par.set = makeParamSet(
      makeNumericLearnerParam(id = "generations", default = 5),
      makeNumericLearnerParam(id = "population_size", default = 15),
      # makeDiscreteLearnerParam(id = "offspring_size"),
      # makeNumericLearnerParam(id = "mutation_rate", lower = 0.0, upper = 1.0),
      # makeDiscreteLearnerParam(id = "crossover_rate", lower = 0.0, upper = 1.0),
      # makeUntypedLearnerParam(id = "scoring"),
      # makeIntegerLearnerParam(id = "cv", lower = 1),
      # makeNumericLearnerParam(id = "subsample", lower = 0.1),
      makeNumericLearnerParam(id = "n_jobs", lower = 1, default = 1),
      # makeIntegerLearnerParam(id = "max_time_mins"),
      # makeNumericLearnerParam(id = "max_eval_time_mins"),
      # makeIntegerLearnerParam(id = "random_state"),
      # makeUntypedLearnerParam(id = "config_dict"),
      # makeLogicalLearnerParam(id = "warm_start"),
      # makeUntypedLearnerParam(id = "memory"),
      # makeLogicalLearnerParam(id = "use_dask"),
      # makeUntypedLearnerParam(id = "periodic_checkpoint_folder"),
      # makeIntegerLearnerParam(id = "early_stop"),
      makeIntegerLearnerParam(id = "verbosity", lower = 0, upper = 3, default = 2),
      makeLogicalLearnerParam(id = "disable_update_check", default = TRUE)
    ),
    properties = c("twoclass", "multiclass", "numerics", "prob"),
    name = "Tree-based Pipeline Optimization Tool",
    short.name = "tpot",
    note = "Requires an Anaconda Installation"
  )
}
  trainLearner.classif.tpot <- function(.learner, .task, .subset, .weights = NULL, ...){
    data = getTaskData(task = .task, subset = .subset)
    features = data[, getTaskFeatureNames(.task)]
    target = getTaskTargets(.task)
    classifier = TPOTRClassifier(...)
    fit(classifier, features = features, target = target)
  }

  predictLearner.classif.tpot <- function(.learner, .model, .newdata, ...){
    p = tpotr::predict(.model$learner.model, features = .newdata)
    return(p)
  }



  makeRLearner.regr.tpot <- function(){
    makeRLearnerRegr(
      cl = "regr.tpot",
      package = "tpotr",
      par.set = makeParamSet(
        makeNumericLearnerParam(id = "generations", default = 5),
        makeNumericLearnerParam(id = "population_size", default = 15),
        # makeDiscreteLearnerParam(id = "offspring_size"),
        # makeNumericLearnerParam(id = "mutation_rate", lower = 0.0, upper = 1.0),
        # makeDiscreteLearnerParam(id = "crossover_rate", lower = 0.0, upper = 1.0),
        # makeUntypedLearnerParam(id = "scoring"),
        # makeIntegerLearnerParam(id = "cv", lower = 1),
        # makeNumericLearnerParam(id = "subsample", lower = 0.1),
        makeNumericLearnerParam(id = "n_jobs", lower = 1, default = 1),
        # makeIntegerLearnerParam(id = "max_time_mins"),
        # makeNumericLearnerParam(id = "max_eval_time_mins"),
        # makeIntegerLearnerParam(id = "random_state"),
        # makeUntypedLearnerParam(id = "config_dict"),
        # makeLogicalLearnerParam(id = "warm_start"),
        # makeUntypedLearnerParam(id = "memory"),
        # makeLogicalLearnerParam(id = "use_dask"),
        # makeUntypedLearnerParam(id = "periodic_checkpoint_folder"),
        # makeIntegerLearnerParam(id = "early_stop"),
        makeIntegerLearnerParam(id = "verbosity", lower = 0, upper = 3, default = 2),
        makeLogicalLearnerParam(id = "disable_update_check", default = TRUE)
      ),
      properties = c("twoclass", "numerics", "prob"),
      name = "Tree-based Pipeline Optimization Tool",
      short.name = "tpot",
      note = "Requires an Anaconda Installation"
    )
  }
  trainLearner.regr.tpot <- function(.learner, .task, .subset, .weights = NULL, ...){
    data = getTaskData(task = .task, subset = .subset)
    features = data[, getTaskFeatureNames(.task)]
    target = getTaskTargets(.task)
    regressor = TPOTRRegressor(...)
    fit(regressor, features = features, target = target)
  }

  predictLearner.regr.tpot <- function(.learner, .model, .newdata, ...){
    p = tpotr::predict(.model$learner.model, features = .newdata)
    return(p)
  }

