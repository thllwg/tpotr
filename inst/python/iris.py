from tpot import TPOTClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import numpy as np

iris = load_iris()
X_train, X_test, y_train, y_test = train_test_split(iris.data.astype(np.float64),
                                                    iris.target.astype(np.float64), train_size=0.75, test_size=0.25)
print(type(X_train))
print(type(X_test))
print(type(y_train))
print(type(y_test))
tpot = TPOTClassifier(generations=5, population_size=50, verbosity=2)
tpot.fit(X_train, y_train)
print(tpot.predict(X_test))
print(tpot.predict_proba(X_test))
print(tpot.score(X_test, y_test))

