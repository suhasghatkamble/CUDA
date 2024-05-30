#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int main() {
    int deviceCount;
    cudaGetDeviceCount(&deviceCount);

    if (deviceCount == 0) {
        printf("No CUDA devices found.\n");
        return 1;
    }

    for (int device = 0; device < deviceCount; ++device) {
        cudaDeviceProp deviceProp;
        cudaGetDeviceProperties(&deviceProp, device);

        printf("Device %d: %s\n", device, deviceProp.name);
        printf(" Compute Capability: %d.%d\n", deviceProp.major, deviceProp.minor);
        printf(" Total Global Memory: %lu bytes \n", (unsigned long) deviceProp.sharedMemPerBlock);
        printf(" Warp Size: %d\n", deviceProp.warpSize);
        printf(" Max Threads Per Block: %d\n", deviceProp.maxThreadsPerBlock);
        printf(" Max Threads Dimension: (%d, %d, %d)\n", deviceProp.maxThreadsDim[0], deviceProp.maxThreadsDim[1], deviceProp.maxThreadsDim[2]);
        printf(" Max Grid Size: (%d, %d, %d)\n", deviceProp.maxGridSize[0], deviceProp.maxGridSize[1], deviceProp.maxGridSize[2]);
        printf(" Clock Rate: %d kHz\n", deviceProp.clockRate);
        printf(" Memory Clock Rate: %d kHz\n", deviceProp.memoryClockRate);
        printf(" Memory Bus Width: %d bits\n", deviceProp.memoryBusWidth);
        printf(" L2 Cache Size: %d bytes\n", deviceProp.l2CacheSize);
        printf(" Constant Memory Size: %lu bytes\n", (unsigned long) deviceProp.totalConstMem);
        printf(" Texture Alignment: %lu bytes\n", (unsigned long) deviceProp.textureAlignment);
        printf("\n");
            
        }
        return 0;
}