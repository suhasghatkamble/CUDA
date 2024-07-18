#include<stdio.h>
#include<cuda.h>


__device__ int square(int a) {
    printf("Thread (%d, %d) - squaring value \n", blockIdx.x, threadIdx.x);
    return a * a;
}

__global__ void doubleValues(int* data, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {
        int value = data[i];
        // Call square function and print thread ID
        int squared_value = square(value);

        printf("Thread (%d, %d) - doubling squared value\n", blockIdx.x, threadIdx.x);
        data[i] = squared_value * 2;
    }
}

int main() {
    // Allocate memory on host and device
    int size = 10;
    int* data_host = new int[size];
    int* data_device;
    cudaMalloc(&data_device, size * sizeof(int));

    // Initialize data on host
    for (int i = 0; i < size; ++i) {
        data_host[i] = i;
    }

    // Copy data to device
    cudaMemcpy(data_device, data_host, size * sizeof(int), cudaMemcpyHostToDevice);

    // Launch kernel
    int threadsPerBlock = 256;
    doubleValues<<<(size + threadsPerBlock -1) / threadsPerBlock, threadsPerBlock>>> (data_device, size);

    // Wait for kernel to finish
    cudaDeviceSynchronize();

    // Copy data back from device
    cudaMemcpy(data_host, data_device, size * sizeof(int), cudaMemcpyDeviceToHost);

    // Print results
    for ( int i= 0; i < size; ++i) {
        printf("data[%d] = %d\n", i, data_host[i]);
    }

    // Free memory
    cudaFree(data_device);
    delete[] data_host;

    return 0;
    }