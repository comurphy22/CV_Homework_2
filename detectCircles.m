function [centers] = detectCircles(im, edges, radius, top_k)
% detectCircles - Detects circles of a given radius using Hough Transform
%
% Inputs:
%   im - RGB image (uint8)
%   edges - Nx4 matrix from convert_variables with [x, y, magnitude, orientation]
%   radius - The radius of circles to detect
%   top_k - Number of top-scoring circle centers to return
%
% Output:
%   centers - Nx2 matrix of detected circle centers [x, y]

    % Get image dimensions
    [height, width, ~] = size(im);
    
    % Quantization value for Hough space (as suggested in tips)
    quantization_value = 5;
    
    % Create Hough accumulator array
    % Quantize the space to reduce memory and computation
    max_a = ceil(width / quantization_value);
    max_b = ceil(height / quantization_value);
    H = zeros(max_b, max_a);
    
    % For each edge point
    for i = 1:size(edges, 1)
        x = edges(i, 1);
        y = edges(i, 2);
        theta = edges(i, 4);  % gradient orientation in degrees
        
        % Convert theta to radians for cos/sin
        theta_rad = deg2rad(theta);
        
        % Calculate possible circle centers along the gradient direction
        % The center is at distance 'radius' from the edge point
        % Two possible directions: along gradient and opposite to gradient
        
        % Direction 1: along the gradient (perpendicular to edge)
        a1 = x + radius * cos(theta_rad);
        b1 = y + radius * sin(theta_rad);
        
        % Direction 2: opposite to gradient
        a2 = x - radius * cos(theta_rad);
        b2 = y - radius * sin(theta_rad);
        
        % Quantize and accumulate votes for both directions
        for a = [a1, a2]
            for b = [b1, b2]
                % Check if center is within image bounds
                if a >= 1 && a <= width && b >= 1 && b <= height
                    % Quantize the coordinates
                    a_idx = ceil(a / quantization_value);
                    b_idx = ceil(b / quantization_value);
                    
                    % Ensure indices are within bounds
                    if a_idx >= 1 && a_idx <= max_a && b_idx >= 1 && b_idx <= max_b
                        H(b_idx, a_idx) = H(b_idx, a_idx) + 1;
                    end
                end
            end
        end
    end
    
    % Find top_k peaks in the Hough space
    centers = zeros(top_k, 2);
    
    for k = 1:top_k
        % Find maximum value in H
        [max_val, idx] = max(H(:));
        
        % If no more peaks, break
        if max_val == 0
            centers = centers(1:k-1, :);
            break;
        end
        
        % Convert linear index to subscripts
        [b_idx, a_idx] = ind2sub(size(H), idx);
        
        % Convert back to original coordinates
        a = a_idx * quantization_value;
        b = b_idx * quantization_value;
        
        % Store center
        centers(k, :) = [a, b];
        
        % Suppress nearby peaks to avoid duplicate detections
        suppress_radius = ceil(radius / (2 * quantization_value));
        b_start = max(1, b_idx - suppress_radius);
        b_end = min(max_b, b_idx + suppress_radius);
        a_start = max(1, a_idx - suppress_radius);
        a_end = min(max_a, a_idx + suppress_radius);
        
        H(b_start:b_end, a_start:a_end) = 0;
    end
    
    % Visualize the results
    figure;
    imshow(im);
    hold on;
    viscircles(centers, radius * ones(size(centers, 1), 1), 'EdgeColor', 'r', 'LineWidth', 2);
    title(sprintf('Detected Circles (radius = %d, top %d)', radius, size(centers, 1)));
    hold off;
    
end
