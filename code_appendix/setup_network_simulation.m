%% Two pathway model: set-up of networks, parameters and simulation 
% One fast E sequential network controlling individual syllables
% and one slow I sequential network controlling syllable ordering

clear
spontaneous = true; %boolean: spontaneous dynamics or training simulation

%% Set up weight matrix of recurrent networks
% the network parameters can be changed in the scripts

createERNN;
createIRNN;
createSyllableRNN;
createReadOutRNN;

%% Set up connectivity between the recurrent networks
% the read-out network parameters can be changed in the scripts

read_out_network;

%% Parameters for neural and synaptic dynamics of E and I neurons
% standard parameters from literature

dynamics_parameters;

%% Short and long term plasticity
% standard parameters from literature 

plasticity_parameters;

%% External input to E-RNN and I-RNN

external_input;

%% Launch simulation

dt = 0.1; %Euler discretization time step [ms]
T = 1000; %total simulation time [ms]
if spontaneous
    test_setup; %set connectivity between networks
    spontaneous_simulation; %no plasticity
else
    nb_its = 15; %number of iterations (one full sequence presentation per iteration)
    test_setup; %set initial connectivity between networks
    training_simulation; %supervisor input and plasticity
end


%% Plotting

if spontaneous
    figure()
    subplot(3,2,1)
    plotERNNRASTER
    subplot(3,2,2)
    plotIRNNRASTER
    subplot(3,2,3)
    plotReadOutRASTER
    subplot(3,2,4)
    plotSyllableRASTER
    subplot(3,2,5)
    imagesc(wRE(end:-1:1,:))
    colorbar
    subplot(3,2,6)
    imagesc(wSyllIRNN(end:-1:1,:))
    colorbar    
end
