%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Long-term plasticity E-RNN to read-out
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%symmetric window with depression 
w_Emax = 1;                 %maximal read-out weight strength

A_Epot = 0.045/1.5;
A_Edep = 0.0000010/1.5;

tau_xE = 5;
tau_yE = 5;

x_E = zeros(1,EneuronNum);
y_E = zeros(1,REneuronNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Long-term plasticity E-RNN slow to syllable interneurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STDP type rule, inhibitory neurons firing together, do not wire together

w_Imax = 0.3;

A_Ipot = 0.025; %maybe also here divide by 1.5 both to make it a little slower
A_Idep = 0.0000010; 

tau_xI = 20;
tau_yI = 20;

x_I = zeros(1,EneuronNum_slow);
y_I = zeros(1,SyllIneuronNum);