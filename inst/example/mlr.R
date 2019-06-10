library("mlr")
data(iris)
# 75% of the sample size
smp_size <- floor(0.75 * nrow(iris))

# set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(iris)), size = smp_size)

train <- iris[train_ind, ]
test <- iris[-train_ind, ]
train[5] <- as.factor(as.numeric(train[[5]]))
test[5] <- as.factor(as.numeric(test[[5]]))

task = makeClassifTask(data = train, target = "Species", id = "iris")
learner = makeLearner(cl = "classif.tpot", population_size = 10, generations = 3, n_jobs = 3, verbosity = 2, predict.type = "prob")
model = train(learner, task)
predict(obj = model, newdata = test[,1:4])

##########################################################
library(caTools)
#REGRESSION1 - EXAMPLE2
data_wine <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"), header = TRUE, sep=";")
data_wine$"quality" <- as.numeric(as.character(data_wine$"quality"))

#Training-Test Split
set.seed(101)
sample_wine = sample.split(data_wine$`fixed.acidity`, SplitRatio = 2/3)
train_wine = subset(data_wine, sample_wine == TRUE)
train_wine.features = train_wine[,1:11]
train_wine.classes = train_wine[,12]
test_wine  = subset(data_wine, sample_wine == FALSE)
test_wine.features = test_wine[,1:11]
test_wine.classes = test_wine[,12]

task.regr = makeRegrTask(data = train_wine, target = "quality", id = "wine.regr")
learner.regr = makeLearner(cl = "regr.tpot", population_size = 50, generations = 11, n_jobs = 3, verbosity = 2)
model.regr = train(learner.regr, task.regr)
predict(obj = model.regr, newdata = test_wine.features)
