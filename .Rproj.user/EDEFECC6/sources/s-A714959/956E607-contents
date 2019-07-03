[![Build Status](https://travis-ci.com/thllwg/tpotr.png?branch=master)](https://travis-ci.com/thllwg/tpotr)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# tpotr
An R-Wrapper for the Python Automated Machine Learning tool that optimizes machine learning pipelines using genetic programming (TPOT)

## R interface to TPOT
With *tpotr* automated machine learning based on the [Python Automated Machine Learning Tool](https://github.com/EpistasisLab/tpot) becomes available in R. Tree-based pipeline optimization can be utilized directly or as a `mlr` learner.
      
## Getting Started

### System Requirements
The package *tpotr* works on macOS and Linux systems, that have a working installation of the python/R data science platform [Anaconda](https://www.anaconda.com/distribution/). 

### Installation
Make sure that the `devtools`package is installed, or install it with:
```r
install.packages("devtools")
```
Now, install the tpotr R package from GitHub as follows:
```r
devtools::install_github("thllwg/tpotr")
```
The *tpotr* interface uses the reference TPOT python implementation as its backend. The required python libraries are installed during package load. On package load, the systems verifies the availability of the required dependencies and installs them (again) if necessary. Internally, `install_tpot()` is called for that. If the installation routine has been completed successfully, "Welcome to TPOT in R" appears in the console.

### Fitting a machine learning pipeline
Below we walk through a simple example of using TPOT in R to fit a machine learning pipeline to predict the Species in the well-known `iris` dataset. After getting familiar with the basics, check out the tutorials and additional learning resources available as package vignettes.

The `iris` flower dataset is a multivariate data set consisting 50 samples from each of three species of Iris, with four measured features from each sample.

We first split the dataset to get one for training and one for validation purposes:
```r
library(tpotr)
data(iris)
# 75% of the sample size
smp_size <- floor(0.75 * nrow(iris))

# set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(iris)), size = smp_size)

train <- iris[train_ind, ]
test <- iris[-train_ind, ]
train[5] <- as.numeric(train[[5]])
test[5] <- as.numeric(test[[5]])
```
We use the four features to predict the species of the flower. As this is a classification task, first a TPOTRClassifier object will be instantiated. Of the variety of parameters, we decide to have the Classifier train over 5 generations with a population size of 15 individuals each. The `fit` method starts the training.
```r
classifier <- TPOTRClassifier(verbosity=2, generations = 5, population_size=15, n_jobs = 3)
fit(classifier, train[1:4], train[5])
```
You can now use the fitted pipeline for predictions. To assess the accurancy of the predictions, the score() method can be used. While *accurancy* is the default measure in classification with tpot, other means can be used by submitting different scoring functions during the TPOTRClassifier instantiation.
```r
predict(classifier, test[1:4])
score(classifier, test[1:4], test[5])
```

### Fitting a machine learning pipeline with mlr
The tpotr package supports integration with the [Machine Learning in R](https://mlr.mlr-org.com/) package `mlr`. 
```r
library("mlr")
train[5] <- as.factor(as.numeric(train[[5]]))
test[5] <- as.factor(as.numeric(test[[5]]))
task = makeClassifTask(data = train, target = "Species", id = "iris")
learner = makeLearner(cl = "classif.tpot", population_size = 10, generations = 3, n_jobs = 3, verbosity = 2)
model = train(learner, task)
pred = predict(obj = model, newdata = test)
performance(pred, measures = list(acc))
```

### Regression with tpotr
You can use tpotr in similar ways for regression tasks. Just exchange the `TPOTRClassifier`with the `TPOTRRegressor`. If you want to use tpotr with mlr for regression tasks, make sure to use the corresponding task, i.e. `makeRegrTask`.

## Troubleshooting
Currently there is a range of problems in tpotr. Not all of them are listed below:
  
* During the training TPOT issues numerous warnings and deprecation messages.

*tpotr* is an interface for the underlying Python implementation of TPOT. It uses numerous Python libraries, some of which are in dependency conflicts. The (Python) TPOT authors are aware of the problem, some of the bugs should be fixed in the upcoming version (see [issue](https://github.com/EpistasisLab/tpot/issues/869))

* When training a regressor, TPOT terminates with the error message that the data is incorrectly formatted or the incorrect TPOT type (classifier) is in use.

   I don't know. Despite the misleading error message, the real problem seems to be the lack of training time or number of generations? If you play around with the values, the regressor should run through at some point. It also may be a pointer problem? Anyway, if you find the bug please commit a fix :)

* When using the mlr integration with `predict.type="prob"`, an error occurs after using the predict method.

   TPOT sometimes returns a pipeline that does not support class-probabilities in predictions. See the mlr examples in the corresponding `examples`folder on how to write a loop that fits a new model in such cases. 

## Acknowledgements
This package is based on the amazing work of Randal S. Olson et al. and the respective [github repository](https://github.com/EpistasisLab/tpot).

## Authors

* **Thorben Hellweg** - [thllwg](https://github.com/thllwg)
* **Christopher Olbrich** - [ChristopherOlbrich](https://github.com/ChristopherOlbrich) 
* **Christian Werner** - [Bl7tzcrank](https://github.com/Bl7tzcrank)
