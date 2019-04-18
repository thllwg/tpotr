import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from tpot import TPOTClassifier, TPOTRegressor

#Preprocessing
med_data = pd.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data',header=None)
med_data.columns = ['Sample code number', 'Clump Thickness','Uniformity of Cell Size','Uniformity of Cell Shape','Marginal Adhesion','Single Epithelial Cell Size','Bare Nuclei','Bland Chromatin','Normal Nucleoli','Mitoses','Class']
med_data_clean = med_data[(med_data.astype(str) != '?').all(axis=1)]
med_data_clean = med_data_clean.drop(['Sample code number'], axis=1)
med_data_clean = med_data_clean.drop(['Bare Nuclei'], axis=1)
med_data_clean = med_data_clean.iloc[np.random.permutation(len(med_data_clean))]
med_data_clean = med_data_clean.reset_index(drop=True)

#Training and test data
med = med_data_clean
med_class = med['Class'].values
training_indices, validation_indices = training_indices, testing_indices = train_test_split(med.index,
                                                                                            stratify = med_class,
                                                                                            train_size=0.75, test_size=0.25)

#TPOT
tpot = TPOTClassifier(verbosity=2, max_time_mins=1, max_eval_time_mins=0.04, population_size=15)
tpot.fit(med.drop('Class',axis=1).loc[training_indices].values, med.loc[training_indices,'Class'].values)
print(tpot.score(med.drop('Class',axis=1).loc[validation_indices].values, med.loc[validation_indices,'Class'].values))
tpot.export('Breast_Cancer_Pipeline.py')

#Check out data
#print(training_indices.size, validation_indices.size)
#print(med_data_clean.info())
#print(pd.isnull(med).any())
#print(med_data_clean.describe())
#print(med_data_clean['Bare Nuclei'].value_counts())
#print(med_data_clean)
#print(med_data_clean.loc[:,'Bare Nuclei'])




