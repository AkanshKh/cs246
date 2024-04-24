#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("sale.csv", "r");

    FILE *f2 = fopen("sale_populate.sql", "w");
    fprintf(f2, "USE week14;\n");


    int sale_id;
    char sale_name[100];
    char category[100];
    int price;

    int product_id;
    int time_id;
    int location_id;
    int sales;


    char header[200];

    fscanf(f1,"%s\n",header);

    
    while(!feof(f1)){
        fscanf(f1,"%d,%d,%d,%d\n",&product_id,&time_id,&location_id,&sales);
        fprintf(f2,"INSERT INTO sale(product_id,time_id,location_id,sales) VALUES(%d,%d,%d,%d);\n",product_id,time_id,location_id,sales);
    }
}