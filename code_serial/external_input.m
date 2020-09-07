%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% External input to E-RNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rex = 4.50;        %external rate to E-neurons        
rix = 2.250;        %external rate to I-neurons
Jeex = 1.6;         %weights for ee external input
Jiex = 1.52;        %weights for ie external input

nextx = zeros(1,neuronNum);      %vector containing the next external input spike times
nextx(1,1:EneuronNum) =  exprnd(1,1,EneuronNum)/rex;         
nextx(1,1+EneuronNum:end) = exprnd(1,1,IneuronNum)/rix;
rx = zeros(1,neuronNum);
rx(1,1:EneuronNum) = rex;
rx(1,EneuronNum+1:end) = rix;
forwardInputsEPrev = zeros(1,neuronNum);
forwardInputsIPrev = zeros(1,neuronNum);
Jex = zeros(1,neuronNum);
Jex(1,1:EneuronNum) = Jeex;
Jex(1,EneuronNum+1:neuronNum) = Jiex;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% External input to read-out neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rRex = 3;
rRix = 2.25;

nextRx = zeros(1,RneuronNum);      %vector containing the next external input spike times
nextRx(1,1:REneuronNum) =  exprnd(1,1,REneuronNum)/rRex;         
nextRx(1,1+REneuronNum:end) = exprnd(1,1,RIneuronNum)/rRix;
rRx = zeros(1,RneuronNum);
rRx(1,1:REneuronNum) = rRex;
rRx(1,REneuronNum+1:end) = rRix;
forwardInputsREPrev = zeros(1,RneuronNum);
forwardInputsRIPrev = zeros(1,RneuronNum);
Jex_R = zeros(1,RneuronNum);
Jex_R(1,1:REneuronNum) = Jeex;
Jex_R(1,REneuronNum+1:RneuronNum) = Jiex;