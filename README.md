# Bilinear Transform and Filter Comparison in Digital Signal Processing

This project demonstrates the application of the **Bilinear Transform** in digital signal processing and compares its effectiveness against **Nyquist Sampling** and **FIR (Finite Impulse Response) Filters**. The objective is to show how bilinear filtering suppresses aliasing and improves signal reconstruction when undersampling.

---

## 📌 Table of Contents

1. [Project Overview](#project-overview)
2. [Objectives](#objectives)
3. [Tools and Technologies](#tools-and-technologies)
4. [Project Structure](#project-structure)
5. [How to Run](#how-to-run)
6. [Key Results](#key-results)
7. [Visualizations](#visualizations)
8. [License](#license)
9. [Contact](#contact)

---

## 📖 Project Overview

This repository provides a MATLAB-based implementation and comparison of digital filtering techniques. It focuses on using the Bilinear Transform to convert analog filters into digital form and analyzes their effectiveness against FIR filters and Nyquist sampling strategies.

---

## 🎯 Objectives
1. Implement the bilinear transform for analog-to-digital filter conversion.
2. Compare:
  - Bilinear filter vs. FIR filter
  - Bilinear filter vs. Nyquist sampling
3. Visualize signals in time and frequency domains.
4. Evaluate aliasing and reconstruction quality using Mean Squared Error (MSE).

---

## 🛠 Tools and Technologies

- **Language:** MATLAB
- **Toolboxes:** Signal Processing Toolbox
- **Techniques Used:**
  - Bilinear Transform
  - FIR Filtering
  - Nyquist Sampling
  - Frequency Analysis

---

## 📁 Project Structure

Bilinear-Transform-and-Filter-Comparision/
│
├── bilinear_filter_comparison.m # Main MATLAB script
├── README.md # Project documentation


---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/AnitaSahoo2002/Bilinear-Transform-and-Filter-Comparision.git
2. Open MATLAB and navigate to the project directory.

3. Run the script

4. View time-domain and frequency-domain plots, and check MSE values in the console.

## 📊 Key Results

- Bilinear filter reduced aliasing by approximately 85% before downsampling.

- Achieved 47% lower MSE in signal reconstruction compared to FIR filtering.

- Frequency-domain plots confirm suppression of high-frequency noise and artifacts.

## 📈 Visualizations

This project generates:

- Original vs. filtered signal plots in the time domain.

- Spectral analysis comparing original, FIR-filtered, and bilinear-filtered signals.

- Numerical analysis using MSE to quantify reconstruction accuracy.

## 📄 License
© 2025 Anita Sahoo — [MIT License](LICENSE)


