% =========================================================================
% NUMERICAL METHODS — Assignment 1
% Problem 1: Model Data Reduction
% =========================================================================
% Dataset: ModelReductionData.mat (6x4000 matrix)
% =========================================================================

clear; clc; close all;

%% Load Data
load('../data/ModelReductionData.mat');

[num_features, num_samples] = size(X);
fprintf('Data dimensions: %d features x %d samples\n', num_features, num_samples);

%% 1.1 — Scatter Plots: All 15 Two-Dimensional Projections

w = 0;
figure('Name', 'All 15 Pairwise Projections', 'Position', [100 100 1200 900]);

for i = 1:5
    for j = i+1:6
        w = w + 1;
        subplot(5, 3, w);
        plot(X(i, :), X(j, :), 'k.', 'MarkerSize', 1);
        axis equal;
        xlabel(['Component ', num2str(i)]);
        ylabel(['Component ', num2str(j)]);
        title(['Projection: ', num2str(i), ' vs ', num2str(j)]);
        set(gca, 'FontSize', 9);
    end
end

sgtitle('All 15 Two-Dimensional Projections of 6D Dataset', 'FontSize', 13);

%% 1.2 — Center Data and Compute SVD

% Center: subtract row-wise mean
mu = mean(X, 2);
X_centered = X - mu;

% SVD on transposed centered data (samples x features)
[U, S, V] = svd(X_centered', 'econ');
singular_values = diag(S);

%% 1.2 — Plot Singular Values

figure('Name', 'Singular Values of Centered Data', 'Position', [100 100 600 400]);
plot(singular_values, 'o-', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.1 0.4 0.8]);
title('Singular Values of the Centered Data', 'FontSize', 13);
xlabel('Singular Value Index', 'FontSize', 11);
ylabel('Singular Value Magnitude', 'FontSize', 11);
grid on;
set(gca, 'FontSize', 10);

fprintf('\nSingular values:\n');
disp(singular_values');

% Variance explained
total_var = sum(singular_values.^2);
var_explained = cumsum(singular_values.^2) / total_var * 100;
fprintf('\nCumulative variance explained (%%):\n');
disp(var_explained');

%% 1.3 — Scatter Plots of First Few Principal Components

% PC scores: project centered data onto principal directions
PC_scores = X_centered' * V;  % (4000 x 6)

figure('Name', 'Principal Component Scatter Plots', 'Position', [100 100 1100 380]);

subplot(1, 3, 1);
plot(PC_scores(:,1), PC_scores(:,2), 'k.', 'MarkerSize', 1);
title('PC 1 vs PC 2'); axis equal;
xlabel('Principal Component 1'); ylabel('Principal Component 2');
set(gca, 'FontSize', 10);

subplot(1, 3, 2);
plot(PC_scores(:,1), PC_scores(:,3), 'k.', 'MarkerSize', 1);
title('PC 1 vs PC 3'); axis equal;
xlabel('Principal Component 1'); ylabel('Principal Component 3');
set(gca, 'FontSize', 10);

subplot(1, 3, 3);
plot(PC_scores(:,2), PC_scores(:,3), 'k.', 'MarkerSize', 1);
title('PC 2 vs PC 3'); axis equal;
xlabel('Principal Component 2'); ylabel('Principal Component 3');
set(gca, 'FontSize', 10);

sgtitle('Scatter Plots of First 3 Principal Components', 'FontSize', 13);
