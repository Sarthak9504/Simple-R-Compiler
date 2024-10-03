%{
#include <stdio.h>
#include <stdlib.h>

int count[2];  

void reset_count() {
    count[0]=0;
    count[1]=0;
}

void print_validity(){
    if(count[0]%2==0 && count[1]%2!=0){
        printf("Valid String contains even 'a' and odd 'b'\n");
    } else{
        printf("Invalid String\n");
    }
}

%}

%%

a { count[0]++; }

b { count[1]++; }

. { }

\n { 
    print_validity();
    reset_count();
}

%%

int main() {
    yylex();  
    return 0;
}

int yywrap() {
    return 1;
}