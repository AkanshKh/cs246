#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct {
    char name[4];
    int number;
} dict;

typedef struct {
    char day[10];
    char month[10];
    char year[10];
}date;


typedef struct {
    char prod[10];
    date step[10];
    char region[10];
}products;

dict months[] = {
    {"he",0},
    {"Jan", 1},
    {"Feb", 2},
    {"Mar", 3},
    {"Apr", 4},
    {"May", 5},
    {"Jun", 6},
    {"Jul", 7},
    {"Aug", 8},
    {"Sep", 9},
    {"Oct", 10},
    {"Nov", 11},
    {"Dec", 12}
};

int give(char name[]){
    for(int i=1;i<=12;i++){
        if(strcmp(name,months[i].name)==0){
            return i;
        }
    }
}
void swap(date *a,date *b){
    date temp=*a;
    *a=*b;
    *b=temp;
}

int checknorth(date a,date b){
    int day1=atoi(a.day);
    int day2=atoi(b.day);
    int month1=give(a.month);
    int month2=give(b.month);
    int year1=atoi(a.year);
    int year2=atoi(a.year);

    if(year1>year2){return 1;}
    if(year2>year1){return 0;}
    if(month1>month2){return 1;}
    if(month2>month1){return 0;}
    if(day1>day2){return 1;}
    if(day2>day1){return 0;}
    return 0;
}

int checksouth(date a,date b){
    int day1=atoi(a.day);
    int day2=atoi(b.day);
    int month1=give(a.month);
    int month2=give(b.month);
    int year1=atoi(a.year);
    int year2=atoi(a.year);

    if(year1>year2){return 0;}
    if(year2>year1){return 1;}
    if(month1>month2){return 0;}
    if(month2>month1){return 1;}
    if(day1>day2){return 0;}
    if(day2>day1){return 1;}
    return 0;

}

int checkall(date a,date b){
    int day1=atoi(a.day);
    int day2=atoi(b.day);
    int month1=give(a.month);
    int month2=give(b.month);
    int year1=atoi(a.year);
    int year2=atoi(a.year);

    if(day1!=day2){return 0;}
    if(month1!=month2){return 0;}
    if(year1!=year2){return 0;}
    return 1;
}

int main(){
    FILE * fp;
    fp=fopen("week02.csv","r");
    char a[10000];
    char b[1000000];
    products initials[15934];
    // products finals[15934];
    fgets(a,200,fp);
    // printf("%s",a);
    int i=0;
    while(fgets(b,200,fp)!=NULL){

        int len=strlen(b);
        int j=0;
        int k=0;
        while(b[j]!=','){
            initials[i].prod[k]=b[j];
            // finals[i].prod[k]=b[j];
            k++;
            j++;
        }
        j++;
        k=0;
        for(int p=0;p<10;p++){
            while(b[j]!='-'){
                initials[i].step[p].day[k]=b[j];
                // finals[i].step[p].day[k]=b[j];
                j++;
                k++;
            }
            j++;
            k=0;
            while(b[j]!='-'){
                initials[i].step[p].month[k]=b[j];
                // finals[i].step[p].month[k]=b[j];
                j++;
                k++;
            }   
            j++;
            k=0;
            while(b[j]!=','){
                initials[i].step[p].year[k]=b[j];
                // finals[i].step[p].year[k]=b[j];
                j++;
                k++;
            }
            j++;
            k=0;
        }
        k=0;
        while(j<len){
            initials[i].region[k]=b[j];
            // finals[i].region[k]=b[j];
            // printf("%c",initials[i].region[k]);
            j++;
            k++;
        }
        i++;
    }
    fclose(fp);

    
    for(int k=0;k<i;k++){
        // printf("%s",initials[k].region);
        if(strcmp(initials[k].region,"North\n")==0 || strcmp(initials[k].region,"East\n")==0){
            // printf("hehe\n");
            for(int l=0;l<10;l++){
                for(int r=l+1;r<10;r++){
                    if(checknorth(initials[k].step[l],initials[k].step[r])){
                        swap(&(initials[k].step[l]),&(initials[k].step[r]));
                    }
                }
            }
        }
        else if(strcmp(initials[k].region,"South\n")==0 || strcmp(initials[k].region,"West\n")==0){
            // printf("hehe\n");
            for(int l=0;l<10;l++){
                for(int r=l+1;r<10;r++){
                    if(checksouth(initials[k].step[l],initials[k].step[r])){
                        swap(&(initials[k].step[l]),&(initials[k].step[r]));
                    }
                }
            }
        }
        if(strcmp(initials[k].region,"East\n")==0){
            int l=5;
            while(checkall(initials[k].step[l],initials[k].step[4])){l++;}
            for(int st=l;st<10;st++){
                for(int r=st+1;r<10;r++){
                    if(checksouth(initials[k].step[st],initials[k].step[r])){
                        swap(&(initials[k].step[st]),&(initials[k].step[r]));
                    }
                }
            }
        }
        if(strcmp(initials[k].region,"West\n")==0){
            int l=5;
            while(checkall(initials[k].step[l],initials[k].step[4])){l++;}
            for(int st=l;st<10;st++){
                for(int r=st+1;r<10;r++){
                    if(checknorth(initials[k].step[st],initials[k].step[r])){
                        swap(&(initials[k].step[st]),&(initials[k].step[r]));
                    }
                }
            }
        }
    }
    FILE * fpp;
    fpp=fopen("week02solve.csv","w");
    fprintf(fpp,"%s",a);
    for(int k=0;k<i;k++){
        // if(strcmp(initials[k].region,"North\n")==0){
            
        // }
        // if(strcmp(initials[k].region,"South\n")==0){
        //     printf("%s : \n",initials[k].prod);
        //     for(int j=0;j<10;j++){
        //         printf("Date %s::",initials[k].step[j].day);
        //         printf("%s::",initials[k].step[j].month);
        //         printf("%s\n",initials[k].step[j].year);
        //     }
        //     printf("Region %s\n",initials[k].region);
        // }
        
        fprintf(fpp,"%s,",initials[k].prod);
        for(int j=0;j<10;j++){
            fprintf(fpp,"%s-",initials[k].step[j].day);
            fprintf(fpp,"%s-",initials[k].step[j].month);
            fprintf(fpp,"%s,",initials[k].step[j].year);
        }
        fprintf(fpp,"%s",initials[k].region);
        // fprintf(fpp,"\n");
        
    }
    fclose(fpp);
    
    char query[10];
    
    while(1){
        scanf("%s",query);
        if(strcmp(query,"quit")==0){
            
            break;
        }
        else{
            FILE * fp;
            fp=fopen("week02.csv","r");
            fgets(a,200,fp);
            char prodid[10];
            while(fgets(b,200,fp)!=NULL){
                int j=0;
                int k=0;
                while(b[j]!=','){
                    prodid[k]=b[j];
                    // finals[i].prod[k]=b[j];
                    k++;
                    j++;
                }
                // printf("hehe%s",b);
                
                if(strcmp(prodid,query)==0){
                    printf("Before: %s",b);
                    break;
                }
            }
            fclose(fp);
            for(int i=0;i<=15934;i++){
                if(strcmp(initials[i].prod,query)==0){
                    printf("After: %s,",initials[i].prod);
                    for(int j=0;j<10;j++){
                        printf("%s-",initials[i].step[j].day);
                        printf("%s-",initials[i].step[j].month);
                        printf("%s,",initials[i].step[j].year);
                    }
                    printf("%s",initials[i].region);
                    break;
                }
            }
        }
    }


}