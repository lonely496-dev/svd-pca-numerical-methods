% =========================================================================
% NUMERICAL METHODS — Assignment 1
% Problem 4: Yale Face Dataset — SVD / PCA on Face Images
% =========================================================================
% Dataset: Yale_64x64.mat  (4096 x 165 matrix, 15 subjects x 11 conditions)
% =========================================================================

clear; clc; close all;

%% Load Data
load('../data/Yale_64x64.mat');

% Ensure shape is [4096 x N]
if size(fea, 1) ~= 4096
    fea = fea';
end

faceW = 64; faceH = 64;

%% Center Data
y_bar = mean(fea, 2);
Yc    = fea - y_bar;

%% Selected Faces (one per individual)
faces_chosed = [1, 12, 67, 78, 111];
ShowLine     = length(faces_chosed);

% =========================================================================
%% 4.1 — Low-Rank Approximation Grid (k = 4, 8, 15)
% =========================================================================
fprintf('Computing 4.1: Low-rank face approximations...\n');

Ks = [4, 8, 15];
numCols  = 5;   % Original | Approx(4) | Error(4) | Approx(8) | Approx(15)
canvas41 = zeros(faceH * ShowLine, faceW * numCols);

% Full economy SVD
[U_full, ~, ~] = svd(Yc, 'econ');

% Precompute reconstructions
approx_k = cell(1, length(Ks));
error_k  = cell(1, length(Ks));
for ki = 1:length(Ks)
    k      = Ks(ki);
    UK     = U_full(:, 1:k);
    ZK     = UK' * Yc;
    A      = UK * ZK;
    approx_k{ki} = A + y_bar;
    error_k{ki}  = fea - approx_k{ki};
end

for i = 1:ShowLine
    f = faces_chosed(i);
    r = (i-1)*faceH+1 : i*faceH;

    canvas41(r, 1:faceW)           = reshape(fea(:,f), faceH, faceW);
    canvas41(r, faceW+1:2*faceW)   = reshape(approx_k{1}(:,f), faceH, faceW);  % Approx k=4
    canvas41(r, 2*faceW+1:3*faceW) = reshape(error_k{1}(:,f),  faceH, faceW);  % Error  k=4
    canvas41(r, 3*faceW+1:4*faceW) = reshape(approx_k{2}(:,f), faceH, faceW);  % Approx k=8
    canvas41(r, 4*faceW+1:5*faceW) = reshape(approx_k{3}(:,f), faceH, faceW);  % Approx k=15
end

figure('Name', 'Face Approximations (4.1)', 'Position', [50 50 900 700]);
imagesc(canvas41); colormap(gray); axis image off;
title('Original  |  Approx(k=4)  |  Error(k=4)  |  Approx(k=8)  |  Approx(k=15)', ...
      'FontSize', 12);

% =========================================================================
%% 4.2 — Singular Value Spectrum Analysis
% =========================================================================
fprintf('Computing 4.2: Singular value spectrum...\n');

max_r = min(100, min(size(Yc)));
[~, S_spec, ~] = svds(Yc, max_r);
sv = diag(S_spec);

figure('Name', 'Singular Value Spectrum (4.2)', 'Position', [100 100 900 400]);
subplot(1,2,1);
plot(1:max_r, sv, 'bo-', 'MarkerSize', 4, 'LineWidth', 1.2);
title('Singular Values'); xlabel('Index'); ylabel('Value'); grid on;

subplot(1,2,2);
semilogy(1:max_r, sv, 'ro-', 'MarkerSize', 4, 'LineWidth', 1.2);
title('Log of Singular Values'); xlabel('Index'); ylabel('log(Value)'); grid on;

sgtitle('Singular Value Spectrum of Yale Face Dataset', 'FontSize', 13);

% Original vs approximation for k = 10, 30, 50
for k = [10, 30, 50]
    [Uk, Sk, Vk] = svds(Yc, k);
    recon = Uk * Sk * Vk' + y_bar;
    Z2 = zeros(faceH * ShowLine, faceW * 2);
    for i = 1:ShowLine
        f = faces_chosed(i);
        r = (i-1)*faceH+1 : i*faceH;
        Z2(r, 1:faceW)         = reshape(fea(:,f), faceH, faceW);
        Z2(r, faceW+1:2*faceW) = reshape(recon(:,f), faceH, faceW);
    end
    figure('Name', sprintf('Orig vs Approx k=%d', k), 'Position', [100 100 400 700]);
    imagesc(Z2); colormap(gray); axis image off;
    title(sprintf('Original (left) vs Approximation (right), r = %d', k), 'FontSize', 12);
end

% =========================================================================
%% 4.3 — First 5 Feature Vectors (Eigenfaces)
% =========================================================================
fprintf('Computing 4.3: Eigenfaces...\n');

[U5, ~, ~] = svds(Yc, 10);

figure('Name', 'First 5 Feature Vectors (4.3)', 'Position', [100 100 900 220]);
for i = 1:5
    subplot(1, 5, i);
    imagesc(reshape(U5(:,i), faceH, faceW));
    colormap(gray); axis off image;
    title(sprintf('U(:, %d)', i), 'FontSize', 10);
end
sgtitle('First 5 Feature Vectors (Columns of U)', 'FontSize', 13);

% =========================================================================
%% 4.4 — Approximation and Error Side-by-Side
% =========================================================================
fprintf('Computing 4.4: Approximation + error display...\n');

Ks44   = [4, 8, 15];
numCols44 = length(Ks44) * 2;
canvas44  = zeros(faceH * ShowLine, faceW * numCols44);
title_str = '';

for ki = 1:length(Ks44)
    k = Ks44(ki);
    [Uk, ~, ~] = svds(Yc, k);

    if ki == 1
        title_str = sprintf('k=%d (Approx) | Error | ', k);
    elseif ki == length(Ks44)
        title_str = [title_str, sprintf('k=%d (Approx) | Error', k)]; %#ok<AGROW>
    else
        title_str = [title_str, sprintf('k=%d (Approx) | Error | ', k)]; %#ok<AGROW>
    end

    for i = 1:ShowLine
        f = faces_chosed(i);
        r = (i-1)*faceH+1 : i*faceH;

        coeffs         = Uk' * Yc(:,f);
        approx_img     = reshape(Uk*coeffs + y_bar, faceH, faceW);
        error_img      = reshape(fea(:,f) - (Uk*coeffs + y_bar), faceH, faceW);

        col_a = (ki-1)*2*faceW + 1;
        col_e = col_a + faceW;

        canvas44(r, col_a:col_a+faceW-1) = approx_img;
        canvas44(r, col_e:col_e+faceW-1) = error_img;
    end
end

figure('Name', 'Face Approximation and Error (4.4)', 'Position', [50 50 1100 700]);
imagesc(canvas44); colormap(gray); axis image off;
sgtitle({'Original Faces (Leftmost Column) vs.'; ...
         ['Approximation and Error: ', title_str]}, 'FontSize', 12);

fprintf('\nAll done.\n');
