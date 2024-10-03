%{
#include <stdio.h>
%}

%%

"//".*            { /* Do nothing; skip comments */ }
[a-z]             { printf("%c", yytext[0] - 'a' + 'A'); }  // Convert lowercase to uppercase
[A-Z]             { printf("%c", yytext[0] - 'A' + 'a'); }  // Convert uppercase to lowercase
\n                { printf("\n"); }   // Handle newlines
.                 { printf("%s", yytext); }   // Print other characters as is

%%

int main() {
    yylex();   // Call the lexer
    return 0;
}

int yywrap() {
return 1;
}
