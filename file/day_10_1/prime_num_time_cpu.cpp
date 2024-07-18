#include <iostream>
#include <chrono>
#define size 5000001

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



int main() {
    auto start_time = std::chrono::high_resolution_clock::now();
        for (int i = 2; i <= size; i++) {
            if (is_prime(i)) {
                // std::cout << i << "\n";
            }
        }
    auto end_time = std::chrono::high_resolution_clock::now();

        // Calculate duration
    auto duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds >(end_time - start_time).count();
    double milliseconds = duration_ns / 1000000.0; // Convert nanoseconds to milliseconds

    std::cout << "Time taken by CPU : " << milliseconds << " milliseconds" << std::endl;

        return 0;
}


//g++ -std=c++11 prime_num_time_cpu.cpp