#include<stdio.h>
#include<cuda_runtime.h>

//CUDA kernel function for printing prime number
__global__ void printPrimeNumbers(){
    int threadID=blockIdx.x * blockDim.x + threadIdx.x;

if(threadID>2 && threadID<=10000001)
{ 
  int flag=1;//it is prime number
    
    for (size_t i = 2; i < threadID; i++)
    {
        if(threadID%i==0){
            flag=0;//it it not a prime number
            break;
        }
    }

    if(flag)
    {
        // printf("%d ",threadID); //it will print threads which are prime
    }           
}

}





int main()
{
    // create host var
    int host_fromNum = 2;
    int host_toNum =10000001;


    //Declare for Device variables/pointers
    int *device_fromNum;
    int *device_toNum;

    //Allocate memory on the device/host
    cudaMalloc((void**)&device_fromNum, sizeof(int));
    cudaMalloc((void**)&device_toNum, sizeof(int));

    //copy data from host to device
    cudaMemcpy(device_fromNum,&host_fromNum,sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(device_toNum,&host_toNum,sizeof(int),cudaMemcpyHostToDevice);

    int threadPerBlock=512;
    int blockPerGrid=(host_toNum+threadPerBlock-1)/threadPerBlock;

   // Start timing GPU execution
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);


    printPrimeNumbers <<<blockPerGrid,threadPerBlock>>>();
    cudaDeviceSynchronize();


// Stop timing GPU execution
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    // Print time taken by GPU
    printf("\nTime taken by GPU : %f milliseconds\n", milliseconds);

    //free alloacted memory
    cudaFree(device_fromNum);
    cudaFree(device_toNum);


}