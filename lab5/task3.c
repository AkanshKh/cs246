#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("./database/t02.csv", "r");

    FILE *f2 = fopen("task03.sql", "w");
    fprintf(f2, "USE week06;\n");
    int f,a,b;

    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d\n",&f,&a,&b);
        fprintf(f2,"INSERT INTO T02(f,a,b) VALUES(%d,%d,%d);\n",f,a,b);
    }
}