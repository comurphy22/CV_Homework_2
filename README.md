# CV_Homework_2

Computer Vision Homework 2 - Circle Detection and Image Segmentation

## Overview

This homework implements two main computer vision algorithms:

- **Part A**: Hough Transform Circle Detection
- **Part B**: K-means Color Quantization

## Files

### Part A: Circle Detection

- `convert_variables.m` - Converts edge detection output (BW, Gx, Gy) to structured format
- `detectCircles.m` - Implements Hough Transform for circle detection
- `test_circle_detection.m` - Test script for jupiter.jpg and egg.jpg

### Part B: Image Segmentation

- `quantizeRGB.m` - Performs k-means clustering for color quantization
- `test_quantization.m` - Test script for fish.jpg with different k values

## How to Run

### Prerequisites

- MATLAB installed
- Image Processing Toolbox

### Part A: Circle Detection

1. Open MATLAB and navigate to the homework directory
2. Run the test script:

```matlab
test_circle_detection
```

This will:

- Detect circles in jupiter.jpg and egg.jpg
- Display the results with detected circles overlaid
- Save outputs as `jupiter_circles.png` and `egg_circles.png`

**Note**: You may need to adjust the radius values in `test_circle_detection.m` based on visual inspection of the images. Use `impixelinfo` to hover over the images and estimate appropriate radii.

### Part B: Image Quantization

1. Run the test script:

```matlab
test_quantization
```

This will:

- Apply k-means quantization with k=2, k=5, and k=10
- Display original and quantized images side by side
- Save outputs as `k2.png`, `k5.png`, and `k10.png`

## Manual Usage

### Circle Detection Example

```matlab
% Load and prepare image
im = imread('drive-download-20251018T174420Z-1-001/jupiter.jpg');
im_gray = rgb2gray(im);

% Edge detection
[BW, ~, Gx, Gy] = edge(im_gray, 'Sobel');

% Convert variables
edges = convert_variables(BW, Gx, Gy);

% Detect circles
radius = 45;  % Adjust based on your image
top_k = 1;    % Number of circles to detect
centers = detectCircles(im, edges, radius, top_k);
```

### Image Quantization Example

```matlab
% Load image
im = imread('drive-download-20251018T174420Z-1-001/fish.jpg');

% Quantize with k clusters
k = 5;
[outputImg, meanColors, clusterIds] = quantizeRGB(im, k);
```

## Expected Outputs

### Part A

- `jupiter_circles.png` - Jupiter image with detected circle(s)
- `egg_circles.png` - Egg image with detected circle(s)

### Part B

- `k2.png` - Fish image quantized to 2 colors
- `k5.png` - Fish image quantized to 5 colors
- `k10.png` - Fish image quantized to 10 colors

## Implementation Details

### Part A: Hough Transform Circle Detection

- Uses Sobel edge detection to find edges
- Computes gradient magnitude and orientation for each edge point
- Implements Hough Transform voting scheme for circles of fixed radius
- Uses quantization to reduce memory usage and computation time
- Returns top-k circle centers based on vote accumulation

### Part B: K-means Clustering

- Treats RGB values as 3D feature vectors
- Uses MATLAB's built-in `kmeans` function
- Replaces each pixel with its cluster center color
- Creates a posterized/segmented appearance

## Notes

- The radius values in the test scripts are estimates and may need adjustment
- K-means results may vary slightly between runs due to random initialization
- Larger k values preserve more color detail but increase computation time
