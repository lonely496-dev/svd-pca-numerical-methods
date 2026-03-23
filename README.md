# SVD & PCA Numerical Analysis
### Singular Value Decomposition · Principal Component Analysis · Dimensionality Reduction

This project applies **Singular Value Decomposition (SVD)** and **Principal Component Analysis (PCA)** to different datasets to study dimensionality reduction, image reconstruction, and data structure.

---

## Overview

Working with high-dimensional data can make analysis and visualization difficult. This project shows how SVD and PCA can be used to:

- Reduce dimensionality while keeping the main structure  
- Reconstruct images using fewer components  
- Visualize patterns in data  
- Measure reconstruction error as components increase  

The methods are tested on both synthetic and real datasets.

---

## Datasets

| Dataset | Dimensions | Description |
|--------|-----------|-------------|
| `ModelReductionData.mat` | 6 × 4000 | Synthetic dataset |
| `HandwrittenDigits.mat` | 256 × 1707 | 16×16 grayscale digit images (0, 1, 3, 7) |
| `IrisDataAnnotated.mat` | 4 × 150 | Iris dataset with 3 species |
| `Yale_64x64.mat` | 4096 × 165 | Face images (64×64) |

---

## Key Results

### 1. Model Data Reduction

The pairwise projections show strong linear relationships, suggesting the data lies in a lower-dimensional space.

<p align="center">
  <img src="figures/model_projections.png" width="550"/>
</p>

The singular values drop sharply, indicating that only a few components are needed.

<p align="center">
  <img src="figures/singular_values.png" width="450"/>
</p>

Principal component projections confirm the same structure.

<p align="center">
  <img src="figures/pca_scatter.png" width="500"/>
</p>

---

### 2. Handwritten Digit Reconstruction

Reconstruction improves as more components are used.

<p align="center">
  <img src="figures/digit_approximations.png" width="550"/>
</p>

- Low k → rough shapes  
- High k → clearer details  

Residuals become less structured as more information is captured:

<p align="center">
  <img src="figures/digit_residuals.png" width="500"/>
</p>

Error decreases consistently with increasing components:

<p align="center">
  <img src="figures/error_norms.png" width="450"/>
</p>

---

### 3. Iris Dataset (PCA)

Projecting onto two principal components shows:

- Clear separation of *Setosa*  
- Partial overlap between *Versicolor* and *Virginica*  

---

### 4. Yale Face Dataset (Eigenfaces)

SVD produces basis images (eigenfaces) that capture the main variations in faces.

- Increasing components improves reconstruction quality  
- Most information is captured in relatively few components  

---

## Project Structure

```text
svd-pca-numerical-analysis/
│
├── src/
│   ├── problem1_model_reduction.m
│   ├── problem2_handwritten_digits.m
│   ├── problem3_iris_pca.m
│   └── problem4_yale_faces.m
│
├── figures/
├── data/
└── docs/
    └── Report.pdf
```

> Place all `.mat` files in the `data/` directory before running the scripts.

---

## Requirements

- MATLAB R2020b or later  

---

## Getting Started

```bash
git clone https://github.com/lonely496-dev/svd-pca-numerical-methods.git
cd svd-pca-numerical-methods
```

```matlab
run('src/problem1_model_reduction.m')
run('src/problem2_handwritten_digits.m')
run('src/problem3_iris_pca.m')
run('src/problem4_yale_faces.m')
```

---

## Core Concepts

- Singular Value Decomposition (SVD)  
- Principal Component Analysis (PCA)  
- Low-Rank Approximation  
- Dimensionality Reduction  
- Eigenfaces  
- Reconstruction Error  

---

## Author

KP Dixit
