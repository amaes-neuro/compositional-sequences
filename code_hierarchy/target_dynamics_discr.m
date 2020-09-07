clusterSize = 100;

target_motif = zeros(REneuronNum/2,200/dt);

target_motif(1:100,1/dt:25/dt) = 1;
target_motif(201:300,25/dt:50/dt) = 1;
target_motif(101:200,50/dt:75/dt) = 1;
target_motif(201:300,75/dt:100/dt) = 1;
target_motif(101:200,100/dt:125/dt) = 1;
target_motif(201:300,125/dt:150/dt) = 1;
target_motif(1:100,150/dt:175/dt) = 1;
target_motif(101:200,175/dt:200/dt) = 1;