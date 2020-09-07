% Plot: error between target dynamics and learned dynamics
% this script assumes a model has been trained and the weights saved 

target_dynamics;
% target_dynamics_discr;

wRE = load('wRE_serial.mat');
wRE_all = wRE.wRE;

%number of samples N for every five training steps, outer loop
N=50;
data_its = size(wRE_all,3);
error_total = zeros(N,data_its);
error_total_window = zeros(N,data_its);
error_syllable_1 = zeros(N,data_its);
error_syllable_2 = zeros(N,data_its);
error_syllable_3 = zeros(N,data_its);

for k=1:data_its
    k
    
    wRE = wRE(:,:,k);

    %generate model dynamics, inner loop 
    for n=1:N

        dt = 0.1;
        T = 1000;
        dynamics_parameters;
        plasticity_parameters;
        external_input;

        spontaneous_simulation; %assuming the model/parameters are initialized
        [error_total(n,k),error_total_window(n,k)] = compute_error(rast_binary_R(1:300,:),target_total,clusterSize);
        
        %for the discretization/variability experiment
%         [error_syllable_1(n,k),~] = compute_error(rast_binary_R(1:300,1:3000),target_total(:,1:3000),clusterSize);
%         [error_syllable_2(n,k),~] = compute_error(rast_binary_R(1:300,3001:6000),target_total(:,3001:6000),clusterSize);
%         [error_syllable_3(n,k),~] = compute_error(rast_binary_R(1:300,6501:9500),target_total(:,6501:9500),clusterSize);

   end

end

%plot
figure
plot(1:data_its,mean(error_total))
for h=1:N
    hold on
    plot(error_total(h,:),'*')
end



%save data
% save('error_discr40_total_add.mat','error_total');
% save('error_discr40_1_add.mat','error_syllable_1');
% save('error_discr40_2_add.mat','error_syllable_2');
% save('error_discr40_3_add.mat','error_syllable_3');
