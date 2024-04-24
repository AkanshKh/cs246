#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/delete-sailors02.csv", "r");

    FILE *f2 = fopen("sailors_delete.sql", "w");
    fprintf(f2, "USE week12;\n");

    int sid;
    
    while(!feof(f1)){
        fscanf(f1,"%d\n",&sid);
        fprintf(f2,"DELETE FROM sailors WHERE sid = %d;\n",sid);
    }
}