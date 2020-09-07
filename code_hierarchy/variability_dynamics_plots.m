% Plot: variability of executed behaviour
%         two lines: fast-clock variability, slow-clock variability

% 1) run dynamics
% 2) convolve spikes
% 3) average over groups
% 4) get times
 

N = 50; %samples
times_fast = zeros(N, 20); 
times_slow = zeros(N, 28);

for m=1:N
    
    m
    
    %%% Fast %%%
    
    % 1) 
    fast_dynamics;
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
    for i=2:size(rast,1)/sizeClusters
        times_fast(m,i) = find(conv_rast_mean(i,:)==max(conv_rast_mean(i,:)))*dt;
    end
    times_fast(m,1) = find(conv_rast_mean(1,1:1000)==max(conv_rast_mean(1,1:1000)))*dt;
    
    %%% Slow exc %%%

    % 1) 
    slow_dynamics;
    rast = rast_slow(1:EneuronNum_slow,:);
    
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
    for i=6:size(rast,1)/sizeClusters
        times_slow(m,i) = find(conv_rast_mean(i,:)==max(conv_rast_mean(i,:)))*dt;
    end
    for i=1:5
        times_slow(m,i) = find(conv_rast_mean(i,1:5000)==max(conv_rast_mean(i,1:5000)))*dt;
    end
        
end


%plot data
figure
plot(1:20,mean(times_fast))
for h=1:N
    hold on    
    plot(times_fast(h,:),'b*')
end
figure
plot(1:20,std(times_fast))

figure
plot(1:28,mean(times_slow),'b')
for h=1:N
    hold on    
    plot(times_slow(h,:),'b*')
end
figure
plot(1:28,std(times_slow),'b')

%save data
save('times_fast.mat','times_fast');
save('times_slow.mat','times_slow');