%{
#include <stdio.h>
%}

%%

"print"   { printf("Hello, World!\n"); exit(0);} 

%%

int main() {
    yylex(); // Start the lexer
    return 0;
}

int yywrap() {
    return 1; // Indicate end of input
}
