function [edges] = convert_variables(BW, Gx, Gy)
% convert_variables - Converts edge detection output to a structured format
%
% Inputs:
%   BW - Binary edge map (from edge function)
%   Gx - Horizontal gradient
%   Gy - Vertical gradient
%
% Output:
%   edges - Nx4 matrix where each row contains:
%           [x_location, y_location, gradient_magnitude, gradient_orientation]
%           x and y are in image coordinates
%           gradient_orientation is in degrees (non-quantized)

    % Find the locations where BW has edges (value = 1)
    [rows, cols] = find(BW);
    
    % Number of edge points
    N = length(rows);
    
    % Initialize output matrix
    edges = zeros(N, 4);
    
    % For each edge point
    for i = 1:N
        row = rows(i);
        col = cols(i);
        
        % Column 1: x location (column in image coordinates)
        edges(i, 1) = col;
        
        % Column 2: y location (row in image coordinates)
        edges(i, 2) = row;
        
        % Column 3: gradient magnitude
        edges(i, 3) = sqrt(Gx(row, col)^2 + Gy(row, col)^2);
        
        % Column 4: gradient orientation in degrees (non-quantized)
        % atan2 gives angle in radians, convert to degrees
        edges(i, 4) = atan2d(Gy(row, col), Gx(row, col));
    end
    
end
