% =========================================================================
% NUMERICAL METHODS — Assignment 1
% Problem 2: Handwritten Digit Dataset
% =========================================================================
% Dataset: HandwrittenDigits.mat (256x1707 matrix, labels in 'I')
% Digits: 0, 1, 3, 7  |  5 samples each  |  k = 5, 10, 15, 20, 25
% =========================================================================

clear; clc; close all;

%% Load Data
load('../data/HandwrittenDigits.mat');

y = I;              % Class labels
X_pixels = X;       % 256 x 1707 (pixels x samples)

[num_pixels, ~] = size(X_pixels);
fprintf('Pixel dimensions: %d  (should be 256 for 16x16 images)\n', num_pixels);

%% Parameters
target_digits        = [0, 1, 3, 7];
k_values             = [5, 10, 15, 20, 25];
num_samples_to_select = 5;

%% Main Loop — Per Digit
for d_idx = 1:length(target_digits)

    current_digit = target_digits(d_idx);
    digit_indices = find(y == current_digit);

    if length(digit_indices) < num_samples_to_select
        warning('Not enough samples for digit %d. Skipping.', current_digit);
        continue;
    end

    % Gather all images for this digit and center
    A       = X_pixels(:, digit_indices);
    A_bar   = mean(A, 2);
    A_center = A - A_bar;

    % Economy SVD on centered data
    [U, ~, ~] = svd(A_center, 'econ');

    % Use first num_samples_to_select centered columns for reconstruction
    S_reconstruct = A_center(:, 1:num_samples_to_select);

    % Storage for error norms
    norms_matrix = zeros(length(k_values), num_samples_to_select);

    % ---- Figure: Approximations ----------------------------------------
    fig_approx = figure('Name', sprintf('Digit %d - Approximations', current_digit));
    set(fig_approx, 'Position', [50 50 1300 800]);
    sgtitle(sprintf('Digit %d — Approximations', current_digit), 'FontSize', 13);

    % ---- Figure: Residuals ---------------------------------------------
    fig_resid = figure('Name', sprintf('Digit %d - Residuals', current_digit));
    set(fig_resid, 'Position', [50 50 1100 800]);
    sgtitle(sprintf('Digit %d — Residuals (Error)', current_digit), 'FontSize', 13);

    for j = 1:num_samples_to_select

        original_display = X_pixels(:, digit_indices(j));

        % Original image column
        figure(fig_approx);
        subplot(num_samples_to_select, length(k_values)+1, (j-1)*(length(k_values)+1) + 1);
        imagesc(reshape(original_display, 16, 16)');
        colormap(gray); axis off image;
        title(sprintf('Orig S%d', j), 'FontSize', 8);

        for k_idx = 1:length(k_values)
            k = k_values(k_idx);
            UK = U(:, 1:k);

            % Project and reconstruct
            ZK              = UK' * S_reconstruct;
            approx_centered = UK * ZK;
            residual        = S_reconstruct - approx_centered;

            % Store error norm
            norms_matrix(k_idx, j) = norm(residual(:, j));

            % Approximation plot
            figure(fig_approx);
            subplot(num_samples_to_select, length(k_values)+1, ...
                    (j-1)*(length(k_values)+1) + 1 + k_idx);
            imagesc(reshape(approx_centered(:,j) + A_bar, 16, 16)');
            colormap(gray); axis off image;
            title(sprintf('k=%d', k), 'FontSize', 8);

            % Residual plot
            figure(fig_resid);
            subplot(num_samples_to_select, length(k_values), ...
                    (j-1)*length(k_values) + k_idx);
            imagesc(reshape(residual(:,j), 16, 16)');
            colormap(gray); axis off image;
            title(sprintf('S%d k=%d', j, k), 'FontSize', 8);
        end
    end

    % ---- Error Norm Plot -----------------------------------------------
    figure('Name', sprintf('Digit %d - Error Norms', current_digit), ...
           'Position', [100 100 700 500]);
    plot(k_values, norms_matrix, '.-', 'LineWidth', 1.8, 'MarkerSize', 14);
    title(sprintf('Digit %d: Error Norm vs. Number of Components (k)', current_digit), ...
          'FontSize', 12);
    xlabel('Number of Components (k)', 'FontSize', 11);
    ylabel('Norm of the Residual (Error)', 'FontSize', 11);
    legend(arrayfun(@(x) sprintf('Sample %d', x), 1:num_samples_to_select, ...
           'UniformOutput', false), 'Location', 'northeast');
    xlim([min(k_values) max(k_values)]);
    grid on;
    set(gca, 'FontSize', 11);

end
