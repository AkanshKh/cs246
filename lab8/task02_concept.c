

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("concept 1.csv", "r");

    FILE *f2 = fopen("task02_concept.sql", "w");
    // fprintf(f2, "USE week08;\n");

    char cid[10];
    char qn[10];
    char des[110];

    
    while(!feof(f1)){
        fscanf(f1,"%120[^,],%120[^,],%120[^\n]\n",cid,qn,des);
        fprintf(f2,"INSERT INTO concept(cid,qn,description) VALUES('%s','%s','%s');\n",cid,qn,des);
    }
}