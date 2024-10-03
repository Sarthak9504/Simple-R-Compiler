%{
/* C code to be copied verbatim */
#include <stdio.h>
%}

/* Definitions of regular expressions for tokens */
%%
[0-9]+      { printf("INTEGER: %s\n", yytext); }
"+"         { printf("PLUS: %s\n", yytext); }
"-"         { printf("MINUS: %s\n", yytext); }
"*"         { printf("MULTIPLY: %s\n", yytext); }
"/"         { printf("DIVIDE: %s\n", yytext); }
[ \t\n]+    { /* Ignore whitespace */ }
.           { printf("UNKNOWN: %s\n", yytext); }
%%

int main(int argc, char **argv)
{
    yylex();  /* Call the generated lexer */
    return 0;
}

int yywrap()
{
    return 1; /* Indicates end of input */
}
