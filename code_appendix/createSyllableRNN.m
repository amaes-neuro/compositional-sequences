%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a single weight matrix of interneurons (I network)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SyllIneuronNum = 300;
clusterSize = 100;
numClusters = SyllIneuronNum/clusterSize;
weightsSyllRNN = random('binom',1,0.2,[SyllIneuronNum,SyllIneuronNum]);
w_ii = 20;
weightsSyllRNN = weightsSyllRNN.*w_ii;
for i=1:numClusters
    weightsSyllRNN(1+(i-1)*clusterSize:i*clusterSize,1+(i-1)*clusterSize:i*clusterSize) = ...
        weightsSyllRNN(1+(i-1)*clusterSize:i*clusterSize,1+(i-1)*clusterSize:i*clusterSize)./20;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Put two interneuron networks together (hardcoded)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% weightsSyllRNN = [weightsSyllRNN,zeros(SyllIneuronNum,SyllIneuronNum);
%                   zeros(SyllIneuronNum,SyllIneuronNum),weightsSyllRNN];
% SyllIneuronNum = 2*SyllIneuronNum;
