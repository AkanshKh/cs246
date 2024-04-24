#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("t02.csv", "r");

    FILE *f2 = fopen("task03.sql", "w");
    fprintf(f2, "USE week07;\n");
    int c1,c3;
    char c2[25];

    while(!feof(f1)){
        fscanf(f1,"%d,%99[^,],%d\n",&c1,c2,&c3);
        fprintf(f2,"INSERT INTO T02(c1,c2,c3) VALUES(%d,'%s',%d);\n",c1,c2,c3);
    }
}