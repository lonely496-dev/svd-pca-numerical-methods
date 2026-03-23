# SVD & PCA Numerical Analysis
### Singular Value Decomposition · Principal Component Analysis · Dimensionality Reduction

A MATLAB-based project demonstrating how **Singular Value Decomposition (SVD)** and **Principal Component Analysis (PCA)** can be applied to real-world datasets for dimensionality reduction, data compression, visualization, and pattern discovery.

---

## Overview

High-dimensional datasets are often costly to store, computationally intensive to process, and difficult to interpret. This project explores how SVD—serving as the mathematical foundation of PCA—addresses these challenges through:

- Efficient **dimensionality reduction** while preserving key information  
- **Image compression** via low-rank matrix approximations  
- Identification of **hidden structures and clusters** in data  
- Evaluation of **reconstruction error** relative to retained components  

The analysis is performed on four datasets representing both synthetic and real-world scenarios.

---

## Datasets

| Dataset | Dimensions | Description |
|--------|-----------|-------------|
| ModelReductionData.mat | 6 × 4000 | Synthetic high-dimensional dataset |
| HandwrittenDigits.mat | 256 × 1707 | 16×16 grayscale digit images (0,1,3,7) |
| IrisDataAnnotated.mat | 4 × 150 | Iris dataset with 3 species |
| Yale_64x64.mat | 4096 × 165 | Face images (64×64), 15 subjects under varying conditions |

---

## Key Results

### 1. Model Data Reduction

Pairwise projections of the 6D dataset reveal strong linear correlations, indicating that the data lies within a lower-dimensional subspace. The singular value spectrum shows a clear elbow, suggesting that only 2–3 components capture most of the variance.

---

### 2. Handwritten Digit Reconstruction

Reconstruction using increasing SVD components (k = 5 → 25) shows progressive improvement:

- Low k: Blurry but recognizable structure  
- High k: Sharp reconstruction with fine details  

Residuals transition from structured patterns to noise, confirming that meaningful features are captured before noise.

---

### 3. Iris Dataset (PCA Clustering)

Projection onto the first two principal components reveals:

- Clear separation of *Setosa*  
- Partial overlap between *Versicolor* and *Virginica*  

This demonstrates PCA’s effectiveness in visualizing class structure in reduced dimensions.

---

### 4. Yale Face Dataset (Eigenfaces)

SVD generates **eigenfaces**, representing dominant facial patterns across lighting and expressions. Low-rank approximations illustrate progressive recovery of facial detail.

---

## Project Structure

svd-pca-numerical-analysis/
│
├── README.md
│
├── src/
│   ├── problem1_model_reduction.m
│   ├── problem2_handwritten_digits.m
│   ├── problem3_iris_pca.m
│   └── problem4_yale_faces.m
│
├── figures/                # Generated plots
├── data/                   # Input datasets (.mat files)
│
└── docs/
    └── Report.pdf

**Note:** Dataset files are excluded via `.gitignore`. Place all `.mat` files inside the `data/` directory before execution.

---

## Requirements

- MATLAB R2020b or later  
- No additional toolboxes required  

---

## Getting Started

Clone the repository:

git clone https://github.com/lonely496-dev/svd-pca-numerical-methods.git  
cd svd-pca-numerical-methods  

Run scripts in MATLAB:

run('src/problem1_model_reduction.m')  
run('src/problem2_handwritten_digits.m')  
run('src/problem3_iris_pca.m')  
run('src/problem4_yale_faces.m')  

---

## Core Concepts

- Singular Value Decomposition (SVD)  
- Principal Component Analysis (PCA)  
- Low-Rank Approximation  
- Dimensionality Reduction  
- Eigenfaces  
- Reconstruction Error Analysis  
- Singular Value Spectrum  

---

## Conclusion

This project highlights how linear algebra techniques can extract meaningful structure from high-dimensional data while improving efficiency and interpretability. The results demonstrate the practical value of SVD and PCA across multiple domains including image processing and data visualization.

---

## Author

Developed as part of a Numerical Methods course (2025).
