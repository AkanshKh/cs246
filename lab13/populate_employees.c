#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("employees.csv", "r");

    FILE *f2 = fopen("employees_populate.sql", "w");
    fprintf(f2, "USE week13;\n");

    int eid;
    char ename[50];
    char dept[50];
    char salary[50];
    char gender;

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%120[^,],%120[^,],%c\n",&eid,ename,dept,salary,&gender);
        fprintf(f2,"INSERT INTO employees(eid,ename,dept,salary,gender) VALUES(%d,'%s','%s',%s,'%c');\n",eid,ename,dept,salary,gender);
    }
}
