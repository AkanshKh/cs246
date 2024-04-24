#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>
#include<string.h>

typedef struct {
    int day;
    int month;
    char mon_name[4];
    int year;
} date;

date dateParser(char dateString[]){
    char months[12][4] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
    date thisDate;
    int day;
    int month;
    int year;
    char mon_name[4];
    sscanf(dateString,"%d-%3s-%d",&thisDate.day,thisDate.mon_name,&thisDate.year);

    for(int i=0;i<12;i++){
        if(strcmp(mon_name,months[i])==0){
            thisDate.month=i+1;
            break;
        }
    }
    return thisDate;
}

//compares Date1 and Date2, returns true when date1<date2;
bool dateCompare(date date1,date date2){
    if(date1.year != date2.year){
        return date1.year < date2.year;
    }
    else if(date1.month != date2.month){
        return date1.month < date2.month;
    }
    else{
        return date1.day < date2.day;
    }
}


void sortDatesIncreasing(date dateArray[],int startIndex,int endIndex){
    for(int i=0;i<endIndex-startIndex;i++){
        for(int j=startIndex; j<endIndex-i-1;j++){
            if(!dateCompare(dateArray[j],dateArray[j+1])){
                date temp = dateArray[j];
                dateArray[j] = dateArray[j+1];
                dateArray[j+1]=temp;
            }
        }
    }
}
void sortDatesDecreasing(date dateArray[],int startIndex,int endIndex){
    for(int i=0;i<endIndex-startIndex;i++){
        for(int j=startIndex; j<endIndex-i-1;j++){
            if(dateCompare(dateArray[j],dateArray[j+1])){
                date temp = dateArray[j];
                dateArray[j] = dateArray[j+1];
                dateArray[j+1]=temp;
            }
        }
    }
}



int main(){

    FILE* infile = fopen("week01.csv","r");
    FILE* outfile = fopen("week01out.csv","w");

    char s[100];

    fscanf(infile,"%s",s);
    
    fprintf(outfile,"%s",s);
    char pid[7],date1[12],date2[12],date3[12],date4[12],date5[12],date6[12],date7[12],date8[12],date9[12],date10[12],region[6];

    date forAProduct[10];

    while (fscanf(infile,"%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%[^,],%s\n",pid,date1,date2,date3,date4,date5,date6,date7,date8,date9,date10,region)!=-1){
        // printf("%s",region);
        //parse date to struct. create array of struct to store the dates.
        forAProduct[0] = dateParser(date1);
        forAProduct[1] = dateParser(date2);
        forAProduct[2] = dateParser(date3);
        forAProduct[3] = dateParser(date4);
        forAProduct[4] = dateParser(date5);
        forAProduct[5] = dateParser(date6);
        forAProduct[6] = dateParser(date7);
        forAProduct[7] = dateParser(date8);
        forAProduct[8] = dateParser(date9);
        forAProduct[9] = dateParser(date10);

        //sort as required
        if(strcmp(region,"North")==0){
            //inc
            sortDatesIncreasing(forAProduct,0,9);
        }
        else if(strcmp(region,"South")==0){
            //dec
            sortDatesDecreasing(forAProduct,0,9);
        }
        else if(strcmp(region,"East")==0){
            //inc then dec
            sortDatesIncreasing(forAProduct,0,9);
            int i;
            for(i=5;i<9;i++){
                if(forAProduct[i].year != forAProduct[i+1].year || forAProduct[i].month != forAProduct[i+1].month || forAProduct[i].day != forAProduct[i+1].day ){
                    break;
                }
            }
            sortDatesDecreasing(forAProduct,i+1,9);


        }
        else{
            //dec then inc
            sortDatesDecreasing(forAProduct,0,9);
            int i;
            for(i=5;i<9;i++){
                if(forAProduct[i].year != forAProduct[i+1].year || forAProduct[i].month != forAProduct[i+1].month || forAProduct[i].day != forAProduct[i+1].day ){
                    break;
                }
            }
            sortDatesIncreasing(forAProduct,i+1,9);
        }
        //dump to outfile
        // char sortedDateString[250];

        fprintf(outfile,"%s,",pid);
        for(int i=0;i<10;i++){
            fprintf(outfile,"%d-%s-%d,",forAProduct[i].day,forAProduct[i].mon_name,forAProduct[i].year);
        }
        fprintf(outfile,"%s\n",region);


    }

    // date somedate = dateParser("12-Dec-2004");
    // printf("%d-%s-%d",somedate.day,somedate.mon_name,somedate.year);

    fclose(outfile);
    rewind(infile);
    outfile = fopen("week01out.csv","r");
    char heheinp[30];
    fscanf(infile,"%s",heheinp);
    fscanf(outfile,"%s",heheinp);

    char line[350];

    while (true){
        printf("query(quit to exit): ");
        scanf("%s",heheinp);
        if(strcmp(heheinp,"quit")==0) break;
        //krlo khud se

    }
    
    
    return 0;
}