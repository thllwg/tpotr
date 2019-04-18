from tpot import TPOTClassifier, TPOTRegressor
import sys
import functools
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

#print = functools.partial(print, flush=True) #https://stackoverflow.com/questions/230751/how-to-flush-output-of-print-function

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
    print("---Built TPOTClassifier---", flush=True) #https://stackoverflow.com/questions/10019456/usage-of-sys-stdout-flush-method
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
    print("---Built TPOTRegressor---", flush=True) #https://stackoverflow.com/questions/10019456/usage-of-sys-stdout-flush-method
    return tpot

def fitTPOT(tpot, features, classes):
    tpot.fit(features, classes)
    print("---Finished Fitting---", flush=True) #Or flush

def predictTPOT(tpot, features):
    print("---Finished Prediction---", flush=True)
    return(tpot.predict(features))

def scoreTPOT(tpot, testing_features, testing_classes):
    print("---Finished Scoring---", flush=True)
    return(tpot.score(testing_features, testing_classes))

def exportTPOT(tpot, path):
    tpot.export(path)
    print("---Exported File---", flush=True)