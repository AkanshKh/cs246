#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("student.csv", "r");

    FILE *f2 = fopen("task02_student.sql", "w");
    // fprintf(f2, "USE week08;\n");
    int roll;
    char name[30];
    char prog[30];
    
    while(!feof(f1)){
        fscanf(f1,"%d,%99[^,],%s",&roll,name,prog);
        fprintf(f2,"INSERT INTO student(roll_number,name,program) VALUES(%d,'%s','%s');\n",roll,name,prog);
    }
}