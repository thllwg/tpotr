from tpot import TPOTClassifier, TPOTRegressor
import sys
import functools
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

def createClassifier(config):    
    tpot = TPOTClassifier(generations=int(config["generations"]), 
                           population_size=int(config["population_size"]),
                           offspring_size=None if config["offspring_size"] is None else int(config["offspring_size"]), 
                           mutation_rate=config["mutation_rate"],
                           crossover_rate=config["crossover_rate"],
                           scoring=config["scoring"], 
                           cv=int(config["cv"]),
                           subsample=config["subsample"], 
                           n_jobs=int(config["n_jobs"]),
                           max_time_mins=None if config["max_time_mins"] is None else int(config["max_time_mins"]),
                           max_eval_time_mins=config["max_eval_time_mins"],
                           random_state=None if config["random_state"] is None else int(config["random_state"]),
                           config_dict=config["config_dict"],
                           warm_start=config["warm_start"],
                           memory=config["memory"],
                           use_dask=config["use_dask"],
                           periodic_checkpoint_folder=config["periodic_checkpoint_folder"],
                           early_stop=None if config["early_stop"] is None else int(config["early_stop"]),
                           verbosity=config["verbosity"],
                           disable_update_check=config["disable_update_check"])
    return tpot

def createRegressor(config):    
    tpot = TPOTRegressor(generations=int(config["generations"]), 
                           population_size=int(config["population_size"]),
                           offspring_size=None if config["offspring_size"] is None else int(config["offspring_size"]), 
                           mutation_rate=config["mutation_rate"],
                           crossover_rate=config["crossover_rate"],
                           scoring=config["scoring"], 
                           cv=int(config["cv"]),
                           subsample=config["subsample"], 
                           n_jobs=int(config["n_jobs"]),
                           max_time_mins=None if config["max_time_mins"] is None else int(config["max_time_mins"]),
                           max_eval_time_mins=config["max_eval_time_mins"],
                           random_state=None if config["random_state"] is None else int(config["random_state"]),
                           config_dict=config["config_dict"],
                           warm_start=config["warm_start"],
                           memory=config["memory"],
                           use_dask=config["use_dask"],
                           periodic_checkpoint_folder=config["periodic_checkpoint_folder"],
                           early_stop=None if config["early_stop"] is None else int(config["early_stop"]),
                           verbosity=config["verbosity"],
                           disable_update_check=config["disable_update_check"])
    return tpot

def fitTPOT(tpot, features, target, sample_weight=None, groups=None):
    tpot.fit(features, target, sample_weight, groups)
    print("", flush = True)
    return(tpot)

def fit_predictTPOT(tpot, features, target, sample_weight=None, groups=None):
    tpot.fit_predict(features, target, sample_weight, groups)
    print("", flush = True)
    return(tpot)

def predictTPOT(tpot, features):
    return(tpot.predict(features))

def predict_probaTPOT(tpot, features):
    return(tpot.predict_proba(features))

def clean_pipeline_stringTPOT(tpot, individual):
    return(tpot.clean_pipeline_string(individual))

def scoreTPOT(tpot, testing_features, testing_classes):
    return(tpot.score(np.asarray(testing_features), np.asarray(testing_classes)))

def exportTPOT(tpot, path):
    tpot.export(path)
