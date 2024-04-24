#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_PRODUCTS 16100
// Define a structure to represent student data
struct student {
    char name[50];
    char department[20];
    int semester;
    char courses[100000000][10]; // Assuming a student can register for up to 7 courses
    int size;
};
// Define a structure to store original and modified course data
struct courseData {//this describes how the courses were earlier and how it would be after modifications
    char originalCourses[7][10];
    char modifiedCourses[7][10];
};
// Function to read the CSV file and store data in the student struct
int readCSVFile(struct student students[], int *numStudents) {
    FILE *file = fopen("students_database.csv", "r");
    if (file == NULL) {
        printf("Error in opening file!\n");
        return 0;
    }
    char line[1024];
    *numStudents = 0;
    while (fgets(line, 1024, file) && *numStudents < MAX_PRODUCTS) {
        char *token = strtok(line, ",");
        int col = 0;
        while (token != NULL) {
            if (col == 0) {
                strcpy(students[*numStudents].name, token);
            } else if (col == 1) {
                strcpy(students[*numStudents].department, token);
            } else if (col == 2) {
                students[*numStudents].semester = atoi(token);
            } else {
                students[*numStudents].size++;
                strcpy(students[*numStudents].courses[col - 3], token);
            }
            token = strtok(NULL, ",");
            col++;
        }
        (*numStudents)++;
    }
    fclose(file);
    return 1;
}
// Function to enforce constraints on course registration
void enforceConstraints(struct student students[], struct courseData courseData[], int numStudents) {
    for (int i = 0; i < numStudents; i++) {
        // Store original course data
        for (int j = 0; j < 7; j++) {
            strcpy(courseData[i].originalCourses[j], students[i].courses[j]);
        }
        if (strcmp(students[i].department, "CSE") == 0 && students[i].semester == 4) {
            int requiredCoursesCount = 7;
            char *requiredCourses[] = {"CS205", "CS207", "CS223", "CS224", "CS245", "CS246", "HSS"};
            for (int j = 0; j < requiredCoursesCount; j++) {
                int found = 0;
                for (int k = 0; k < students[i].size; k++) {
                    if (strcmp(students[i].courses[k], requiredCourses[j]) == 0) {
                        found = 1;
                        break;
                    }
                }
                if (!found && students[i].size < 7) {
                    strcpy(students[i].courses[students[i].size], requiredCourses[j]);
                    students[i].size++;
                }
            }
        }
        // Store modified course data
        for (int j = 0; j < 7; j++) {
            strcpy(courseData[i].modifiedCourses[j], students[i].courses[j]);
        }
    }
}
// Function to write original and modified data to output file
void writeOutput(struct student students[], struct courseData courseData[], int numStudents) {
    FILE *file = fopen("updated_students_database.csv", "w");
    if (file == NULL) {
        printf("Error in opening file for writing!\n");
        return;
    }
    for (int i = 0; i < numStudents; i++) {
        fprintf(file, "%s,%s,%d", students[i].name, students[i].department, students[i].semester);
        // Print original course data
        for (int j = 0; j < 7; j++) {
            fprintf(file, ",%s", courseData[i].originalCourses[j]);
        }
        // Print modified course data
        for (int j = 0; j < 7; j++) {
            fprintf(file, ",%s", courseData[i].modifiedCourses[j]);
        }
        fprintf(file, "\n");
    }
    fclose(file);
}
void printProductDetails(const char *productNumber) {
    FILE *inp = fopen("week02.csv", "r");
    FILE *out = fopen("output.csv", "r");
    char line[1024];
    int flag = 0;
    // Print product details from the original CSV file
    while (fgets(line, 1024, inp)) {
        char temp[1024];
        strcpy(temp, line);
        char *token = strtok(line, ",");
        if (strcmp(token, productNumber) == 0) {
            printf("%s", temp);
            flag = 1;
        }
    }
    // Print product details from the output CSV file
while (fgets(line, 1024, out)) {
        char temp[1024];
        strcpy(temp, line);
        char *token = strtok(line, ",");
        if (strcmp(token, productNumber) == 0) {
            printf("%s", temp);
            flag = 1;
        }
    }
    fclose(inp);
    fclose(out);
    if (!flag) {
        printf("The given product number is not found!\n");
    }
}
int main() {
    struct student students[MAX_PRODUCTS];
    struct courseData courseData[MAX_PRODUCTS];
    int numStudents = 0;
   
    if (readCSVFile(students, &numStudents)) {
        enforceConstraints(students, courseData, numStudents);
        writeOutput(students, courseData, numStudents);
        printf("Database updated successfully.\n");
    }
     while (1) {
        char s[7];
        scanf("%s", s);
        if (strcmp(s, "quit") == 0)
            break;
       
        // Print product details
        printProductDetails(s);
    }
    return 0;
}
    
    