LF-TAS-project
This repository contains the scripts required to fit the lymphatic filariasis transmission model, EPIFIL, to site-specific conditions as it pertains to the manuscript:

Predicting lymphatic filariasis elimination in data-limited settings: a reconstructive computational framework for combining data generation and model discovery

Morgan E. Smith, Emily Griswold, Brajendra K. Singh, Emmanuel Miri, Abel Eigege, Solomon Adelamo, John Umaru, Kenrick Nwodu, Yohanna Sambo, Jonathan Kadimbo, Jacob Danyobi, Frank O. Richards, Edwin Michael*

*emichael@nd.edu

Basic workflow:

Define details of baseline transmission conditions and intervention details to simulate. These details can either be based on observed data or proposed scenarios. Details should be defined in "IO/baseline_data.m" and "IO/Intv_data.m". Following the data entry, make the corresponding edits to "IO/setup_Vars.m" and run this script. This script will generate required input files for running the simulations, which will be saved and accessed by other functions in "IO/IN".

First the model must be calibrated to the baseline conditions defined in the previous step. To do this, run the file "BaselineFitting/Main_ToRunBaselineFitting.m". This will select a set of best-fitting parameter vectors that reproduce the defined baseline conditions for use in subsequent simulations. The parameter vectors, along with baseline estimates of age-stratified infection prevalence and other key output variables, will be saved in a .mat file (one for each site modeled) called "IO/OUT/ParamVectors{SiteName}.mat". These files will be accessed by other functions in Hindcasting and Interventions.

If no baseline data is available for a given site, the above baseline fitting procedure will have been completed using plausible restrictions on the baseline transmission conditions. The resulting parameter vectors can be further refined by fitting to observed data during the intervention period. By running the file "Hindcasting/Main_ToRunHindcasting.m", the originally constrained parameter vectors will be further constrained by first simulating the observed interventions and then fitting to the observed data at a given point in time beyond the baseline year. The new parameter vectors, along with other key output variables, will be saved in a .mat file (one for each site modeled) called "IO/OUT/Hindcast{SiteName}.mat". The outputs stored here can be used in further analyses and will be accessed by other functions in Interventions.

To simulate interventions over time using the parameter vectors selected, by the BaselineFitting or Hindcasting procedures above, run the file "Interventions/Main_ToRunIntv.m". Check that the correct output file is being loaded in line 119 - either "IO/OUT/ParamVectors{SiteName}.mat" or "IO/OUT/Hindcast{SiteName}.mat" depending on which set of parameters are needed. Results of the intervention simulation will be saved in a .mat file one for each site modeled) called "IO/OUT/Intv{SiteName}.mat". The outputs stored here can be used in further analyses.
