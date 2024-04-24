#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/update-sailors02.csv", "r");

    FILE *f2 = fopen("sailors_update.sql", "w");
    fprintf(f2, "USE week12;\n");

    int sid;
    int rating;
    
    while(!feof(f1)){
        fscanf(f1,"%d,%d\n",&sid,&rating);
        fprintf(f2,"UPDATE sailors SET rating = %d WHERE sid = %d;\n",rating,sid);
    }
}