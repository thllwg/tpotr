import pandas as pd
from urllib.request import urlopen
import numpy as np
from sklearn.model_selection import train_test_split
from tpot import TPOTRegressor
import functools
print = functools.partial(print, flush=True)
#Preprocessing
wine_data = pd.read_csv('http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv',header=0, sep=";")

#Training and test data
wine = wine_data
wine_class = wine['quality'].values
training_indices, validation_indices = training_indices, testing_indices = train_test_split(wine.index,
                                                                                            stratify = wine_class,
                                                                                           train_size=0.75, test_size=0.25)

#TPOT
tpot = TPOTRegressor(verbosity=2, max_time_mins=1, max_eval_time_mins=0.04, population_size=15)
tpot.fit(wine.drop('quality',axis=1).loc[training_indices].values, wine.loc[training_indices,'quality'].values)
#print(tpot.score(wine.drop('quality',axis=1).loc[validation_indices].values, wine.loc[validation_indices,'quality'].values))

#print(wine_data)
