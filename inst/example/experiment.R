# require("caTools")
#
# #CLASSIFICATION - EXAMPLE1
# #Preprocessing
# data <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data"), header = FALSE)
# colnames(data) <- c('Sample code number', 'Clump Thickness','Uniformity of Cell Size','Uniformity of Cell Shape','Marginal Adhesion','Single Epithelial Cell Size','Bare Nuclei','Bland Chromatin','Normal Nucleoli','Mitoses','Class')
# missing <- (apply(data, 1, function(x){any(x == "?")}))
# data <- data[!missing,]
# data$"Bare Nuclei" <- as.integer(as.character(data$"Bare Nuclei"))
# data <- data[,c(2:11)]
#
# #Training-Test Split
# set.seed(101)
# sample = sample.split(data$`Clump Thickness`, SplitRatio = 2/3)
# train = subset(data, sample == TRUE)
# train.features = train[,1:9]
# train.classes = train[,10]
# test  = subset(data, sample == FALSE)
# test.features = test[,1:9]
# test.classes = test[,10]
#
# #Pipeline
# c <- TPOTClassifier(verbosity=2, max_time_mins=1, max_eval_time_mins=0.04, population_size=15)
# fit(c, train.features, train.classes)
# p <- predict(c, test.features)
# score(c, test.features, test.classes)
#
# export(c, "testTPOT.py")
#
#
# #REGRESSION1 - EXAMPLE2
# data_wine <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"), header = TRUE, sep=";")
# data_wine$"quality" <- as.numeric(as.character(data_wine$"quality"))
#
# #Training-Test Split
# set.seed(101)
# sample_wine = sample.split(data_wine$`fixed.acidity`, SplitRatio = 2/3)
# train_wine = subset(data_wine, sample_wine == TRUE)
# train_wine.features = train_wine[,1:11]
# train_wine.classes = train_wine[,12]
# test_wine  = subset(data_wine, sample_wine == FALSE)
# test_wine.features = test_wine[,1:11]
# test_wine.classes = test_wine[,12]
#
# #Pipeline
# c_wine <- TPOTRegressor(verbosity=2, max_time_mins=1, population_size=50)
# fit(c_wine, train_wine.features, train_wine.classes)
# p_wine <- predict(c_wine, test_wine.features)
# score(c_wine, test_wine.features, test_wine.classes)
# export(c_wine, "testTPOT_wine.py") #e.g. "/Users/christianwerner/Git/LearnPython/LearnTPOT/testTPOT_wine.py"
#
# #REGRESSION2 - EXAMPLE3
# path = system.file("data", "Concrete_Data.csv", package = "tpotr")
# data_concrete <- read.csv(path, header = TRUE, sep = ";")
#
# #Preprocessing
# data_concrete$"Cement" <- as.numeric((data_concrete$"Cement"))
# data_concrete$"Blast.Furnace.Slag" <- as.numeric((data_concrete$"Blast.Furnace.Slag"))
# data_concrete$"Fly.Ash" <- as.numeric((data_concrete$"Fly.Ash"))
# data_concrete$"Water" <- as.numeric((data_concrete$"Water"))
# data_concrete$"Superplasticizer" <- as.numeric((data_concrete$"Superplasticizer"))
# data_concrete$"Coarse.Aggregate" <- as.numeric((data_concrete$"Coarse.Aggregate"))
# data_concrete$"Fine.Aggregate" <- as.numeric((data_concrete$"Fine.Aggregate"))
# data_concrete$"Age.by.day" <- as.numeric((data_concrete$"Age.by.day"))
# data_concrete$"Concrete.compressive.strength" <- as.numeric((data_concrete$"Concrete.compressive.strength"))
#
# #Training-Test Split
# set.seed(101)
# sample_concrete = sample.split(data_concrete$`Cement`, SplitRatio = 2/3)
# train_concrete = subset(data_concrete, sample_concrete == TRUE)
# train_concrete.features = train_concrete[,1:8]
# train_concrete.classes = train_concrete[,9]
# test_concrete  = subset(data_concrete, sample_concrete == FALSE)
# test_concrete.features = test_concrete[,1:8]
# test_concrete.classes = test_concrete[,9]
#
# #Pipeline
# c_concrete <- TPOTRegressor(verbosity=2, max_time_mins=2, population_size=50, n_jobs = 4)
# fit(c_concrete, train_concrete.features, train_concrete.classes)
# score(c_concrete, test_concrete.features, test_concrete.classes)
# p_concrete <- predict(c_concrete, test_concrete.features)
#
#
