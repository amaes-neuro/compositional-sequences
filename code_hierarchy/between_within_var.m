%measure between-motif and within-motif variability
dt = 0.1;
T = 1000;

createERNN;
createERNN_slow;
createSyllableRNN;
createReadOutRNN;
read_out_network;
test_setup;

target_dynamics_discr;

wRE = load('wRE_25ms.mat');
wRE = wRE.wRE;
wSyllE = load('wSyllE_25ms.mat');
wSyllE = wSyllE.wSyllE;


its = 50;

between_timings = zeros(2,its);
max_cross_corr = zeros(2,its);        
error_motifs = zeros(3,its);

% 1) run dynamics
% 2) convolve clock spikes
% 3) average over clock groups
% 4) get times
% 5) convolve read-out spikes
% 6) get max cross correlation 1-2 and 1-3
% 7) Compute error with target sequence

for m=1:its
    
    m
    
    times = zeros(3,2); %start and stop times
    
    dynamics_parameters;
    plasticity_parameters;
    external_input;

    % 1) 
    spontaneous_simulation;
    rast = rast(1:EneuronNum,:);
    
    % 2)
    gauss = exp(-((-250:250).^2)/(100^2));
    conv_rast = zeros(size(rast,1),size(rast,2));
    for i=1:size(rast,1)
        conv_rast(i,:) = conv(rast(i,:),gauss,'same');
    end
    
    % 3)
    conv_rast_mean = zeros(size(rast,1)/sizeClusters,size(rast,2));
    for i=1:size(rast,1)/sizeClusters
        conv_rast_mean(i,:) = mean(conv_rast(1+(i-1)*sizeClusters:i*sizeClusters,:));
    end

    % 4)
    times(1,1) = find(conv_rast_mean(1,1:1000)==max(conv_rast_mean(1,1:1000)));
    times(1,2) = find(conv_rast_mean(15,1:3000)==max(conv_rast_mean(15,1:3000)))+400;
    times(2,1) = find(conv_rast_mean(1,3000:5000)==max(conv_rast_mean(1,3000:5000)))+3000;
    times(2,2) = find(conv_rast_mean(15,4000:7000)==max(conv_rast_mean(15,4000:7000)))+4400;  
    times(3,1) = find(conv_rast_mean(1,6000:9000)==max(conv_rast_mean(1,6000:9000)))+6000;
    times(3,2) = find(conv_rast_mean(15,7000:10000)==max(conv_rast_mean(15,7000:10000)))+7400;     
    between_timings(1,m) = times(2,1)-times(1,2);
    between_timings(2,m) = times(3,1)-times(2,2);
    
    % 5)
    rast = rast_binary_R(1:300,:);
    conv_rast = zeros(size(rast,1),size(rast,2));
    for i=1:size(rast,1)
        conv_rast(i,:) = conv(rast(i,:),gauss,'same');
    end


    % 6)
    [~,lags_11] = xcorr(conv_rast(1,times(1,1):times(1,2)),conv_rast(1,times(1,1):times(1,2)));
    rows = zeros(100,size(lags_11,2));
    for g = 1:100
        [rows(g,:),~] = xcorr(conv_rast(g,times(1,1):times(1,2)),conv_rast(g,times(1,1):times(1,2)));
    end
    crosscorr_11 = max(sum(rows));
    
    [~,lags_12] = xcorr(conv_rast(1,times(1,1):times(1,2)),conv_rast(1,times(2,1):times(2,2)));
    rows = zeros(100,size(lags_12,2));
    for g = 1:100
        [rows(g,:),~] = xcorr(conv_rast(g,times(1,1):times(1,2)),conv_rast(g,times(2,1):times(2,2)));
    end
    crosscorr_12 = sum(rows);
    max_cross_corr(1,m) = max(crosscorr_12)/crosscorr_11;
    
    [~,lags_13] = xcorr(conv_rast(1,times(1,1):times(1,2)),conv_rast(1,times(3,1):times(3,2)));
    rows = zeros(100,size(lags_13,2));
    for g = 1:100
        [rows(g,:),~] = xcorr(conv_rast(g,times(1,1):times(1,2)),conv_rast(g,times(3,1):times(3,2)));
    end
    crosscorr_13 = sum(rows);
    max_cross_corr(2,m) = max(crosscorr_13)/crosscorr_11;
    
    % 7) 
    error_motifs(1,m) = sqrt(sum(sum((conv_rast(:,times(1,1):times(1,1)+1999)-target_motif).^2))/(300*200/dt));
    error_motifs(2,m) = sqrt(sum(sum((conv_rast(:,times(2,1):times(2,1)+1999)-target_motif).^2))/(300*200/dt));
    error_motifs(3,m) = sqrt(sum(sum((conv_rast(:,times(3,1):times(3,1)+1999)-target_motif).^2))/(300*200/dt));
   
end


figure
plotReadOutRASTER
hold on
line([times(1,1);times(1,1)]/10000,[0; 500])
hold on
line([times(1,2);times(1,2)]/10000,[0; 500])
hold on
line([times(2,1);times(2,1)]/10000,[0; 500])
hold on
line([times(3,2);times(3,2)]/10000,[0; 500])
hold on
line([times(3,1);times(3,1)]/10000,[0; 500])
hold on
line([times(2,2);times(2,2)]/10000,[0; 500])