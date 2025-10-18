function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
% quantizeRGB - Quantizes an RGB image using k-means clustering
%
% Inputs:
%   origImg - RGB image (uint8)
%   k - Number of colors/clusters to quantize to
%
% Outputs:
%   outputImg - Quantized RGB image (uint8), same size as original
%   meanColors - kx3 array of cluster centers (mean RGB values)
%   clusterIds - numpixelsx1 matrix indicating cluster assignment for each pixel

    % Get image dimensions
    [numrows, numcols, ~] = size(origImg);
    numpixels = numrows * numcols;
    
    % Reshape image to [numpixels, 3] format
    % Each row is a pixel with RGB values
    X = reshape(origImg, [numpixels, 3]);
    
    % Convert to double for k-means (kmeans expects double)
    X = double(X);
    
    % Perform k-means clustering
    % clusterIds: cluster assignment for each pixel
    % meanColors: k cluster centers (mean RGB values)
    [clusterIds, meanColors] = kmeans(X, k, 'MaxIter', 100, 'Distance', 'sqeuclidean');
    
    % Create output image by mapping each pixel to its cluster center
    outputData = zeros(numpixels, 3);
    for i = 1:k
        % Find all pixels in cluster i
        pixelsInCluster = (clusterIds == i);
        % Assign them the mean color
        outputData(pixelsInCluster, :) = repmat(meanColors(i, :), sum(pixelsInCluster), 1);
    end
    
    % Convert back to uint8 and reshape to original image dimensions
    outputData = uint8(outputData);
    outputImg = reshape(outputData, [numrows, numcols, 3]);
    
    % Display results in 1x2 subplot
    figure;
    
    subplot(1, 2, 1);
    imshow(origImg);
    title('Original Image');
    
    subplot(1, 2, 2);
    imshow(outputImg);
    title(sprintf('Quantized Image (RGB) for k=%d', k));
    
    % Add overall figure title
    sgtitle(sprintf('Image Quantization with k=%d clusters', k));
    
end
