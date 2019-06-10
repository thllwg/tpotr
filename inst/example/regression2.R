require("caTools")
#
#REGRESSION2 - EXAMPLE3
path = system.file("data", "Concrete_Data.csv", package = "tpotr")
data_concrete <- read.csv(path, header = TRUE, sep = ";")

#Preprocessing
data_concrete$"Cement" <- as.numeric((data_concrete$"Cement"))
data_concrete$"Blast.Furnace.Slag" <- as.numeric((data_concrete$"Blast.Furnace.Slag"))
data_concrete$"Fly.Ash" <- as.numeric((data_concrete$"Fly.Ash"))
data_concrete$"Water" <- as.numeric((data_concrete$"Water"))
data_concrete$"Superplasticizer" <- as.numeric((data_concrete$"Superplasticizer"))
data_concrete$"Coarse.Aggregate" <- as.numeric((data_concrete$"Coarse.Aggregate"))
data_concrete$"Fine.Aggregate" <- as.numeric((data_concrete$"Fine.Aggregate"))
data_concrete$"Age.by.day" <- as.numeric((data_concrete$"Age.by.day"))
data_concrete$"Concrete.compressive.strength" <- as.numeric((data_concrete$"Concrete.compressive.strength"))

#Training-Test Split
set.seed(101)
sample_concrete = sample.split(data_concrete$`Cement`, SplitRatio = 2/3)
train_concrete = subset(data_concrete, sample_concrete == TRUE)
train_concrete.features = train_concrete[,1:8]
train_concrete.classes = train_concrete[,9]
test_concrete  = subset(data_concrete, sample_concrete == FALSE)
test_concrete.features = test_concrete[,1:8]
test_concrete.classes = test_concrete[,9]

#Pipeline
c_concrete <- TPOTRRegressor(verbosity=2, max_time_mins=3, population_size=50, n_jobs = 4)
fit(c_concrete, train_concrete.features, train_concrete.classes)
score(c_concrete, test_concrete.features, test_concrete.classes)
predict(c_concrete, test_concrete.features)
predict_proba(c_concrete, test_concrete.features)
