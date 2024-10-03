%{
#include <stdio.h>
#include <stdbool.h>

#define START 0
#define FOUND_A 1
#define FOUND_AB 2
#define FOUND_ABB 3

int state = START; 
bool is_valid = true; 

void report_result() {
    if (is_valid) {
        printf("Valid string: does not contain 'abb'\n");
    } else {
        printf("Invalid string: contains 'abb'\n");
    }
    
    state = START;
    is_valid = true;
}
%}

%%
a       {
            if(state == START){
                state = FOUND_A;
            }
        }
b       {
            if (state == FOUND_A) {
                state = FOUND_AB;
            } else if (state == FOUND_AB) {
                state = FOUND_ABB;
                is_valid = false; 
            }
        }
\n      { 
            report_result(); 
        }
[ \t]+ {  }
.       {  }
%%

int main() {
    yylex(); // Start lexing
    return 0;
}

int yywrap() {
    return 1;
}
