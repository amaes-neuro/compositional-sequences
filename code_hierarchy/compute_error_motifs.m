function [err_tot,err_1,err_2] = compute_error_motifs(rast_motif, target_1, target_2, clusterSize)

% Compute errors within individual motifs
% 1) Convolve rast_motif with gaussian, widt ~10 ms
% 2) Take mean over each cluster
% 3) Normalize
% 4) Compute error with targets


% 1)
gauss = exp(-((-250:250).^2)/(100^2));
conv_rast_motif = zeros(size(rast_motif,1),size(rast_motif,2));
for i=1:size(rast_motif,1)
    conv_rast_motif(i,:) = conv(rast_motif(i,:),gauss,'same');
end

% 2) 
conv_rast_motif_mean = zeros(size(rast_motif,1)/clusterSize,size(rast_motif,2));
for i=1:size(rast_motif,1)/clusterSize
    conv_rast_motif_mean(i,:) = mean(conv_rast_motif(1+(i-1)*clusterSize:i*clusterSize,:));
end

% remove bursts (threshold, trial and error)
conv_rast_motif_mean(conv_rast_motif_mean>0.3) = 0.3;

% 3)
conv_rast_motif_mean = conv_rast_motif_mean + 0.001*rand(size(rast_motif,1)/clusterSize,size(rast_motif,2));
conv_rast_motif_mean = (conv_rast_motif_mean-min(min(conv_rast_motif_mean)))/(max(max(conv_rast_motif_mean))-min(min(conv_rast_motif_mean)));


% 4) 
err_1 = dtw(conv_rast_motif_mean(1:3,:),target_1,50)/(size(target_1,1)*size(target_1,2));
err_2 = dtw(conv_rast_motif_mean(4:6,:),target_2,50)/(size(target_2,1)*size(target_2,2));
err_tot = 2*err_1 + err_2;

% figure
% subplot(2,1,1)
% imagesc(conv_rast_motif_mean)
% colorbar
% subplot(2,1,2)
% imagesc([target_1;target_2])
% colorbar

end