

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("course.csv", "r");

    FILE *f2 = fopen("task02_course.sql", "w");
    // fprintf(f2, "USE week08;\n");
    char id[10];

    char name[120];

    
    while(!feof(f1)){
        fscanf(f1,"%120[^,],%120[^\n]\n",id,name);
        fprintf(f2,"INSERT INTO course(cid,cname) VALUES('%s','%s');\n",id,name);
    }
}