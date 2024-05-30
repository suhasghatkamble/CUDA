#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

__global__ void vectorAddition_kernel(int* d_a, int* d_b, int* d_c, int N) {
    int tid = threadIdx.x;
    int i;
    for (i = tid; i < N; i+= blockDim.x) {
        d_c[i] = d_a[i] + d_b[i];
        printf("\n Threadid : %d = %d\n", tid,d_c[i]);
    }
}

int main() {
    int N = 12;
    int* h_a, * h_b, * h_c; // Host variable
    int* d_a, * d_b, * d_c; // Device variable

    // Allocate memory for host variable
    h_a = (int*)malloc(N * sizeof(int));
    h_b = (int*)malloc(N * sizeof(int));
    h_c = (int*)malloc(N * sizeof(int));

    // Allocate memory for device variables
    cudaMalloc((void**)&d_a, N * sizeof(int));
    cudaMalloc((void**)&d_b, N * sizeof(int));
    cudaMalloc((void**)&d_c, N * sizeof(int));

    // Initialize host variables
    for (int i=0; i < N; i++){
        h_a[i] = 2;
        h_b[i] = 2;
        h_c[i] = 0;
    }

    // Copy host variables to device
    cudaMemcpy(d_a, h_a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, N * sizeof(int), cudaMemcpyHostToDevice);


    // Launch kernel function
    int blockSize = 1;
    int numThreads = 4;
    vectorAddition_kernel <<<blockSize, numThreads>>>(d_a, d_b, d_c, N);

    // Copy result back to host
    cudaMemcpy(h_c, d_c, N * sizeof(int), cudaMemcpyDeviceToHost);

    // Display results
    printf("Result: ");
    for (int i = 0; i< N; i++) {
        printf("%d",h_c[i]);
    }
    printf("\n");

    // Free device and host Memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(h_a);
    free(h_b);
    free(h_c);

    return 0;

    // here 1 block and 8 threads




    

}
