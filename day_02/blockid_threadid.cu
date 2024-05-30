#include <stdio.h>
#include <cuda_runtime.h>

__global__ void printThreadInfo() {
    int threadID = blockIdx.x * blockDim.x + threadIdx.x;
    printf("ThreadIdx: %d, BlockId: %d, BlockDim: %d, Effective Thread ID: %d\n", threadIdx.x, blockIdx.x, blockDim.x, threadID);

}

int main() {
    int numBlocks = 3;
    int threadsPerBlock = 4;

    printThreadInfo<<<numBlocks, threadsPerBlock>>>();
    //or printThreadInfo<<<3, 4>>>();
    cudaDeviceSynchronize();

    return 0;
}