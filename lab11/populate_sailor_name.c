#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("sailor_name.csv", "r");

    FILE *f2 = fopen("sailor_name_populate.sql", "w");
    fprintf(f2, "USE week11;\n");

    int sid;
    char sname[100];
    char header[500];
    fscanf(f1,"%s\n",header);
    
    while(!feof(f1)){
        fscanf(f1,"%d,%s\n",&sid,sname);
        fprintf(f2,"INSERT INTO sailor_name(sid,sname) VALUES(%d,'%s');\n",sid,sname);
    }
}