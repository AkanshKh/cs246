#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/boats01.csv", "r");

    FILE *f2 = fopen("boats01_populate.sql", "w");
    fprintf(f2, "USE week12;\n");

    int bid;
    char bname[50];
    char bcolor[50];
    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%s\n",&bid,bname,bcolor);
        fprintf(f2,"INSERT INTO boats(bid,bname,bcolor) VALUES(%d,'%s','%s');\n",bid,bname,bcolor);
    }
}