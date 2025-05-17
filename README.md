# Bilinear Transform and Filter Comparison in Digital Signal Processing

This project demonstrates the application of the **Bilinear Transform** in digital signal processing and compares its effectiveness against **Nyquist Sampling** and **FIR (Finite Impulse Response) Filters**. The main objective is to illustrate how bilinear filtering can suppress aliasing effects and improve signal reconstruction under undersampled conditions.

## 🔍 Project Objectives

- Implement bilinear transform to convert analog filters to digital form.
- Compare the performance of:
  - Bilinear filter vs. FIR filter.
  - Bilinear filter vs. Nyquist sampling.
- Visualize and analyze signals in both time and frequency domains.
- Quantify aliasing reduction and filtering accuracy using Mean Squared Error (MSE).

## 🛠 Tools and Technologies

- **Language:** MATLAB
- **Toolboxes:** Signal Processing Toolbox
- **Techniques:** Bilinear Transform, FIR Filtering, Nyquist Sampling, Frequency Analysis

## 📊 Key Results

- Bilinear filter reduced aliasing by **~85%** when applied before downsampling.
- Achieved a **47% lower MSE** in sparse signal reconstruction compared to FIR filters.
- Visual comparisons confirmed improved signal fidelity and reduced high-frequency distortion.

## 📁 Project Structure

