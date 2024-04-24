#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("boat_name.csv", "r");

    FILE *f2 = fopen("boat_name_populate.sql", "w");
    fprintf(f2, "USE week11;\n");

    int sno;
    char bname[100];
    char header[500];
    fscanf(f1,"%s\n",header);
    
    while(!feof(f1)){
        fscanf(f1,"%d,%s\n",&sno,bname);
        fprintf(f2,"INSERT INTO boat_name(sno,bname) VALUES(%d,'%s');\n",sno,bname);
    }
}