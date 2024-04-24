#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("./database/t03.csv", "r");

    FILE *f2 = fopen("task04.sql", "w");
    fprintf(f2, "USE week06;\n");
    int h,i,f;

    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d\n",&h,&i,&f);
        fprintf(f2,"INSERT INTO T03(h,i,f) VALUES(%d,%d,%d);\n",h,i,f);
    }
}