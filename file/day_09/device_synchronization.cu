// importance of function call in cuda


#include <cuda_runtime.h>
#include <stdio.h>

__global__ void kernel(void) {
	printf("Hello from GPU \n");
}

void cpu_print(void) {
	printf("Hello from CPU  \n");
}

int main() {
	kernel <<<1, 1>>> ();
	kernel <<<1, 1>>> ();
	kernel <<<1, 1>>> ();

	cudaDeviceSynchronize();
	//wait till gpu work done , for synchronization
	//gate betw cpu and gpu, cpu cant go next before execution of gpu work
	//telling the cpu to wait till all the gpu work complete then only cpu work 

	cpu_print();
	cpu_print();
	cpu_print();

	return 0;
}


