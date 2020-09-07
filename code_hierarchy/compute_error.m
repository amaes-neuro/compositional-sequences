function [err, err_window] = compute_error(rast,target,clusterSize)

% assume target dimensions=size(rast,1)/clusterSize x size(rast,2)

% 1) Convolve gaussian with rast, width ~10ms
% 2) take mean over each cluster
% 3) normalize between 0 and 1 
% 4) compute some error (how to deal with variability? -> dynamic time warping)

% 1)
gauss = exp(-((-250:250).^2)/(100^2));
conv_rast = zeros(size(rast,1),size(rast,2));
for i=1:size(rast,1)
    conv_rast(i,:) = conv(rast(i,:),gauss,'same');
end

% 2) 
conv_rast_mean = zeros(size(rast,1)/clusterSize,size(rast,2));
for i=1:size(rast,1)/clusterSize
    conv_rast_mean(i,:) = mean(conv_rast(1+(i-1)*clusterSize:i*clusterSize,:));
end

% remove bursts (threshold, trial and error)
conv_rast_mean(conv_rast_mean>0.3) = 0.3;

% 3)
conv_rast_mean = conv_rast_mean + 0.001*rand(size(rast,1)/clusterSize,size(rast,2));
conv_rast_mean = (conv_rast_mean-min(min(conv_rast_mean)))/(max(max(conv_rast_mean))-min(min(conv_rast_mean)));

% figure
% subplot(2,1,1)
% imagesc(conv_rast_mean)
% colorbar
% subplot(2,1,2)
% imagesc(target)
% colorbar

% 4) create a cost function (dynamic time warping, ~continuous lehvenstein
% distance)
err = dtw(conv_rast_mean,target)/(size(target,1)*size(target,2));
err_window = dtw(conv_rast_mean,target,200)/(size(target,1)*size(target,2));

end