library("mlr")
library("tpotr")
data(iris)
# 75% of the sample size
smp_size <- floor(0.75 * nrow(iris))

# set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(iris)), size = smp_size)

train <- iris[train_ind, ]
test <- iris[-train_ind, ]

task = makeClassifTask(data = train, target = "Species", id = "iris")
learner = makeLearner(cl = "classif.tpot", population_size = 10, generations = 3, n_jobs = 3, verbosity = 2)
model = train(learner, task)
pred = predict(obj = model, newdata = test)
print(pred)
performance(pred, measures = list(acc))
