#include<stdio.h>
#include<cuda_runtime.h>


__global__ void add_arrays(int *c, const int *a, const int *b, int size) {

    int i = blockIdx.x * blockDim.x + threadIdx.x;  // finding thread number
    
    if(i < size){

	c[i] = a[i] + b[i];                       
	}
}

int main() {
    const int size = 90000;

    int *d_c;

    int a[size];
    int b[size];
	

    for (int i = 0; i < size; i++) {
        a[i] = i;
        b[i] = i;
    }

    // Allocate memory on the device for array c 

    cudaMalloc((void**)&  d_c, size * sizeof(int));

    // Copy array a and b to the device

    int *d_a, *d_b;

    cudaMalloc((void**)&d_a, size * sizeof(int));
    cudaMalloc((void**)&d_b, size * sizeof(int));

    cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);


    // Start timing GPU execution
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    // Calculating threads and blocks per grid
    int threadsPerBlock=1024;
    int blocksPerGrid = (size + threadsPerBlock - 1)/ threadsPerBlock;

    // passing threadsperblocks and blockspergrid
    add_arrays<<<blocksPerGrid, threadsPerBlock>>>(d_c, d_a, d_b, size);
    cudaDeviceSynchronize();

    // Stop timing GPU execution
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    // Copy the result back from the device
    int *c = (int*)malloc(size * sizeof(int));
    cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    for (int i = 0; i < size; i++) {
        printf("a = %d ,b = %d, c = %d \n",a[i],b[i], c[i]);
    }
    
    printf("\n");
    
    // Print time taken by GPU
    printf("Time taken by GPU : %f milliseconds\n", milliseconds);
     
     // Free memory on the device
     cudaFree(c);
     cudaFree(d_a);
     cudaFree(d_b);
     cudaFree(d_c);

     return 0;
}

//0.025792 time taken

// TO RUN CODE

// nvcc findblocks_gputime.cu
// ./a.out



// cpu                     gpu
// a[1000]  --copy--       a[]
// b[1000]  --copy--       b[]
// c[]                     c[a+b] ----- copy to cpu c[]