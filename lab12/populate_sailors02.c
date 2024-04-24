#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("database/insert-sailors02.csv", "r");

    FILE *f2 = fopen("sailors02_populate.sql", "w");
    fprintf(f2, "USE week12;\n");

    int sid;
    char sname[50];
    int rating;
    char agee[10];
    char header[200];
    fscanf(f1,"%s\n",header);
    // float age;

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%d,%s\n",&sid,sname,&rating,agee);
        fprintf(f2,"INSERT INTO sailors(sid,sname,rating,age) VALUES(%d,'%s',%d,%s);\n",sid,sname,rating,agee);
    }
}