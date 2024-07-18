//Assignment ( 25 may ) : Dynamic Parallelism - Maintain a copy of the original code. Modify the code to have the square functionality inside the doubleValue function itself.
// Have 1000000 elements, instead of 10 in both the versions. Compare the performance of the two versions by adding timing code.


#include<stdio.h>
#include<cuda.h>

__global__ void doubleValues(int* data, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {        
        data[i] = (data[i] * data[i]) * 2;
    }
}

int main() {
    // Allocate memory on host and device
    int size = 10000000;
    int* data_host = new int[size];
    int* data_device;
    cudaMalloc(&data_device, size * sizeof(int));

    // Initialize data on host
    for (int i = 0; i < size; ++i) {
        data_host[i] = i;
    }

    // Copy data to device
    cudaMemcpy(data_device, data_host, size * sizeof(int), cudaMemcpyHostToDevice);



   // Start timing GPU execution
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    // Launch kernel
    int threadsPerBlock = 256;
    doubleValues<<<(size + threadsPerBlock -1) / threadsPerBlock, threadsPerBlock>>> (data_device, size);

    // Wait for kernel to finish
    cudaDeviceSynchronize();


// Stop timing GPU execution
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);


    



    // Copy data back from device
    cudaMemcpy(data_host, data_device, size * sizeof(int), cudaMemcpyDeviceToHost);

    // // Print results
    // for ( int i= 0; i < size; ++i) {
    //     printf("data[%d] = %d\n", i, data_host[i]);
    // }

    // Print time taken by GPU
    printf("\nTime taken by GPU : %f milliseconds\n", milliseconds);


    // Free memory
    cudaFree(data_device);
    delete[] data_host;

    return 0;
    }


// Time taken by GPU WITH PRINTING VALUES : 8.354336 milliseconds


// Time taken by GPU : 0.152288 milliseconds
//Time taken by GPU : 0.153952 milliseconds
//Time taken by GPU : 0.153376 milliseconds
// Time taken by GPU : 0.166208 milliseconds
