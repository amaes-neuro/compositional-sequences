% Computes: error between target dynamics and learned dynamics
% this script assumes the model is trained and loads the weights in 

createERNN;
createERNN_slow;
createSyllableRNN;
createReadOutRNN;
read_out_network;
test_setup;

target_dynamics;
% target_dynamics_discr;

wRE = load('wRE.mat');
wRE_all = wRE.wRE;
wSyllE = load('wSyllE.mat');
wSyllE_all = wSyllE.wSyllE;

%number of samples N for every five training steps, outer loop
N=50;
data_its = size(wRE,3);
error_motifs = zeros(N,data_its);
error_motif_1 = zeros(N,data_its);
error_motif_2 = zeros(N,data_its);
error_total = zeros(N,data_its);
error_ordering = zeros(N,data_its);
error_total_window = zeros(N,data_its);
error_ordering_window = zeros(N,data_its);
error_syllable_1 = zeros(N,data_its);
error_syllable_2 = zeros(N,data_its);
error_syllable_3 = zeros(N,data_its);
for k=1:data_its
    k
    
    wRE = wRE_all(:,:,k);
    wSyllE = wSyllE_all(:,:,k);

    %generate model dynamics, inner loop 
    for n=1:N

        dt = 0.1;
        T = 1000;
        dynamics_parameters;
        plasticity_parameters;
        external_input;

        spontaneous_simulation; 
        [error_ordering(n,k),error_ordering_window(n,k)] = compute_error(rast_binary_syll, target_order, clusterSize);
        [error_total(n,k),error_total_window(n,k)] = compute_error(rast_binary_R(1:600,:),target_total,clusterSize);

         %for the discretization/variability experiment
%         [error_syllable_1(n,k),~] = compute_error(rast_binary_R(1:300,1:3000),target_total(:,1:3000),clusterSize);
%         [error_syllable_2(n,k),~] = compute_error(rast_binary_R(1:300,3001:6000),target_total(:,3001:6000),clusterSize);
%         [error_syllable_3(n,k),~] = compute_error(rast_binary_R(1:300,6501:9500),target_total(:,6501:9500),clusterSize);

        T = 230;
        dynamics_parameters;
        external_input;
        
        motif_only_dynamics;
        [error_motifs(n,k),error_motif_1(n,k),error_motif_2(n,k)] = compute_error_motifs(rast_binary_R(1:600,:),target_motif_1,target_motif_2,clusterSize);
        
    end

end

%plot
figure
plot(1:data_its,mean(error_total))
for h=1:N
    hold on
    plot(error_total(h,:),'b*')
end

figure
plot(1:data_its,mean(error_ordering))
for h=1:N
    hold on    
    plot(error_ordering(h,:),'b*')
end


figure
plot(1:data_its,mean(error_motifs))
for h=1:N
    hold on    
    plot(error_motifs(h,:),'b*')
end


% figure
% plot(1:data_its,mean(error_syllable_1),'b')
% for h=1:N
%     hold on
%     plot(error_syllable_1(h,:),'b*')
% end
% 
% hold on
% plot(1:data_its,mean(error_syllable_2),'r')
% for h=1:N
%     hold on
%     plot(error_syllable_2(h,:),'r*')
% end
% 
% hold on
% plot(1:data_its,mean(error_syllable_3),'g')
% for h=1:N
%     hold on
%     plot(error_syllable_3(h,:),'g*')
% end

%save data
% save('error_discr_hier40_total.mat','error_total');
% save('error_discr_hier40_1.mat','error_syllable_1');
% save('error_discr_hier40_2.mat','error_syllable_2');
% save('error_discr_hier40_3.mat','error_syllable_3');
