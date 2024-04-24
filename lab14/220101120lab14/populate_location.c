#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("location.csv", "r");

    FILE *f2 = fopen("location_populate.sql", "w");
    fprintf(f2, "USE week14;\n");


    int location_id;
    char city[100];
    char state[100];
    char country[100];

    char header[200];

    fscanf(f1,"%s\n",header);

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%120[^,],%s\n",&location_id,city,state,country);
        fprintf(f2,"INSERT INTO location(location_id,city,state,country) VALUES(%d,'%s','%s','%s');\n",location_id,city,state,country);
    }
}