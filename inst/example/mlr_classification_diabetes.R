library(mlbench)
library(mlr)
library(tpotr)

# predict diabetes
data(PimaIndiansDiabetes)
diabetes = PimaIndiansDiabetes

str(diabetes)

train_ind <- caret::createDataPartition(diabetes$diabetes, p = .75,
                                 list = FALSE,
                                 times = 1)
train <- diabetes[train_ind, ]
test <- diabetes[-train_ind, ]

task = makeClassifTask(data = train, target = "diabetes", id = "Diabetes")
lrn = makeLearner(cl = "classif.tpot", generations = 40, population_size = 10, n_jobs = 6, verbosity = 2)
model = train(lrn, task)
pred = predict(model, newdata = test)
performance(pred, measure = list(acc))
printPipeline(model)
