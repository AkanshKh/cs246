#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("./database/t01.csv", "r");

    FILE *f2 = fopen("task07.sql", "w");
    fprintf(f2, "USE week06;\n");
    int a,b,c,d,e;

    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d,%d,%d\n",&a,&b,&c,&d,&e);
        fprintf(f2,"INSERT INTO T01a(a,b,c,d,e) VALUES(%d,%d,%d,%d,%d);\n",a,b,c,d,e);
    }

    fclose(f1);
    fclose(f2);

    f1 = fopen("./database/t02-10.csv", "r");
    f2 = fopen("task07.sql", "a");
    
    int f;

    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d\n",&f,&a,&b);
        fprintf(f2,"INSERT INTO T02a(f,a,b) VALUES(%d,%d,%d);\n",f,a,b);
    }
}