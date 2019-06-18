library("MASS")
library("mlr")

load_all(".")

# The following code illustrates how TPOT can be employed for performing a regression task over the Boston housing prices dataset.
# Running this code should discover a pipeline (exported as tpot_boston_pipeline.py) that achieves at least 10 mean squared error (MSE) on the test set:

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
learner = makeLearner(cl = "regr.tpot", predict.type = "response", id = "BostonHousing", population_size = 10, generations = 2, n_jobs = 3, verbosity = 2)
model = train(learner, task)
pred = predict(obj = model, newdata = test)
performance(pred, measures = list(mse))

# you can gain more insights into how the fitting of the model worked out:
getGenerations(model)
