%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE WEIGHT MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IRNN_size  = 2000;   %Number of inhibitory neurons in the network
IRNN_clusterSize = 100;
IRNN_numClusters = IRNN_size/IRNN_clusterSize;
IRNN_weights = random('binom',1,0.2,[IRNN_size,IRNN_size]);
IRNN_factor = 30;
IRNN_weights = IRNN_weights.*IRNN_factor;
for i=1:IRNN_numClusters-1
    IRNN_weights(1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize,1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize) = ...
        IRNN_weights(1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize,1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize)./(IRNN_factor);
    IRNN_weights(1+i*IRNN_clusterSize:(i+1)*IRNN_clusterSize,1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize) = ...
        IRNN_weights(1+i*IRNN_clusterSize:(i+1)*IRNN_clusterSize,1+(i-1)*IRNN_clusterSize:i*IRNN_clusterSize)./2;
end
IRNN_weights(1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize,1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize) = ...
    IRNN_weights(1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize,1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize)./(IRNN_factor);
IRNN_weights(1:IRNN_clusterSize,1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize) = ...
    IRNN_weights(1:IRNN_clusterSize,1+(IRNN_numClusters-1)*IRNN_clusterSize:IRNN_numClusters*IRNN_clusterSize)./2;
IRNN_weights = IRNN_weights - diag(diag(IRNN_weights));
