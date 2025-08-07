# MATLAB CL-Generalize-Charbonnier Reconstruction with TIGRE

## Project Introduction
This project implements a CT image reconstruction program using MATLAB and the TIGRE (Tomographic Iterative GPU-based Reconstruction Toolbox) library. It defines geometric parameters, loads data, generates projection data, and uses the Chambolle-Pock algorithm for image reconstruction. Finally, it evaluates the quality of the reconstructed images.

## Code Functionality Overview
1. **Initialization and Geometry Definition**:
   - Defines the geometric parameters for CT scanning, including the distance from source to detector (DSD), distance from source to origin (DSO), detector parameters (number of pixels, pixel size, total detector size), and image parameters (number of voxels, voxel size, total image size).
   - Defines projection angles, including rotation angles and oblique incidence angles.
2. **Data Loading and Projection Generation**:
   - Loads the data file `PCB2.mat` and performs transpose and type conversion on the data.
   - Generates projection data using TIGRE’s `Ax` function based on the defined geometry and angles.
3. **Image Reconstruction**:
   - Computes the spectral norm (Lipschitz constant) of the projection data using the `power_method` function.
   - Calls the `chambolle_pock_ILS_waituiZaiwai` function to perform image reconstruction, which is based on the Chambolle-Pock algorithm.
4. **Result Visualization and Quality Assessment**:
   - Visualizes different slices of the reconstructed results (e.g., middle slices, cross-sections of specific voxels).
   - Plots the iteration curves of quality assessment metrics such as RMSE (Root Mean Square Error), CC (Correlation Coefficient), MSSIM (Multi-Scale Structural Similarity), and UQI (Universal Quality Index).
   - Finally, calculates and displays the RMSE, CC, MSSIM, and UQI values between the reconstructed image and the original image.

## Notes
- This code relies on the GPU acceleration feature of the TIGRE library, so a CUDA-enabled NVIDIA GPU is required.
- The data file `PCB2.mat` should contain image data in a format compatible with TIGRE.
- In practical applications, you may need to adjust algorithm parameters based on specific data and requirements to achieve better reconstruction results.

## Author and Contact
- **Author**: [Yi Liu]
- **Email**: [liuyi@nuc.edu.cn]
