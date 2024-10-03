%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int digit_count[10];  // Array to keep track of digit occurrences
int repeated_digits = 0;  // Counter for digits that are repeated

void reset_digit_count() {
    for (int i = 0; i < 10; i++) {
        digit_count[i] = 0;
    }
    repeated_digits = 0;
}

void print_validity() {
    bool flag = false;
    for(int i=0;i<10;i++){
        if(digit_count[i]>2){
            flag = true;
            printf("Invalid string: One digit is repeated more that once.\n");
            break;
        }
    }

    
    if (repeated_digits > 1) {
        printf("Invalid string: More than one digit is repeated.\n");
    } else if (repeated_digits == 1 && !flag) {
        printf("Valid string: Only one digit is repeated at most once.\n");
    } else if (!flag){
        printf("Valid string: No digits are repeated.\n");
    }
}
%}

%%

[0-9] {
    int digit = yytext[0] - '0';
    digit_count[digit]++;
    if (digit_count[digit] == 2) {
        repeated_digits++;
    }
}

\n {
    print_validity();  // Print validity of the string
    reset_digit_count();  // Reset the counters for the next input
}

.   {  }

%%

int main() {
    printf("Enter strings of digits (Ctrl+D to end input):\n");
    yylex();  // Call the lexer
    return 0;
}

int yywrap() {
    return 1;
}
