#include <stdio.h>
#define N 1000
int array[N];

int main() {
    for (int i = 0; i < N; i++) {
        array[i] = i + 1;
    }

    int sum = 0;

    #pragma acc parallel loop reduction(+:sum) copyin(array[0:N])
    for (int i = 0; i < N; i++)
    {
        sum += array[i];
    }

    printf("The sum of the array is: %d\n", sum);

    return 0;
    
}