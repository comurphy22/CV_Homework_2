function [edges] = convert_variables(BW, Gx, Gy)
% Converts edge detection output to a structured format
% Inputs: BW (binary edge map), Gx (horizontal gradient), Gy (vertical gradient)
% Output: edges - Nx4 matrix [x, y, gradient_magnitude, gradient_orientation]

    [rows, cols] = find(BW);
    N = length(rows);
    edges = zeros(N, 4);
    
    for i = 1:N
        row = rows(i);
        col = cols(i);
        edges(i, 1) = col;
        edges(i, 2) = row;
        edges(i, 3) = sqrt(Gx(row, col)^2 + Gy(row, col)^2);
        edges(i, 4) = atan2d(Gy(row, col), Gx(row, col));
    end
    
end
