Code structure for hierarchical network presented in the appendix. 
If anything is not clear or something is missing, please feel free to email a.maes17@imperial.ac.uk.

Code for simulations:

setup_network_simulation.m (run to launch a simulation)
training_simulation.m (code for presentation of a target sequence)
spontaneous_simulation.m (code running spontaneous dynamics)
fast_dynamics.m (code to only run the fast clock)
IRNN_test.m (code to only run the slow clock)
motif_only_dynamics.m (code to run the the fast dynamics and read-out network only)

Code to set-up the networks:

createERNN.m (fast clock)
createIRNN.m (slow clock)
createSyllableRNN.m (interneurons)
createReadOutRNN.m (read-out)

Code to plot spike rasters:

plotERNNRASTER.m (plots fast clock raster)
plotIRNNRASTER_slow.m (plots slow clock raster)
plotSyllableRaster.m (plots interneuron raster)
plotReadOutRaster.m (plots read out raster)

Code to set all the parameters:

read_out_network.m (initializes all weights between the networks)
dynamics_parameters.m (neural dynamics parameters)
plasticity_parameters.m (stdp parameters)
external_input.m (sets external spike train rates)
test_setup.m (sets the weights between networks)
set_target.m (sets the target sequence to be presented to the read-out)


Data: (motif and syntax weights are saved after every fifth training iteration, wRE = motif weights and wSyllIRNN = syntax weights)

wRE_learning.mat 
wSyllIRNN_learning.mat (this and previous mat-file save the learned weights used in appendix)
