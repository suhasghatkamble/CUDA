#include <iostream>

#include <chrono>





#define size 100001

auto start_time = std::chrono::high_resolution_clock::now();


bool is_prime(int num) {
    if (num < 2) {
        return false;
    }
    for (int i = 2; i < num; i++) {
        if (num % i == 0) {
            return false;
        }
    }
    return true;
}

auto end_time = std::chrono::high_resolution_clock::now();


int main() {
    for (int i = 2; i <= size; i++) {
        if (is_prime(i)) {
            std::cout << i << "\n";
        }
    }
    std::cout << std::endl;




    // Calculate duration
auto duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds >(end_time - start_time).count();
double milliseconds = duration_ns / 1000000.0; // Convert nanoseconds to milliseconds

std::cout << "Time taken by CPU : " << milliseconds << " milliseconds" << std::endl;



    return 0;
}


//0.001403 time taken