% =========================================================================
% NUMERICAL METHODS — Assignment 1
% Problem 3: Iris Dataset — PCA and Cluster Visualization
% =========================================================================
% Dataset: IrisDataAnnotated.mat  (4x150 matrix, labels in 'I')
% Species: 1=Setosa, 2=Versicolor, 3=Virginica
% =========================================================================

clear; clc; close all;

%% Load Data
load('../data/IrisDataAnnotated.mat');

[num_features, num_samples] = size(X);
fprintf('Iris data: %d features x %d samples\n', num_features, num_samples);

%% Center Data
x_bar = mean(X, 2);
Xc    = X - x_bar;

%% SVD
[U, S, ~] = svd(Xc, 'econ');

% Variance explained by each PC
singular_values = diag(S);
var_explained   = (singular_values.^2 / sum(singular_values.^2)) * 100;

fprintf('\nVariance explained per PC:\n');
for i = 1:length(var_explained)
    fprintf('  PC%d: %.2f%%\n', i, var_explained(i));
end
fprintf('  PC1+PC2 combined: %.2f%%\n', sum(var_explained(1:2)));

%% Project onto First Two PCs
Z = U(:, 1:2)' * Xc;   % 2 x 150

%% Species Masks
setosa     = (I == 1);
versicolor = (I == 2);
virginica  = (I == 3);

%% Plot: PCA Cluster Visualization
figure('Name', 'PCA of Iris Dataset', 'Position', [150 150 700 550]);
hold on;

plot(Z(1, setosa),     Z(2, setosa),     'ro', 'MarkerSize', 7, ...
     'LineWidth', 1.2, 'DisplayName', 'Setosa');
plot(Z(1, versicolor), Z(2, versicolor), 'go', 'MarkerSize', 7, ...
     'LineWidth', 1.2, 'DisplayName', 'Versicolor');
plot(Z(1, virginica),  Z(2, virginica),  'bo', 'MarkerSize', 7, ...
     'LineWidth', 1.2, 'DisplayName', 'Virginica');

xlabel(sprintf('Principal Component 1  (%.1f%% variance)', var_explained(1)), 'FontSize', 11);
ylabel(sprintf('Principal Component 2  (%.1f%% variance)', var_explained(2)), 'FontSize', 11);
title('PCA of Iris Dataset: Species Clusters', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
grid on;
set(gca, 'FontSize', 11);
hold off;
