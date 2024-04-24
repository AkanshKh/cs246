#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("boats.csv", "r");

    FILE *f2 = fopen("boats_populate.sql", "w");
    fprintf(f2, "USE week09;\n");

    int bid;
    char bname[100];
    char bcolor[100];
    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%s\n",&bid,bname,bcolor);
        fprintf(f2,"INSERT INTO boats(bid,bname,bcolor) VALUES(%d,'%s','%s');\n",bid,bname,bcolor);
    }
}