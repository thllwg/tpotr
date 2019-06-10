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

#Pipeline
c_wine <- TPOTRRegressor(verbosity=2, max_time_mins=2, population_size=50)
fit(c_wine, train_wine.features, train_wine.classes)
p_wine <- predict(c_wine, test_wine.features)
score(c_wine, test_wine.features, test_wine.classes)
export(c_wine, "testTPOT_wine.py")
