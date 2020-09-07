Code structure for hierarchical network. 
If anything is not clear or something is missing, please feel free to email a.maes17@imperial.ac.uk.

Code for simulations:

setup_network_simulation.m (run to launch a simulation)
training_simulation.m (code called when a target sequence is presented)
spontaneous_simulation.m (code called when running spontaneous dynamics)
fast_dynamics.m (code to only run the fast clock)
slow_dynamics.m (code to only run the slow clock)
motif_only_dynamics.m (code to run the the fast dynamics and read-out network only)

Code to set-up the networks:

createERNN.m (fast clock)
createERNN_slow.m (slow clock)
createSyllableRNN.m (interneurons)
createReadOutRNN.m (read-out)

Code to plot spike rasters:

plotERNNRASTER.m (plots fast clock raster)
plotERNNRASTER_slow.m (plots slow clock raster)
plotSyllableRaster.m (plots interneuron raster)
plotReadOutRaster.m (plots read out raster)

Code to set all the parameters:

read_out_network.m (initializes all weights between the networks)
dynamics_parameters.m (neural dynamics parameters)
plasticity_parameters.m (stdp parameters)
external_input.m (sets external spike train rates)
test_setup.m (sets the weights between networks)
set_target.m (sets the target sequence to be presented to the read-out)

Code to compute error curves:

dynamics_learning_plot.m (compute error as learning progresses)
compute_error.m (function to compute error between spike train and target)
compute_error_motifs.m (function to compute the motif error between spike train and target)
target_dynamics.m (specifies the target sequence)

Code to compute variability:

variability_dynamics_plots.m (variability of slow and fast clock)
between_within_var.m (computes variability in read-out directly)
target_dynamics_discr.m (specifies the target sequence)

Data: (wRE = motif weights and wSyllE = syntax weights)

wRE_learning.mat 
wSyllE_learning.mat (this and previous mat-file save the learned weights at iteration 50 used in results section 2,3 & 6)
wRE_relearning.mat 
wSyllE_relearning.mat (this and previous mat-file save the learned weights at iteration 160 used in results section 2,3 & 6)
wRE_capacity.mat
wSylle_capacity.mat (this and previous mat-file save the learned weights at iteration 80 used in results section 5)
wRE_20ms.mat
wSyllE_20ms.mat (this and previous mat-file save the learned weights at iteration 85 used in results section 4)
wRE_25ms.mat
wSyllE_25ms.mat (this and previous mat-file save the learned weights at iteration 85 used in results section 4)
wRE_40ms.mat
wSyllE_40ms.mat (this and previous mat-file save the learned weights at iteration 85 used in results section 4)
