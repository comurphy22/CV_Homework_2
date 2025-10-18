% Test script for RGB quantization on fish.jpg

% Load image
im_fish = imread('drive-download-20251018T174420Z-1-001/fish.jpg');

%% Test with k = 2
[outputImg2, meanColors2, clusterIds2] = quantizeRGB(im_fish, 2);
saveas(gcf, 'k2.png');
disp('Quantization with k=2 complete. Saved to k2.png');

%% Test with k = 5
[outputImg5, meanColors5, clusterIds5] = quantizeRGB(im_fish, 5);
saveas(gcf, 'k5.png');
disp('Quantization with k=5 complete. Saved to k5.png');

%% Test with k = 10
[outputImg10, meanColors10, clusterIds10] = quantizeRGB(im_fish, 10);
saveas(gcf, 'k10.png');
disp('Quantization with k=10 complete. Saved to k10.png');

disp('All quantization tests complete!');
