library(mlbench)
library(mlr)

data("Glass")

## 75% of the sample size
smp_size <- floor(0.75 * nrow(Glass))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(Glass)), size = smp_size)

train <- Glass[train_ind, ]
test <- Glass[-train_ind, ]

task = makeClassifTask(data = train, target = "Type", id = "Glass")
lrn = makeLearner(cl = "classif.tpot", generations = 40, population_size = 10, n_jobs = 6, verbosity = 2)
model = train(lrn, task)
pred = predict(model, newdata = test)
performance(pred, measure = list(acc))
printPipeline(model)
