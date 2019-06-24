context("Integration of tpotr in mlr")

test_that("class prediction works in mlr", {
  library("mlr")
  data(iris)
  # set the seed to make your partition reproducible
  set.seed(123)
  # 75% of the sample size
  smp_size <- floor(0.75 * nrow(iris))
  train_ind <- sample(seq_len(nrow(iris)), size = smp_size)
  train <- iris[train_ind, ]
  test <- iris[-train_ind, ]
  train[5] <- as.factor(as.numeric(train[[5]]))
  test[5] <- as.factor(as.numeric(test[[5]]))

  task = makeClassifTask(data = train, target = "Species", id = "iris")
  learner = makeLearner(cl = "classif.tpot", population_size = 1, generations = 1, n_jobs = 1, verbosity = 2)
  expect_true(BBmisc::isSubset(c("classif.tpot"), class(learner)))
  model = train(learner, task)
  pred = predict(obj = model, newdata = test)
  expect_true(BBmisc::isSubset(c("WrappedModel"), class(model)))
  expect_true(is.numeric(performance(pred, measures = list(acc))))
})

test_that("class probability prediction works in mlr", {
  library("mlr")
  data(iris)
  # set the seed to make your partition reproducible
  set.seed(123)
  # 75% of the sample size
  smp_size <- floor(0.75 * nrow(iris))
  train_ind <- sample(seq_len(nrow(iris)), size = smp_size)
  train <- iris[train_ind, ]
  test <- iris[-train_ind, ]
  train[5] <- as.factor(as.numeric(train[[5]]))
  test[5] <- as.factor(as.numeric(test[[5]]))

  task = makeClassifTask(data = train, target = "Species", id = "iris")
  learner = makeLearner(cl = "classif.tpot", predict.type = "prob", population_size = 1, generations = 1, n_jobs = 1, verbosity = 2)
  expect_true(BBmisc::isSubset(c("classif.tpot"), class(learner)))
  mod = NULL; pred = NULL; again = TRUE;
  # predity.type = "prob" of learner is not supported by every possible tpot pipeline
  # to ensure that tpot returns a pipeline that supports the "prob" property,
  # iterate over the training until such pipeline is found.
  while(again == TRUE){
    result = try({
      mod = train(learner, task)
      pred = predict(obj = mod, newdata = test)
    }, silent = TRUE)
    if (inherits(result, "try-error")){
      again = TRUE
    } else {
      again = FALSE
    }
  }
  expect_true(BBmisc::isSubset(c("WrappedModel"), class(mod)))
  expect_true(is.numeric(performance(pred, measures = list(acc))))
})

test_that("regression works in mlr", {
  library("mlr")
  library("MASS")
  data("Boston")
  # reproductibility
  set.seed(123)
  # test_train_split
  # 75% of the sample size for training
  smp_size <- floor(0.75 * nrow(Boston))
  # set the seed to make your partition reproducible
  train_ind <- sample(seq_len(nrow(Boston)), size = smp_size)
  train <- Boston[train_ind, ]
  test <- Boston[-train_ind, ]

  # we are using the mlr integration to predict the target variable
  task = makeRegrTask(data = Boston, target = "medv")
  learner = makeLearner(cl = "regr.tpot", predict.type = "response", id = "BostonHousing", population_size = 2, generations = 2, n_jobs = 1, verbosity = 2)
  expect_true(BBmisc::isSubset(c("regr.tpot"), class(learner)))
  model = train(learner, task)
  pred = predict(obj = model, newdata = test)
  expect_true(BBmisc::isSubset(c("WrappedModel"), class(model)))
  expect_true(is.numeric(performance(pred, measures = list(mse))))
})

