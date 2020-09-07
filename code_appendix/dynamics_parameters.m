%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for both E and I Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vreset = -60;       %Reset for both exc and inh neurons
C = 300;            %capacitance
tau_abs = 5;        %refractory period

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the E-Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vthres = 20;        %Spiking threshold for exc neurons
tau_E = 20;         %Membrane Time Constant
V_E = -70;          %resting potential 
DET = 2;            %slope of exponential
E_E = 0;            %reversal potential
V_T = -52;          %threshold potential (the spiking threshold for inh neurons)
A_T = 10;           %post spike threshold potential increase
tau_T = 30;         %adaptive threshold time scale
EVthreshold = V_T*ones(1,EneuronNum); %neuronal threshold vector for all exc neurons
EVthresholdR = V_T*ones(1,REneuronNum);
tau_w = 100;                            %adaptation time constant
a = 4;                                  %adaptation slope
b = 0.805;                               %adaptation amplitude
w = a*(Vreset-V_E)*ones(1,EneuronNum);  %adaptation vector for all exc neurons
wR = a*(Vreset-V_E)*ones(1,REneuronNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the I-Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tau_I = 20;         %Membrane Time Constant
V_I = -62;          %resting potential
E_I = -75;          %reversal potential

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Synaptic dynamics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tauedecay = 6;      %decay time for e-synapses
tauerise = 1;       %rise time of e-synapses
tauidecay = 2;      %decay time for i-synapses
tauirise = 0.5;     %rise time of i-synapses

%E-RNN
xedecay = zeros(1,neuronNum);
xerise = zeros(1,neuronNum);
xidecay = zeros(1,neuronNum);
xirise = zeros(1,neuronNum);

%I-RNN
xIRNNedecay = zeros(1,IRNN_size);
xIRNNerise = zeros(1,IRNN_size);
xIRNNidecay = zeros(1,IRNN_size);
xIRNNirise = zeros(1,IRNN_size);

%Syllables
xSylledecay = zeros(1,SyllIneuronNum);
xSyllerise = zeros(1,SyllIneuronNum);
xSyllidecay = zeros(1,SyllIneuronNum);
xSyllirise = zeros(1,SyllIneuronNum);

%Read-outs
xRedecay = zeros(1,RneuronNum);
xRerise = zeros(1,RneuronNum);
xRidecay = zeros(1,RneuronNum);
xRirise = zeros(1,RneuronNum);

