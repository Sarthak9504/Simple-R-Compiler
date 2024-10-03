%{
#include <stdio.h>
#include <stdbool.h>

#define START 0
#define FOUND_A 1
#define FOUND_AB 2
#define FOUND_ABB 3

int state = START; 
bool valid = true; 
%}

%%
a       {
            if (state == START) {
                state = FOUND_A;
            } else if (state == FOUND_AB) {
                state = FOUND_A;
            } 
        }
b       {
            if (state == FOUND_A) {
                state = FOUND_AB;
            } else if (state == FOUND_AB) {
                state = FOUND_ABB;
            } 
        }
\n      { 
            if (state == FOUND_ABB) {
                valid = false; 
            }
            if (valid) {
                printf("Valid string: does not contain 'abb'\n");
            } else {
                printf("Invalid string: contains 'abb'\n");
            }
            state = START;
            valid = true;
        }
.       { 
            if(state == FOUND_A || state == FOUND_AB){
                state = START;
            } 
        }
%%

int main() {
    yylex(); 
    return 0;
}

int yywrap() {
    return 1;
}
