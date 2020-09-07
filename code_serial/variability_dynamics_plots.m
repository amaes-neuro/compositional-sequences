% Plot: variability of executed behaviour
%         
% 1) run dynamics
% 2) convolve spikes
% 3) average over groups
% 4) get times
 

N = 50; %samples
times = zeros(N, 48); 

for m=1:N
    
    m
    
    %%% Fast %%%
    
    % 1) 
    clock_dynamics;
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
    for i=4:size(rast,1)/sizeClusters
        times(m,i) = find(conv_rast_mean(i,:)==max(conv_rast_mean(i,:)))*dt;
    end
    times(m,1) = find(conv_rast_mean(1,1:1000)==max(conv_rast_mean(1,1:1000)))*dt;
    times(m,2) = find(conv_rast_mean(2,1:1000)==max(conv_rast_mean(2,1:1000)))*dt;
    times(m,3) = find(conv_rast_mean(3,1:1000)==max(conv_rast_mean(3,1:1000)))*dt;  
end

figure
plot(1:48,mean(times))
for h=1:N
    hold on    
    plot(times(h,:),'b*')
end
figure
plot(1:48,std(times))
