Code structure for serial network. 
If anything is not clear or something is missing, please feel free to email a.maes17@imperial.ac.uk.

Code for simulations:

setup_network_simulation.m (run to launch a simulation)
training_simulation.m (code called when a target sequence is presented)
spontaneous_simulation.m (code called when running spontaneous dynamics)
clock_dynamics.m (code to only run the fast clock)

Code to set-up the networks:

createERNN.m (serial clock)
createReadOutRNN.m (read-out)

Code to plot spike rasters:
plotERNNRASTER (plots serial clock raster)
plotReadOutRASTER (plots read out raster)

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
target_dynamics.m (specifies the target sequence)

Code to compute variability:

variability_dynamics_plots.m (variability of serial clock)
between_within_var.m (computes variability in read-out directly)
target_dynamics_discr.m (specifies the target sequence for section 4)

Data: (plastic weights wRE are saved after every fifth training iteration)

wRE_serial_learning.mat (this mat-file save the learned weights at iteration 90 used in results section 2, 3 and 6)
wRE_serial_relearning.mat (this mat-file save the learned weights at iteration 240 used in results section 2, 3 and 6)
wRE_serial_20ms.mat (this mat-file save the learned weights at iteration 255 used in results section 4)
wRE_serial_25ms.mat (this mat-file save the learned weights at iteration 255 used in results section 4)
wRE_serial_40ms.mat (this mat-file save the learned weights at iteration 255 used in results section 4)
