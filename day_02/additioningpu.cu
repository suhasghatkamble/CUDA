#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

// CUDA kernel to add two integers
__global__ void addIntegers(int* a, int* b, int* result) {
    *result = *a + *b;
}

int main(){
    //  Host variables
    int host_a = 5;
    int host_b = 7;
    int host_result = 0;

    // Device variables
    int* device_a, * device_b, * device_result;

    // Allocate memory on the device
    cudaMalloc((void**)&device_a, sizeof(int));
    cudaMalloc((void**)&device_b, sizeof(int));
    cudaMalloc((void**)&device_result, sizeof(int));

    //Copy data from host to device
    cudaMemcpy(device_a, &host_a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(device_b, &host_b, sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel with one block and one thread
    addIntegers <<<1,1>>> (device_a, device_b, device_result);

    // Copy the result from device to host
    cudaMemcpy(&host_result, device_result, sizeof(int), cudaMemcpyDeviceToHost);

    // Display the result
    printf("Sum of %d and %d is %d\n", host_a, host_b, host_result);

    // Free allocated memory
    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_result);
    return 0;
}