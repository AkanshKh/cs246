#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("sailors.csv", "r");

    FILE *f2 = fopen("sailors_1_populate.sql", "w");
    fprintf(f2, "USE week09;\n");

    int sid;
    char sname[100];
    int rating;
    char agee[10];
    // float age;

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%d,%s\n",&sid,sname,&rating,agee);
        fprintf(f2,"INSERT INTO sailors_1(sid,sname,rating,age) VALUES(%d,'%s',%d,%s);\n",sid,sname,rating,agee);
    }
}