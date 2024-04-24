#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/update-boats02.csv", "r");

    FILE *f2 = fopen("boats_update.sql", "w");
    fprintf(f2, "USE week12;\n");

    int bid;
    char bcolor[50];
    char header[200];
    fscanf(f1,"%s\n",header);
    
    while(!feof(f1)){
        fscanf(f1,"%d,%s\n",&bid,bcolor);
        fprintf(f2,"UPDATE boats SET bcolor = '%s' WHERE bid = %d;\n",bcolor,bid);
    }
}