// Timing code in CPU version ... 


#include <iostream>
// Add these header files at the beginning 
#include <chrono>

#define size 90000

int main() {


    int a[size], b[size], c[size];

    // Initialize arrays a and b with some values
    for (int i = 0; i < size; i++) {
        a[i] = i; // e.g. a[i] = i
        b[i] = i ;
    }

    // Just before the addition step
    // Record start time
    auto start_time = std::chrono::high_resolution_clock::now();


    // Add arrays a and b element-wise and store the result in array c
    for (int i = 0; i < size; i++) {
        c[i] = a[i] + b[i];
    }

    // Just after the addition step
    // Record end time
    auto end_time = std::chrono::high_resolution_clock::now();

   
    // Print the result array c
    for (int i = 0; i < size; i++) {
        std::cout <<"a ="<<a[i]<<" b ="<<b[i] <<" c ="<<c[i]<< "\n";
    }
    std::cout << std::endl;

    // Calculate duration
    auto duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds >(end_time - start_time).count();
    double milliseconds = duration_ns / 1000000.0; // Convert nanoseconds to milliseconds

    std::cout << "Time taken by CPU : " << milliseconds << " milliseconds" << std::endl;


    return 0;
}


//0.984825 time taken

// TO RUN CODE

// g++ -std=c++11 cputiming.cpp
// ./a.out