context("Classification")

test_that("a classification object is created", {
  c <- TPOTClassifier(verbosity=2, max_time_mins=1, max_eval_time_mins=0.04, population_size=15)
  expect_true(BBmisc::isSubset(c("tpot.tpot.TPOTClassifier", "tpot.base.TPOTBase", "sklearn.base.BaseEstimator", "python.builtin.object"), class(c)))
})
