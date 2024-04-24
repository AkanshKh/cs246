#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("students-marks.csv", "r");

    FILE *f2 = fopen("students_populate.sql", "w");
    fprintf(f2, "USE week13;\n");

    int sid;
    char sname[50];
    int marks;

    char dept[50];
    char gender[10];

    char header[200];
    fscanf(f1,"%s\n",header);


    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%d,%120[^,],%s\n",&sid,sname,&marks,gender,dept);
        fprintf(f2,"INSERT INTO students(sid,sname,marks,gender,department) VALUES(%d,'%s',%d,'%s','%s');\n",sid,sname,marks,gender,dept);
    }
}
