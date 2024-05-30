// CPU version: "Bitcoin mining" type of code without the actual hash calculations 
#include <iostream>
#include <chrono>

#define TARGET_DIFFICULTY 100000000

uint32_t calculateHash(uint32_t nonce) {
    return nonce; // Simplified hash calculation
}

void mineBitcoin(uint32_t& nonce) {
    uint32_t hash;
    do {
        hash = calculateHash(nonce);
        nonce++;
    } while (hash < TARGET_DIFFICULTY);
    std::cout << "Block found! Nonce: " << nonce -1 << " , Hash: " << hash << std::endl;
}

int main() {
    uint32_t nonce = 0;
    auto start_time = std::chrono::high_resolution_clock::now();
    mineBitcoin(nonce);
    auto end_time = std::chrono::high_resolution_clock::now();
    auto duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end_time - start_time).count();
    std::cout << " Time taken by CPU :" << duration_ns << " nanoseconds" << std:: endl;
    

    // dummy 
    return 0;
}


// g++ -std=c++11 bitcoin_simulation_cpu_version.cpp