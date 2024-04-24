#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/insert-boats02.csv", "r");

    FILE *f2 = fopen("boats02_populate.sql", "w");
    fprintf(f2, "USE week12;\n");

    int bid;
    char bname[50];
    char bcolor[50];
    char header[200];
    fscanf(f1,"%s\n",header);
    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%s\n",&bid,bname,bcolor);
        fprintf(f2,"INSERT INTO boats(bid,bname,bcolor) VALUES(%d,'%s','%s');\n",bid,bname,bcolor);
    }
}