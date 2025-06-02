## 📖 About

**ImageCipherSecuritySuite** is a cross-platform toolkit designed to evaluate the security characteristics of encrypted (ciphertext) images through both visual and statistical analysis.

The program supports grayscale and RGB images and includes the following evaluation methods:

- 📊 Pixel histogram analysis  
- 🌐 3D surface visualization of pixel intensities  
- 🧮 Information entropy calculation  
- 📈 Adjacent pixel correlation (coefficients and scatter plots)  
- 🔍 Optional NPCR and UACI metrics for comparison with the original image  

---

该程序用于评估**密文图像的安全性特征**，通过可视化与统计指标来直观展示图像加密效果。

支持灰度图与 RGB 彩色图像，核心功能包括：

- 📊 像素灰度直方图分析  
- 🌐 像素强度三维表面图可视化  
- 🧮 信息熵计算  
- 📈 相邻像素相关性分析（系数与散点图）  
- 🔍 可选支持原图与密文图的 NPCR / UACI 指标对比



# 🔐 Image Cipher Analyzer

**`image_cipher_analyzer.py`** is a Python tool for analyzing the security characteristics of encrypted (cipher) images.

It provides detailed visual and statistical analysis including:

- 📊 Grayscale and RGB Histogram
- 🌐 3D Surface Visualization
- 🧮 Information Entropy
- 📈 Pixel Correlation (coefficients + scatter plots)
- 🔍 Optional: NPCR & UACI comparison with original image

---

## 📦 Installation

Install the required dependencies:

```bash
pip install opencv-python numpy matplotlib scikit-image
```

## 🚀 Usage

### 1️⃣ Analyze Cipher Image Only

Analyze a grayscale or RGB encrypted image. If the image is RGB, each color channel (R, G, B) will be analyzed separately.

```python
from image_cipher_analyzer import analyze_image

# Analyze only the encrypted image
analyze_image("cipher_image.png")
```

### 🧾 Function Signature

```python
analyze_image(cipher_path, original_path=None, enable_compare=False)
```

| Parameter        | Type   | Description                                                                |
| ---------------- | ------ | -------------------------------------------------------------------------- |
| `cipher_path`    | `str`  | Path to the encrypted (cipher) image file                                  |
| `original_path`  | `str`  | *(Optional)* Path to the original (plaintext) image file                   |
| `enable_compare` | `bool` | Whether to compare the original and cipher image for NPCR/UACI calculation |

---

### 🧠 Notes

- ✅ If the image is **grayscale**, a single analysis will be performed on the entire image.
- ✅ If the image is **RGB**, each channel (Red, Green, Blue) will be analyzed separately.
- ✅ To enable **NPCR** and **UACI**:
  - Set `enable_compare=True`.
  - Provide the `original_path` parameter with the path to the original (plaintext) image.
  - Both the cipher and original images must have the **same dimensions**.
- ✅ NPCR and UACI values will only be computed when both images are of **identical size**.
- ✅ For effective analysis, images should be in formats like `.png`, `.jpg`, or `.jpeg`.

---

### 📊 How NPCR & UACI are Calculated

1. **NPCR**: This metric measures the percentage of changed pixels between the original and encrypted images. It indicates how well the encryption algorithm alters the pixel values.
2. **UACI**: This metric measures the average pixel intensity difference between the original and encrypted images, normalized to 255 (maximum possible value for pixel intensity).

---

### 🧮 Interpreting Results

| Metric | Ideal Value | Interpretation |
|--------|-------------|----------------|
| **NPCR** | ≥ 99% | High NPCR value indicates that a small change in the input image will result in a large change in the encrypted image. |
| **UACI** | ≈ 33% | UACI value close to 33% indicates that the ciphered image has a significant difference from the original image. |
