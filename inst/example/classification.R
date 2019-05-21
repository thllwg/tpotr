# #CLASSIFICATION - EXAMPLE1
# require("caTools")
# #
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
