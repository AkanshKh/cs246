
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("employee-languages.csv", "r");

    FILE *f2 = fopen("employeesLang_populate.sql", "w");
    fprintf(f2, "USE week13;\n");

    char ename[50];
    char speaks[50];
    
    while(!feof(f1)){
        fscanf(f1,"%120[^,],%s\n",ename,speaks);
        fprintf(f2,"INSERT INTO languages(ename,speaks) VALUES('%s','%s');\n",ename,speaks);
    }
}