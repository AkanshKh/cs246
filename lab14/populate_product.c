#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("product.csv", "r");

    FILE *f2 = fopen("product_populate.sql", "w");
    fprintf(f2, "USE week14;\n");


    int product_id;
    char product_name[100];
    char category[100];
    int price;

    char header[200];

    fscanf(f1,"%s\n",header);

    
    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%120[^,],%d\n",&product_id,product_name,category,&price);
        fprintf(f2,"INSERT INTO product(product_id,product_name,category,price) VALUES(%d,'%s','%s',%d);\n",product_id,product_name,category,price);
    }
}