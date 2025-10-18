% Test script for circle detection on jupiter.jpg and egg.jpg

%% Test on jupiter.jpg
% Load image
im_jupiter = imread('drive-download-20251018T174420Z-1-001/jupiter.jpg');

% Convert to grayscale for edge detection
im_gray = rgb2gray(im_jupiter);

% Edge detection using Sobel
[BW, threshOut, Gx, Gy] = edge(im_gray, 'Sobel');

% Convert edge variables
edges = convert_variables(BW, Gx, Gy);

% Detect circles - adjust radius based on the image
% Use impixelinfo to estimate radius (estimated around 40-50 pixels)
radius_jupiter = 45;
top_k = 1;  % Expecting one main circle (Jupiter)

centers_jupiter = detectCircles(im_jupiter, edges, radius_jupiter, top_k);

% Save the figure
saveas(gcf, 'jupiter_circles.png');
disp('Jupiter circle detection complete. Saved to jupiter_circles.png');

%% Test on egg.jpg
% Load image
im_egg = imread('drive-download-20251018T174420Z-1-001/egg.jpg');

% Convert to grayscale for edge detection
im_gray = rgb2gray(im_egg);

% Edge detection using Sobel
[BW, threshOut, Gx, Gy] = edge(im_gray, 'Sobel');

% Convert edge variables
edges = convert_variables(BW, Gx, Gy);

% Detect circles - adjust radius based on the image
% Estimate radius for egg (might need adjustment)
radius_egg = 50;
top_k = 3;  % Multiple eggs might be present

centers_egg = detectCircles(im_egg, edges, radius_egg, top_k);

% Save the figure
saveas(gcf, 'egg_circles.png');
disp('Egg circle detection complete. Saved to egg_circles.png');
