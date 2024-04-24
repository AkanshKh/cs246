// please check if it prints redundant terms using argc and argv
// in that case please consider the commented version


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Student{
    char name[100];
    int roll;
};

struct Course{
    char course[10];
    int credits;
    int sem;
};
struct course_grade{
    char course[10];
    char grade[3];
    int sem;
};
struct grades{
    int roll;
    struct course_grade courses[66];
};

struct dues{
    int roll;
    bool due[6];
};

struct action{
    int roll;
    bool disc;
};

struct passed{
    char type[20];
    char name[10];
    int still;
};

char semester[8][100]={"Aug 2027 - Dec 2027","Jan 2028 - Apr 2028","Aug 2028 - Dec 2028","Jan 2029 - Apr 2029","Aug 2029 - Dec 2029","Jan 2030 - Apr 2030","Aug 2030 - Dec 2030","Jan 2031 - Apr 2031"};

char due[6][100]={"Hostel","Department","NCC","COS","NSO","Institute"};

int findsem(char * str){
    for(int i=0;i<8;i++){
        if(strcmp(str,semester[i])==0){return i+1;}
    }

    return -1;
}


// bool isEligible[200]={false};
struct Student Studs[130];
struct Course courses[66];
struct grades Grade[130];
struct dues NoDue[130];
struct action Disc[130];

int stu_count;
int course_count;


void checkifEligible(int check){
    bool isEligible=true;
    struct passed passing[66];

    for(int i=0;i<stu_count;i++){
        if(Disc[i].roll==check){
            if(Disc[i].disc==0){
                break;
            }else{
                printf("-- Disciplinary requirement violation\n");
                isEligible=false;
                break;
            }
        }
    }

    for(int i=0;i<stu_count;i++){
        if(check==NoDue[i].roll){
            for(int j=0;j<6;j++){
                if(NoDue[i].due[j]==false){
                    printf("-- No dues requirement violation (%s)\n",due[j]);
                    isEligible=false;
                }
            }
            break;
        }
    }


    int totalCredits=0;
    
    int idx=0;
    for(int i=0;i<stu_count;i++){
        if(check==Grade[i].roll){
            for(int j=0;j<66;j++){
                for(int k=0;k<course_count;k++){
                    if(strcmp(courses[k].course,Grade[i].courses[j].course)==0){
                        bool passed1=true;
                        // printf("%s\n",Grade[i].courses[j].course); 
                           
                        if(strcmp(Grade[i].courses[j].grade,"NP")==0){
                            printf("SA course (%s) requirement violation\n",courses[k].course);
                            // strcpy(passing[idx].name,courses[k].course);
                            // strcpy(passing[idx].type,"SA Course");
                            passing[idx].still=1;
                            idx++;
                            passed1=false;
                        }
                        else if(strcmp(Grade[i].courses[j].grade,"FP")==0){
                            passed1=false;
                            // printf("%c\n",courses[k].course[0]);
                            if(courses[k].course[0]=='H'){
                                printf("HSS course (%s) requirement violation\n",courses[k].course);
                                // strcpy(passing[idx].name,courses[k].course);
                                // strcpy(passing[idx].type,"HSS Course");
                                passing[idx].still=1;
                                idx++;
                            }
                            else{
                                if(courses[k].sem<=4){
                                    printf("Core course (%s) requirement violation\n",courses[k].course);
                                    // strcpy(passing[idx].name,courses[k].course);
                                    // strcpy(passing[idx].type,"Core Course");
                                    passing[idx].still=1;
                                    idx++;
                                }
                                else if(courses[k].sem==5){
                                    if(strcmp(courses[k].course,"CS503")==0){
                                        printf("Elective course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Elective Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                    else{
                                        printf("Core course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Core Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                }
                                else if(courses[k].sem==6){
                                    if(courses[k].course[3]<'5'){
                                        printf("Core course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Core Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                    else{
                                        printf("Elective course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Elective Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                }
                                else if(courses[k].sem==7){
                                    if(strcmp(courses[k].course,"CS498")==0){
                                        printf("Core course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Core Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                    else{
                                        printf("Elective course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Elective Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                }
                                else if(courses[k].sem==8){
                                    if(strcmp(courses[k].course,"CS499")==0){
                                        printf("Core course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Core Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                    else{
                                        printf("Elective course (%s) requirement violation\n",courses[k].course);
                                        // strcpy(passing[idx].name,courses[k].course);
                                        // strcpy(passing[idx].type,"Elective Course");
                                        passing[idx].still=1;
                                        idx++;
                                    }
                                }
                                else{
                                    // printf("Cant recognise semester");


                                }
                            }

                        }
                        else{
                            for(int ll=0;ll<66;ll++){
                                if(strcmp(passing[ll].name,courses[k].course)==0){
                                    passing[ll].still=0;
                                    break;
                                }
                            }
                        }
                        if(passed1){totalCredits+=courses[k].credits;}
                        break;
                    }
                }
            }
            break;
        }

        
    }

    // for(int i=0;i<66;i++){
    //     if(passing[i].still==1){
    //         // printf("%s",passing[i].type);
    //         printf("-- %s (%s) requirement violation\n",passing[i].type,passing[i].name);
    //         isEligible=false;
    //     }
    // }

    // printf("%d",totalCredits);  
    if(totalCredits<315){
        printf("-- Total mandatory credits requirement violation\n");
        isEligible=false;
    }

    if(isEligible){
        printf("%d is eligible\n",check);
    }
    else{
        printf("Due to above mentioned violations %d is not eligible\n",check);
    }
}



int main(int argc, char* argv[]){
    
    FILE *f1 = fopen("students.csv", "r");

    int i=0;
    char header[100];
    fscanf(f1, "%s %s\n",header,header);
    while(!feof(f1)){
        fscanf(f1, "%99[^,],%s\n", header,Studs[i].name);
        Studs[i].roll=atoi(header);
        i++;
    }
    stu_count = i;

    i=0;
    FILE *f2 = fopen("curriculum.csv", "r");
    fscanf(f2, "%s %s\n",header,header);
    // printf("%s",header);

    while(!feof(f2)){
        fscanf(f2,"%99[^,],%d,%d\n",courses[i].course,&courses[i].credits,&courses[i].sem);
        i++;
    }
    course_count = i;


    i=0;
    FILE *f3 = fopen("grade.csv", "r");
    fscanf(f3, "%s %s %s\n",header,header,header);

    
    int roll;
    int newroll;
    fscanf(f3,"%d",&roll);
    while(!feof(f3)){
        int j=0;
        Grade[i].roll=roll;
        fscanf(f3,",%99[^,],%99[^,],%99[^\n]",Grade[i].courses[j].course,Grade[i].courses[j].grade,header);
        Grade[i].courses[j].sem=findsem(header);
        j++;
        while(true && !feof(f3)){
            fscanf(f3,"%d",&newroll);
            if(newroll!=roll){roll=newroll; break;}
            fscanf(f3,",%99[^,],%99[^,],%99[^\n]",Grade[i].courses[j].course,Grade[i].courses[j].grade,header);
            Grade[i].courses[j].sem=findsem(header);
            j++;
        }
        i++;
    }


    
    FILE *f4 = fopen("no-dues.csv", "r");

    i=0;

    fscanf(f4, "%s %s\n",header,header);
    // printf("%s",header);

    while(!feof(f4)){
        fscanf(f4,"%d,",&NoDue[i].roll);
        // printf("%d\n",NoDue[i].roll);
        
        for(int k=0;k<5;k++){
            fscanf(f4,"%99[^,],",header);

            if(strcmp(header,"Yes")==0){NoDue[i].due[k]=true;}
            else{NoDue[i].due[k]=false;}
        }
        fscanf(f4,"%99[^\n]",header);
        // printf("%s\n",header);
        if(strcmp(header,"Yes")==0){NoDue[i].due[5]=true;}
        else{NoDue[i].due[5]=false;}

        i++;
    }


    
    FILE *f5 = fopen("disciplinary.csv", "r");

    i=0;

    fscanf(f5, "%s %s %s\n",header,header,header);

    while(!feof(f5)){
        fscanf(f5,"%d,%s",&Disc[i].roll,header);
        if(strcmp(header,"Yes")==0){Disc[i].disc=true;}
        else{Disc[i].disc=false;}
        i++;    
    }

    // Instead of argc and argv please consider this as well
    // printf("Give a roll Number : ");


    // int check;
    // scanf("%d",&check);
    // checkifEligible(check);
    // printf("%d",argc);


    if(argc==1){
        for(int i=0;i<stu_count;i++){
            checkifEligible(Studs[i].roll);
        }
    }
    else{
        for(int i=1;i<argc;i++){
            int roll=atoi(argv[i]);
            // printf("%d",roll);
            checkifEligible(roll);
            // printf("%d",roll);
        }
    }

}