#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/delete-boats02.csv", "r");

    FILE *f2 = fopen("boats_delete.sql", "w");
    fprintf(f2, "USE week12;\n");

    int bid;
    
    while(!feof(f1)){
        fscanf(f1,"%d\n",&bid);
        fprintf(f2,"DELETE FROM boats WHERE bid = %d;\n",bid);
    }
}