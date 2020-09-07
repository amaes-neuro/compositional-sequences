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
