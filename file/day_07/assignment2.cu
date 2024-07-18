// Assignment 2 : From the original copy of the code, create a new code file. Try to make the square function also global,
// instead of it being a device function. Try to execute and note your observations.


#include<stdio.h>
#include<cuda.h>


__global__ int square(int a) {
    // printf("Thread (%d, %d) - squaring value \n", blockIdx.x, threadIdx.x);
    a = a * a;
}

__global__ void doubleValues(int* data, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    

    if (i < size) {
        int value = data[i];
        square<<<1,1>>>(value);
        // Call square function and print thread ID
        int squared_value = square(value);

        // printf("Thread (%d, %d) - doubling squared value\n", blockIdx.x, threadIdx.x);
        data[i] = squared_value * 2;

         cudaDeviceSynchronize();
    }return
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

    // Print results
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

    // Time taken by GPU WITHOUT PRINTING : 0.149376 milliseconds