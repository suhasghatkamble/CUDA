#include <stdio.h>
#include <cuda.h>

__global__ void grandchildKernel() {
    printf("From C-DAC ");
}

__global__ void childKernel() {

    grandchildKernel<<<1,1>>>();

    cudaDeviceSynchronize();  // // Wait for the grandchild to complete 

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

//nvcc -rdc=true grandchild_kernel_called.cu