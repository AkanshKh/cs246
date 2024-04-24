#include<stdio.h>
#include<stdlib.h>
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

void compute_spi(MYSQL *conn, int roll){
    for(int i=0;i<9;i++){
        char query[2000];
        sprintf(query,"with dataTable AS(SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN 'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds,sum(cou.c) as total FROM grade18 g JOIN course18 cou on g.cid = cou.cid WHERE cou.semester = '%d' AND roll_number = '%d')SELECT creds/total FROM dataTable;",i+1,roll);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }

        MYSQL_RES *spi;
        MYSQL_ROW row;

        spi = mysql_store_result(conn);

        if(spi == NULL){
            finish_with_error(conn);
        }


        int num_fields = mysql_num_fields(spi);

        while(row = mysql_fetch_row(spi)){
            for(int i = 0; i < num_fields; i++){
                if(row[i]){
                    float spi = atof(row[i]);
                    printf("%0.2f ",spi);
                }
            }

        printf("\n");
        }
        mysql_free_result(spi);
    }
}


void compute_cpi(MYSQL *conn, int roll){
    for(int i=0;i<9;i++){
        char query[2000];
        sprintf(query,"with dataTable AS(SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN 'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds,sum(cou.c) as total FROM grade18 g JOIN course18 cou on g.cid = cou.cid WHERE cou.semester <= '%d' AND roll_number = '%d')SELECT creds/total FROM dataTable;",i+1,roll);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }

        MYSQL_RES *cpi;
        MYSQL_ROW row;

        cpi = mysql_store_result(conn);

        if(cpi == NULL){
            finish_with_error(conn);
        }


        int num_fields = mysql_num_fields(cpi);

        while(row = mysql_fetch_row(cpi)){
            for(int i = 0; i < num_fields; i++){
                if(row[i]){
                    float cpi = atof(row[i]);
                    printf("%0.2f ",cpi);
                }
            }

        printf("\n");
        }
        mysql_free_result(cpi);
    }
}

void compute(MYSQL *conn){
    for(int i=1;i<=8;i++){
        char query[1000];
        sprintf(query,"SELECT roll_number from student18\WHERE ((SELECT count(curriculum.cid) FROM curriculum WHERE curriculum.cid LIKE 'OE%' AND number = %d) = (SELECT COUNT(grade18.cid) from grade18 INNER JOIN curriculum ON grade18.cid=curriculum.cid WHERE grade18.roll_number = student18.roll_number AND grade18.cid='OE%' and number=%d))",i+1,i+1);

        if(mysql_query(conn,query)){
            finish_with_error(conn);
        }

        MYSQL_RES *res;
        MYSQL_ROW row;

        int num_fields = mysql_num_fields(res);

        while(row = mysql_fetch_row(res)){
            for(int i = 0; i < num_fields; i++){
                printf("%s ", row[i] ? row[i] : "NULL");
            }

            printf("\n");
        }
        mysql_free_result(res);
    }
    
}

int main(){
    MYSQL *conn;

    conn = mysql_init(NULL); //Initialize the MySQL connection handler with mysql_init()

    if(!mysql_real_connect(conn, host, user, pass, NULL, port, unix_socket, flag)){  //Connect to the MySQL server using mysql_real_connect()
        fprintf(stderr, "\nError: %s [%d]\n", mysql_error(conn), mysql_errno(conn));
        exit(1);
    }

    if(mysql_query(conn,"CREATE DATABASE IF NOT EXISTS week10")){
        finish_with_error(conn);
    }
    if(mysql_query(conn,"USE week10;")){
        finish_with_error(conn);
    }


    if(mysql_query(conn,"CREATE TABLE IF NOT EXISTS student18(name CHAR(100),roll_number CHAR(10) PRIMARY KEY);")){
        finish_with_error(conn);
    }
    if(mysql_query(conn,"CREATE TABLE IF NOT EXISTS course18(semester INT,cid CHAR(7) PRIMARY KEY,name CHAR(100),l INT,t INT,p INT,c INT);")){
        finish_with_error(conn);
    }
    if(mysql_query(conn,"CREATE TABLE IF NOT EXISTS grade18(roll_number CHAR(10),cid CHAR(7),letter_grade CHAR(2),PRIMARY KEY(roll_number,cid));")){
        finish_with_error(conn);
    }
    if(mysql_query(conn,"CREATE TABLE IF NOT EXISTS curriculum(dept CHAR(3),number INT,cid CHAR(7));")){
        finish_with_error(conn);
    }


    MYSQL_RES *student_res_set;
    MYSQL_ROW row;

    if(mysql_query(conn,"SELECT * FROM student18")){
        finish_with_error(conn);
    }

    student_res_set = mysql_store_result(conn);

    if(student_res_set == NULL){
        finish_with_error(conn);
    }

    int num_fields = mysql_num_fields(student_res_set);

    while(row = mysql_fetch_row(student_res_set)){
        for(int i = 0; i < num_fields; i++){
            printf("%s ", row[i] ? row[i] : "NULL");
        }

      printf("\n");
    }
    mysql_free_result(student_res_set);


    if(mysql_query(conn,"SELECT * FROM course18")){
        finish_with_error(conn);
    }

    student_res_set = mysql_store_result(conn);

    if(student_res_set == NULL){
        finish_with_error(conn);
    }

    int num_fields = mysql_num_fields(student_res_set);

    while(row = mysql_fetch_row(student_res_set)){
        for(int i = 0; i < num_fields; i++){
            printf("%s ", row[i] ? row[i] : "NULL");
        }

      printf("\n");
    }
    mysql_free_result(student_res_set);


    if(mysql_query(conn,"SELECT * FROM grade18")){
        finish_with_error(conn);
    }

    student_res_set = mysql_store_result(conn);

    if(student_res_set == NULL){
        finish_with_error(conn);
    }

    int num_fields = mysql_num_fields(student_res_set);

    while(row = mysql_fetch_row(student_res_set)){
        for(int i = 0; i < num_fields; i++){
            printf("%s ", row[i] ? row[i] : "NULL");
        }

      printf("\n");
    }
    mysql_free_result(student_res_set);
    if(mysql_query(conn,"SELECT * FROM curriculum")){
        finish_with_error(conn);
    }

    student_res_set = mysql_store_result(conn);

    if(student_res_set == NULL){
        finish_with_error(conn);
    }

    int num_fields = mysql_num_fields(student_res_set);

    while(row = mysql_fetch_row(student_res_set)){
        for(int i = 0; i < num_fields; i++){
            printf("%s ", row[i] ? row[i] : "NULL");
        }

      printf("\n");
    }
    mysql_free_result(student_res_set);

    // compute_cpi(conn,180123065);
    // printf("\n");
    // compute_spi(conn,180123065);





    mysql_close(conn);
    return EXIT_SUCCESS;
}