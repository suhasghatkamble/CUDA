#include <stdio.h>
#include <cuda.h>

__global__ void childKernel() {
    printf("Hello ");
}

__global__ void parentKernel() {
    childKernel<<<1,1>>>();

    cudaDeviceSynchronize();  // Wait for the child to complete , first print child's

    printf("World!\n");
}

int main() {
    parentKernel<<<1,1>>>();

    cudaDeviceSynchronize();  // Wait for the parent to complete

    return 0;
}

//nvcc -rdc=true global_called_global.cu