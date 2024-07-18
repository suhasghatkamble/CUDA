// Assignment : Modify the array addition example to make it two dimensional.


#include <stdio.h>
#include <cuda.h>

__global__ void add_arrays(int *c, const int *a, const int *b, int size) {

    int i = blockIdx.x * blockDim.x + threadIdx.x;  // finding thread number
    int j = blockIdx.y * blockDim.y + threadIdx.y;


    if(i < size && j< size){
    c[i][j] = a[i][j] + b[i][j];                       //check it checks whether size is not greater than array size
    }
}

int main() {
    const int size = 5;

    int a[size] = {1 , 2 , 3 , 4 , 5};
    int b[size] = {1 , 2 , 3 , 4 , 5};
    int *d_c;

    // Allocate memory on the device for array c 

    cudaMalloc((void**)&  d_c, size * sizeof(int));

    // Copy array a and b to the device

    int *d_a, *d_b;

    cudaMalloc((void**)&d_a, size * sizeof(int));
    cudaMalloc((void**)&d_b, size * sizeof(int));
    cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);



    dim3 threadsPerBlock(16,16);
    dim3 numBlocks(((N + threadsPerBlock.x - 1) / threadsPerBlock.x) , ((N + threadsPerBlock.y -1) / threadsPerBlock.y));
    
    // Launch kernel
    add_arrays<<<(125,125), (16,16)>>>(d_c, d_a, d_b, size);
    cudaDeviceSynchronize();

    // Copy the result back from the device
    int *c = (int*)malloc(5 * sizeof(int));
    cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    for (int i = 0; i < size; i++) {
        printf("%d ", c[i]);
    }
    
    printf("\n");
     
     // Free memory on the device
     cudaFree(c);
     cudaFree(d_a);
     cudaFree(d_b);
     cudaFree(d_c);

     return 0;
}





