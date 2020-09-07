%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE WEIGHT MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mult = 3.5;
EneuronNum_slow = 800*mult;
IneuronNum_slow = EneuronNum_slow/4;
neuronNum_slow = EneuronNum_slow + IneuronNum_slow;
sizeClusters = 100;
numClusters_slow = EneuronNum_slow/sizeClusters;

WRatio  = 25;           %Ratio of Win/Wout (synaptic weight of within group to neurons outside of the group)
REE = 1.0;              %Ratio of pin/pout (probability of connection withing group to outside the group)
FF_ratio = 4.7;         %Ratio of W_up/W_down (above and under diagonal connections)

f = 1/sqrt(mult);          %Factor to scale by synaptic weight parameters by network size

wEI     = f*110;          %Average weight of inhibitroy to excitatory cells
wIE     = f*3.5;        %Average weight of excitatory to inhibitory cells
wEE     = f*5;          %Average weight of excitatory to excitatory cells
wII     = f*36;         %Average weight of inhibitory to inhibitory cells


wEEsub = wEE/(1/numClusters_slow+(1-1/numClusters_slow)/WRatio);          %Average weight for sub-clusters
wEE    = wEEsub/WRatio;

p1  = 0.2/(1/numClusters_slow+(1-1/numClusters_slow)/REE);                %Average probability for sub-clusters
pEE = p1/REE;

weightsEI_slow = random('binom',1,0.2,[EneuronNum_slow,IneuronNum_slow]);      %Weight matrix of inhibioty to excitatory LIF cells
weightsEI_slow = wEI.* weightsEI_slow;

weightsIE_slow = random('binom',1,0.2,[IneuronNum_slow, EneuronNum_slow]);     %Weight matrix of excitatory to inhibitory cells
weightsIE_slow = wIE.* weightsIE_slow;

weightsII_slow = random('binom',1,0.2,[IneuronNum_slow, IneuronNum_slow]);     %Weight matrix of inhibitory to inhibitory cells
weightsII_slow = wII.* weightsII_slow;

weightsEE_slow = random('binom',1,pEE,[EneuronNum_slow, EneuronNum_slow]);     %Weight matrix of excitatory to excitatory cells
weightsEE_slow = wEE.* weightsEE_slow;


%Create the group weight matrices and update the total weight matrix
for i = 1:numClusters_slow
    weightsEEsub = random('binom',1,p1,[EneuronNum_slow/numClusters_slow, EneuronNum_slow/numClusters_slow]);
    weightsEEsub = wEEsub.* weightsEEsub;
    weightsEE_slow((i-1)*EneuronNum_slow/numClusters_slow+1:i*EneuronNum_slow/numClusters_slow,(i-1)*EneuronNum_slow/numClusters_slow+1:i*EneuronNum_slow/numClusters_slow) = weightsEEsub;
end

%Create off-diagonal connections in weightsEE
for i = 1:numClusters_slow-1
    weightsEE_slow((i-1)*EneuronNum_slow/numClusters_slow+1:i*EneuronNum_slow/numClusters_slow,i*EneuronNum_slow/numClusters_slow+1:(i+1)*EneuronNum_slow/numClusters_slow) = ...
        weightsEE_slow((i-1)*EneuronNum_slow/numClusters_slow+1:i*EneuronNum_slow/numClusters_slow,i*EneuronNum_slow/numClusters_slow+1:(i+1)*EneuronNum_slow/numClusters_slow)*FF_ratio; 
end
weightsEE_slow((numClusters_slow-1)*EneuronNum_slow/numClusters_slow+1:EneuronNum_slow,1:EneuronNum_slow/numClusters_slow) = ...
    weightsEE_slow((numClusters_slow-1)*EneuronNum_slow/numClusters_slow+1:EneuronNum_slow,1:EneuronNum_slow/numClusters_slow)*FF_ratio;

weightsEE_slow = weightsEE_slow';
    
%Ensure the diagonals are zero
weightsII_slow = weightsII_slow - diag(diag(weightsII_slow));
weightsEE_slow = weightsEE_slow - diag(diag(weightsEE_slow));