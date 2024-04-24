#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("reserves.csv", "r");

    FILE *f2 = fopen("reserves_populate.sql", "w");
    fprintf(f2, "USE week09;\n");

    int sid;
    int bid;
    char day[100];

    
    while(!feof(f1)){
        fscanf(f1,"%d,%d,%s\n",&sid,&bid,day);
        fprintf(f2,"INSERT INTO reserves(sid,bid,day) VALUES(%d,%d,'%s');\n",sid,bid,day);
    }
}