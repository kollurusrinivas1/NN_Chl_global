# NN_Chl_global
This repository consists of neural network models developed to estimate Chl-a in global ocean waters.

"finalrpnet.mat"            -> contains the developed neural network model
"only_nets_nn_hyp_5050.mat" -> contains the mean and standard deviation values used to transform the data
"svm_default_gauss_model_trained.mat" -> contains the trained svm model in default configuration
"OC4_OCI_Satswifs6w.mat"    -> contains the SeaWiFS matchup dataset along with OC4 and OCI stats for the same


Run the script "nn_rp_testing_satseawifs.m" to load the neural nets stored and estimate Chl-a using seawifs matchup-dataset.
