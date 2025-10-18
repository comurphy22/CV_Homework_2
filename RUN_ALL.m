% RUN_ALL.m - Master script to run all homework components
% This script executes both Part A (Circle Detection) and Part B (Image Quantization)

fprintf('========================================\n');
fprintf('CV HOMEWORK 2 - COMPLETE TEST SUITE\n');
fprintf('========================================\n\n');

%% PART A: Circle Detection
fprintf('PART A: Circle Detection\n');
fprintf('------------------------\n');
try
    test_circle_detection;
    fprintf('✓ Part A completed successfully!\n\n');
catch ME
    fprintf('✗ Part A failed with error: %s\n\n', ME.message);
end

%% PART B: Image Quantization
fprintf('PART B: Image Quantization\n');
fprintf('--------------------------\n');
try
    test_quantization;
    fprintf('✓ Part B completed successfully!\n\n');
catch ME
    fprintf('✗ Part B failed with error: %s\n\n', ME.message);
end

%% Summary
fprintf('========================================\n');
fprintf('EXECUTION COMPLETE\n');
fprintf('========================================\n\n');

fprintf('Generated files:\n');
fprintf('  Part A:\n');
fprintf('    - jupiter_circles.png\n');
fprintf('    - egg_circles.png\n');
fprintf('  Part B:\n');
fprintf('    - k2.png\n');
fprintf('    - k5.png\n');
fprintf('    - k10.png\n\n');

fprintf('Submission files ready:\n');
fprintf('  Part A:\n');
fprintf('    - convert_variables.m\n');
fprintf('    - detectCircles.m\n');
fprintf('    - jupiter_circles.png\n');
fprintf('    - egg_circles.png\n');
fprintf('  Part B:\n');
fprintf('    - quantizeRGB.m\n');
fprintf('    - k2.png\n');
fprintf('    - k5.png\n');
fprintf('    - k10.png\n\n');

fprintf('All homework components have been executed!\n');
