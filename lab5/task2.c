#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("./database/t01.csv", "r");

    FILE *f2 = fopen("task02.sql", "w");
    fprintf(f2, "USE week06;\n");
    int a,b,c,d,e;

    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d,%d,%d\n",&a,&b,&c,&d,&e);
        fprintf(f2,"INSERT INTO T01(a,b,c,d,e) VALUES(%d,%d,%d,%d,%d);\n",a,b,c,d,e);
    }
}