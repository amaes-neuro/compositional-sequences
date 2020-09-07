%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Short-term plasticity in I-RNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% short term depression (Tsodyks type)

x_IRNN = ones(1,IRNN_size);  %depression
tau_x_IRNN = 200;            %time constant of depression
u_IRNN = 0.7;                %depression constant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Long-term plasticity E-RNN to read-out
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% voltage-based STDP E->E plasticity (Clopath et al., 2010)

% th_LTP = -49;               %LTP threshold constant 
% th_LTD = -68;               %LTD threshold constant

% A_LTP = 0.000005;             %LTP amplitude constant
% A_LTD = 0.0006;             %LTD amplitude constant

% tau_xE = 8;                  %time constant of presynaptic low pass filtered spike train 
% tau_uE = 10;                 %time constant of postsynaptic low pass filtered membrane voltage (LTD) 
% tau_vE = 7;                 %time constant of postsynaptic low pass filtered membrane voltage (LTP) 

% x_E = zeros(1,EneuronNum);                    %low pass filtered presynaptic spike train
% u_E = Vreset+(V_T-Vreset)*rand(1,REneuronNum); %low pass filtered postsynaptic membrane voltage (LTD)
% v_E = Vreset+(V_T-Vreset)*rand(1,REneuronNum);%low pass filtered postsynaptic membrane voltage (LTP)

%symmetric window with depression 
w_Emax = 1;                 %maximal read-out weight strength

A_Epot = 0.045/1.5;
A_Edep = 0.0000010/1.5;

tau_xE = 5;
tau_yE = 5;

x_E = zeros(1,EneuronNum);
y_E = zeros(1,REneuronNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Long-term plasticity I-RNN to syllable interneurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STDP type rule, inhibitory neurons firing together, do not wire together

w_Imax = 0.3;

A_Ipot = 0.030; %data6 is without /2 data7 is with /2, nothing changes with E-E plast
A_Idep = 0.0000020; %divided by three is too low, try two

tau_xI = 25;
tau_yI = 25;

x_I = zeros(1,IRNN_size);
y_I = zeros(1,SyllIneuronNum);