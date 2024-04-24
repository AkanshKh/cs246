#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/reserves01.csv", "r");

    FILE *f2 = fopen("reserves01_populate.sql", "w");
    fprintf(f2, "USE week12;\n");

    int sid;
    int bid;
    char day[50];

    
    while(!feof(f1)){
        fscanf(f1,"%d,%d,%s\n",&sid,&bid,day);
        fprintf(f2,"INSERT INTO reserves(sid,bid,day) VALUES(%d,%d,'%s');\n",sid,bid,day);
    }
}