clusterSize = 100;
% define target dynamics
target_motif_1 = zeros(REneuronNum/2/clusterSize,200/dt);
target_motif_1(1,1:40/dt) = 1;
target_motif_1(2,40/dt:80/dt) = 1;
target_motif_1(3,80/dt:120/dt) = 1;
target_motif_1(2,120/dt:160/dt) = 1;
target_motif_1(1,160/dt:200/dt) = 1;

target_motif_2 = zeros(REneuronNum/2/clusterSize,200/dt);
target_motif_2(1,1:50/dt) = 1;
target_motif_2(2,50/dt:120/dt) = 1;
target_motif_2(3,120/dt:200/dt) = 1;

%AAB
%target_total = [target_motif_1,zeros(REneuronNum/2/clusterSize,150/dt),target_motif_1,zeros(REneuronNum/2/clusterSize,450/dt);
%                zeros(REneuronNum/2/clusterSize,700/dt),target_motif_2,zeros(REneuronNum/2/clusterSize,100/dt)];

%ABA
target_total = [target_motif_1,zeros(REneuronNum/2/clusterSize,500/dt),target_motif_1,zeros(REneuronNum/2/clusterSize,100/dt);
                zeros(REneuronNum/2/clusterSize,350/dt),target_motif_2,zeros(REneuronNum/2/clusterSize,450/dt)];


