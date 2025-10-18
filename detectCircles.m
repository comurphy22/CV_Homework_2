function [centers] = detectCircles(im, edges, radius, top_k)
% Detects circles using Hough Transform
% Inputs: im (RGB image), edges (Nx4 matrix), radius, top_k (number to return)
% Output: centers - Nx2 matrix of detected circle centers [x, y]

    [height, width, ~] = size(im);
    quantization_value = 5;
    
    max_a = ceil(width / quantization_value);
    max_b = ceil(height / quantization_value);
    H = zeros(max_b, max_a);
    
    for i = 1:size(edges, 1)
        x = edges(i, 1);
        y = edges(i, 2);
        theta = edges(i, 4);
        theta_rad = deg2rad(theta);
        
        a1 = x + radius * cos(theta_rad);
        b1 = y + radius * sin(theta_rad);
        a2 = x - radius * cos(theta_rad);
        b2 = y - radius * sin(theta_rad);
        
        for a = [a1, a2]
            for b = [b1, b2]
                if a >= 1 && a <= width && b >= 1 && b <= height
                    a_idx = ceil(a / quantization_value);
                    b_idx = ceil(b / quantization_value);
                    
                    if a_idx >= 1 && a_idx <= max_a && b_idx >= 1 && b_idx <= max_b
                        H(b_idx, a_idx) = H(b_idx, a_idx) + 1;
                    end
                end
            end
        end
    end
    
    centers = zeros(top_k, 2);
    
    for k = 1:top_k
        [max_val, idx] = max(H(:));
        
        if max_val == 0
            centers = centers(1:k-1, :);
            break;
        end
        
        [b_idx, a_idx] = ind2sub(size(H), idx);
        a = a_idx * quantization_value;
        b = b_idx * quantization_value;
        centers(k, :) = [a, b];
        
        suppress_radius = ceil(radius / (2 * quantization_value));
        b_start = max(1, b_idx - suppress_radius);
        b_end = min(max_b, b_idx + suppress_radius);
        a_start = max(1, a_idx - suppress_radius);
        a_end = min(max_a, a_idx + suppress_radius);
        
        H(b_start:b_end, a_start:a_end) = 0;
    end
    
    figure;
    imshow(im);
    hold on;
    viscircles(centers, radius * ones(size(centers, 1), 1), 'EdgeColor', 'r', 'LineWidth', 2);
    title(sprintf('Detected Circles (radius = %d, top %d)', radius, size(centers, 1)));
    hold off;
    
end
