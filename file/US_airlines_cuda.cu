#include <stdio.h>
#include <stdlib.h>
#include <chrono>
#include <iostream>

#define NUM_CLASSES 3

// Function to be executed on the GPU (kernel)
__global__ void calculateComfort(int *d_classArray, float *d_seatComfortArray, float *d_totalComfort, int *d_classCounts, int numRecords) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;

  if (idx < numRecords) {
    int classIndex = d_classArray[idx];
    float seatComfort = d_seatComfortArray[idx];

    atomicAdd(&d_totalComfort[classIndex], seatComfort);
    atomicAdd(&d_classCounts[classIndex], 1);
  }
}

int main() {
  // ... (same as original CPU code for file handling and data allocation)

  // Allocate device memory (GPU)
  int *d_classArray;
  float *d_seatComfortArray;
  float *d_totalComfort;
  int *d_classCounts;

  cudaMalloc((void**)&d_classArray, numRecords * sizeof(int));
  cudaMalloc((void**)&d_seatComfortArray, numRecords * sizeof(float));
  cudaMalloc((void**)&d_totalComfort, NUM_CLASSES * sizeof(float));
  cudaMalloc((void**)&d_classCounts, NUM_CLASSES * sizeof(int));

  // Copy data from host to device
  cudaMemcpy(d_classArray, classArray, numRecords * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_seatComfortArray, seatComfortArray, numRecords * sizeof(float), cudaMemcpyHostToDevice);

  // Initialize total comfort and class counts on device (zero them out)
  cudaMemset(d_totalComfort, 0, NUM_CLASSES * sizeof(float));
  cudaMemset(d_classCounts, 0, NUM_CLASSES * sizeof(int));

  auto start_time = std::chrono::high_resolution_clock::now();

  // Launch the kernel on the GPU
  int threadsPerBlock = 256;  // Adjust as needed for your GPU
  int blocks = (numRecords + threadsPerBlock - 1) / threadsPerBlock;
  calculateComfort<<<blocks, threadsPerBlock>>>(d_classArray, d_seatComfortArray, d_totalComfort, d_classCounts, numRecords);

  // Wait for GPU to finish
  cudaDeviceSynchronize();

  auto end_time = std::chrono::high_resolution_clock::now();

  // ... (same as original CPU code for calculating time taken and reporting results)

  // Free device memory
  cudaFree(d_classArray);
  cudaFree(d_seatComfortArray);
  cudaFree(d_totalComfort);
  cudaFree(d_classCounts);

  // ... (same as original CPU code for freeing host memory)

  return 0;
}