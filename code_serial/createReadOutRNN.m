%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a single weight matrix of read-out E/I network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REneuronNum  = 600;                 %Number of excitatory neurons in the network
RIneuronNum  = round(0.25*REneuronNum);   %Number of inhibitory neurons in the network
RneuronNum   = REneuronNum + RIneuronNum;  %Total number of neurons

weightsREI = random('binom',1,0.2,[REneuronNum,RIneuronNum]);      %Weight matrix of inhibioty to excitatory LIF cells
weightsREI = 190.* weightsREI;

weightsRIE = random('binom',1,0.2,[RIneuronNum, REneuronNum]);     %Weight matrix of excitatory to inhibitory cells
weightsRIE = 6.* weightsRIE;

weightsRII = random('binom',1,0.2,[RIneuronNum, RIneuronNum]);     %Weight matrix of inhibitory to inhibitory cells
weightsRII = 60.* weightsRII;

weightsREE = random('binom',1,0.2,[REneuronNum, REneuronNum]);     %Weight matrix of excitatory to excitatory cells
weightsREE = 3.* weightsREE;
