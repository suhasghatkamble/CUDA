#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <chrono>
#include <iostream>


#define NUM_CLASSES 3

int main() {
    // Read the CSV file
    FILE *file = fopen("extracted.csv", "r");

    if (file == NULL) {
        fprintf(stderr, "Error opening file. \n");
        return 1;
    }
    printf("File opened successfully.\n");

    int *classArray;
    float *seatComfortArray;
    int numRecords = 0;

    // Count the number of records
    while (!feof(file)) {
        char buffer[256];
        fgets(buffer, sizeof(buffer), file);
        numRecords++;
    }

    printf("Number of records: %d\n", numRecords);

    // Allocate memory on CPU
    classArray = (int *)malloc(numRecords * sizeof(int));
    seatComfortArray = (float *)malloc(numRecords * sizeof(float));

    // Read the file again to populate arrays
    rewind(file);
    int i = 0;
    char line[256];
    while (fgets(line, sizeof(line), file) != NULL) {
        char *token = strtok(line, ",");
        if (strcmp(token, "Business") == 0) {
            classArray[i] = 0; // Business class
        }
        else if (strcmp(token, "Economy") == 0) {
            classArray[i] = 1; // Economy class
        }
        else if (strcmp(token, "Economy Plus") == 0) {
            classArray[i] = 2; // Economy Plus class
        }
        token = strtok(NULL, ",");
        seatComfortArray[i] = atof(token);
        i++;
    }
    fclose(file);

    // Allocate arrays for totals and counts
    float totalSeatComfort[NUM_CLASSES] = {0.0, 0.0, 0.0};
    int classCounts[NUM_CLASSES] = {0, 0, 0};

    auto start_time = std::chrono::high_resolution_clock::now();

    // Calculate total Seat_Comfort and counts for each class
    for (int i = 0; i < numRecords; i++)
    {
        int classIndex = classArray[i];
        float seatComfort = seatComfortArray[i];

        if (classIndex < NUM_CLASSES) {
            totalSeatComfort[classIndex] += seatComfort;
            classCounts[classIndex]++;
        }
    }

    auto end_time = std::chrono::high_resolution_clock::now();

    auto duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end_time - start_time).count();
    double seconds_cpu = duration_ns / 1000000000.0;

    std::cout << "Time taken by CPU: " << seconds_cpu << " seconds" << std::endl;

    // Calculate and display average Seat_Comfort for each class
    printf("Total Seat_Comfort:\n");
    printf("Business class: %.2f\n", totalSeatComfort[0]);
    printf("Economy class: %.2f\n", totalSeatComfort[1]);
    printf("Economy Plus class: %.2f\n", totalSeatComfort[2]);
    printf("Average Seat_Comfort:\n");
    if (classCounts[0] > 0)
        printf("Business class: %.2f\n", totalSeatComfort[0] / classCounts[0]);
    else
        printf("Business class: N/A\n");

    if (classCounts[1] > 0)
        printf("Economy class: %.2f\n", totalSeatComfort[1] / classCounts[1]);
    else
        printf("Economy class : N/A\n");

    if (classCounts[2] > 0)
        printf("Economy Plus class: %.2f\n", totalSeatComfort[2] / classCounts[2]);
    else
        printf("Economy Plus class: N/A\n");

    // Free memory
    free(classArray);
    free(seatComfortArray);
    return 0;

    
}