%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a single weight matrix of read-out E/I network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REneuronNum  = 300;                 %Number of excitatory neurons in the network
RnumClusters = 3;                  %Number of clusters
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Put two read-out networks together (hardcoded)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

weightsREE = [weightsREE,zeros(REneuronNum,REneuronNum);zeros(REneuronNum,REneuronNum),weightsREE];
weightsREI = [weightsREI,zeros(REneuronNum,RIneuronNum);zeros(REneuronNum,RIneuronNum),weightsREI];
weightsRIE = [weightsRIE,zeros(RIneuronNum,REneuronNum);zeros(RIneuronNum,REneuronNum),weightsRIE];
weightsRII = [weightsRII,zeros(RIneuronNum,RIneuronNum);zeros(RIneuronNum,RIneuronNum),weightsRII];
REneuronNum = 2*REneuronNum;
RIneuronNum = 2*RIneuronNum;
RneuronNum = 2*RneuronNum;
