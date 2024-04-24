

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("marks.csv", "r");

    FILE *f2 = fopen("task02_marks.sql", "w");
    // fprintf(f2, "USE week08;\n");

    int roll_number;
    char cid[10];
    char set1[10];
    char set2[10];
    int set1_marks;
    int set2_marks;

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%120[^,],%d,%120[^,],%d\n",&roll_number,cid,set1,&set1_marks,set2,&set2_marks);
        fprintf(f2,"INSERT INTO marks(roll_number,cid,set1,set1_marks,set2,set2_marks) VALUES(%d,'%s','%s',%d,'%s',%d);\n",roll_number,cid,set1,set1_marks,set2,set2_marks);
    }
}