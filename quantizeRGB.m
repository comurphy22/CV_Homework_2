function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
% Quantizes an RGB image using k-means clustering
% Inputs: origImg (RGB uint8), k (number of clusters)
% Outputs: outputImg (quantized image), meanColors (kx3), clusterIds (numpixelsx1)

    [numrows, numcols, ~] = size(origImg);
    numpixels = numrows * numcols;
    
    X = reshape(origImg, [numpixels, 3]);
    X = double(X);
    
    [clusterIds, meanColors] = kmeans(X, k, 'MaxIter', 100, 'Distance', 'sqeuclidean');
    
    outputData = zeros(numpixels, 3);
    for i = 1:k
        pixelsInCluster = (clusterIds == i);
        outputData(pixelsInCluster, :) = repmat(meanColors(i, :), sum(pixelsInCluster), 1);
    end
    
    outputData = uint8(outputData);
    outputImg = reshape(outputData, [numrows, numcols, 3]);
    
    figure;
    subplot(1, 2, 1);
    imshow(origImg);
    title('Original Image');
    
    subplot(1, 2, 2);
    imshow(outputImg);
    title(sprintf('Quantized Image (RGB) for k=%d', k));
    
    sgtitle(sprintf('Image Quantization with k=%d clusters', k));
    
end
