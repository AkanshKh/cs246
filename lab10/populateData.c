#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include<mysql/mysql.h>

static char *host = "localhost";
static char *user = "root";
static char *pass = "";
static char *dbname = "week081";

unsigned int port = 3306;
static char *unix_socket = NULL;
unsigned int flag = 0;

void finish_with_error(MYSQL *conn){
    fprintf(stderr,"%s\n",mysql_error(conn));
    mysql_close(conn);
    exit(1);
} 

int main(){
    MYSQL *conn;

    conn = mysql_init(NULL); //Initialize the MySQL connection handler with mysql_init()

    if(!mysql_real_connect(conn, host, user, pass, NULL, port, unix_socket, flag)){  //Connect to the MySQL server using mysql_real_connect()
        fprintf(stderr, "\nError: %s [%d]\n", mysql_error(conn), mysql_errno(conn));
        exit(1);
    }
    if(mysql_query(conn,"USE week10;")){
        finish_with_error(conn);
    }

    FILE *f1 = fopen("student18.csv", "r");

    char name[200];
    char roll_number[50];
    
    while(!feof(f1)){
        fscanf(f1,"%200[^,],%s\n",name,roll_number);
        char query[1000];
        sprintf(query,"INSERT INTO student18(name,roll_number) VALUES('%s','%s')",name,roll_number);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }
    }
    fclose(f1);

    f1 = fopen("course18.csv","r");

    int semester;
    char cid[10];
    int l,t,p,c;

    while(!feof(f1)){
        fscanf(f1,"%d,%120[^,],%200[^,],%d,%d,%d,%d\n",&semester,cid,name,&l,&t,&p,&c);

        char query[1000];

        sprintf(query, "INSERT INTO course18(semester,cid,name,l,t,p,c) VALUES(%d,'%s','%s',%d,%d,%d,%d)",semester,cid,name,l,t,p,c);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }
    }
    fclose(f1);

    char letter_grade[10];
    f1 = fopen("grade18.csv","r");

    while(!feof(f1)){
        fscanf(f1,"%120[^,],%200[^,],%s\n",roll_number,cid,letter_grade);

        char query[1000];

        sprintf(query, "INSERT INTO grade18(roll_number,cid,letter_grade) VALUES('%s','%s','%s')",roll_number,cid,letter_grade);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }
    }
    fclose(f1);

    f1 = fopen("curriculum.csv","r");
    int number;
    char dept[10];

    while(!feof(f1)){
        fscanf(f1,"%10[^,],%d,%s\n",dept,&number,cid);

        char query[1000];

        sprintf(query, "INSERT INTO curriculum(dept,number,cid) VALUES('%s',%d,'%s')",dept,number,cid);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }
    }
    fclose(f1);




    mysql_close(conn);
    return EXIT_SUCCESS;
}