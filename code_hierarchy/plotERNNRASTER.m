%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting raster plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
rast2 = rast;

%Total number of spikes from all neurons in the simulation time
totalNumSpks = find (rast2 > 0);       
spksAll = zeros(length(totalNumSpks),2);
spikeCountTracker = 0;                 

for i = 1:neuronNum
    spikesNeuron = find (rast2(i,:) > 0);
    numSpikesNeuron = length(spikesNeuron);
    
    if (numSpikesNeuron > 0)
        %to convert to seconds
        spksAll(spikeCountTracker+1:spikeCountTracker+numSpikesNeuron,2) = spikesNeuron'*dt*(10^-3);    
        spksAll(spikeCountTracker+1:spikeCountTracker+numSpikesNeuron,1) = i*ones(numSpikesNeuron,1);
    end
    if (i <= EneuronNum)
        spksExcStruct(i) = struct('times',spikesNeuron'*dt*(10^-3));
    else
        spksInhStruct(i) = struct('times',spikesNeuron'*dt*(10^-3));
    end
    
    spikeCountTracker = spikeCountTracker + numSpikesNeuron;
end


firstInhNeuron = find(spksAll(:,1) >= EneuronNum+1);
if (length(firstInhNeuron) == 0)
    spksExc = spksAll;
    spksInh = [0 0];
else
    spksExc = spksAll(1:firstInhNeuron(1) - 1,:);
    spksInh = spksAll(firstInhNeuron(1):length(spksAll),:);
end


%% Raster Plot of Data
%figure;
set(gcf,'Color',[1 1 1])
plot(spksExc(:,2),spksExc(:,1),'r.');
hold on; plot(spksInh(:,2),spksInh(:,1),'b.'); axis([0 size(rast,2)/10000 1 neuronNum])   %convert to seconds
set(gca,'FontSize',25)
ylabel({'Recurrent network';'neuron index'})
set(gca,'FontSize',25)
xticks([0 0.2000 0.4000 0.6000 0.8000 1])
