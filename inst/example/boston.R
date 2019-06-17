library("MASS")
library("mlr")
data("Boston")

# The following code illustrates how TPOT can be employed for performing a regression task over the Boston housing prices dataset.
# Running this code should discover a pipeline (exported as tpot_boston_pipeline.py) that achieves at least 10 mean squared error (MSE) on the test set:

# 75% of the sample size
smp_size <- floor(0.75 * nrow(Boston))
# set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(Boston)), size = smp_size)

train <- Boston[train_ind, ]
test <- Boston[-train_ind, ]
#train[14] <- as.factor(as.numeric(train[[14]]))
#test[14] <- as.factor(as.numeric(test[[14]]))

task = makeRegrTask(data = Boston, target = "medv")
learner = makeLearner(cl = "regr.tpot", predict.type = "response", id = "BostonHousing", population_size = 20, generations = 4, n_jobs = 3, verbosity = 2)
model = train(learner, task)
pred = predict(obj = model, newdata = test)
performance(pred, measures = list(mse))
getPipeline(model)
getGenerations(mod)
