context("Classification")

test_that("a classification object is created", {
  data(iris)
  ## 75% of the sample size
  smp_size <- floor(0.75 * nrow(iris))
  ## set the seed to make your partition reproducible
  set.seed(123)
  train_ind <- sample(seq_len(nrow(iris)), size = smp_size)
  train <- iris[train_ind, ]
  test <- iris[-train_ind, ]
  train.features <- train[1:4]
  train.classes <- as.numeric(train[[5]])#as.factor(train[[5]])
  test.features <- test[1:4]
  test.classes <- as.numeric(test[[5]])#as.factor(test[[5]])

  c <- TPOTRClassifier(verbosity=2, max_time_mins=1, max_eval_time_mins=0.04, population_size=15)
  expect_true(BBmisc::isSubset(c("TPOTRClassifier"), class(c)))
  expect_true(BBmisc::isSubset(c("tpot.tpot.TPOTClassifier", "tpot.base.TPOTBase", "sklearn.base.BaseEstimator", "python.builtin.object"), class(c$TPOTObject)))
  fit(c, train.features, train.classes)
  p <- predict(c, test.features)
  s <- score(c, test.features, test.classes)
  expect_true(is.numeric(s))
})
