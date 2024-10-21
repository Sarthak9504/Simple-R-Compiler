%{

#include "symboltable.h"
#include "y.tab.h"
#include <string.h>

%}

%option yylineno

%%

[ \n\t]+                   { }                               
"#".*                        { }
"array"                    { printf("ARRAY_KEYWORD\n"); return ARRAY_KEYWORD; }
"dim"                      { printf("DIMENSION_KEYWORD\n"); return DIMENSION_KEYWORD; }
"function"                 { printf("FUNCTION_KEYWORD\n"); return FUNCTION_KEYWORD; }
"return"                   { printf("RETURN_KEYWORD\n"); return RETURN_KEYWORD; }
"c"                        { printf("CONCATENATE\n"); return CONCATENATE; }
"="                        { printf("EQ_ASSIGNMENT\n"); return EQ_ASSIGNMENT; }
"("                        { printf("LEFT_PAREN\n"); return LEFT_PAREN; }
")"                        { printf("RIGHT_PAREN\n"); return RIGHT_PAREN; }
"{"                        { printf("LEFT_BRACE\n"); return LEFT_BRACE; }
"}"                        { printf("RIGHT_BRACE\n"); return RIGHT_BRACE; }
":"                        { printf("COLON\n"); return COLON; }
","                        { printf("COMMA\n"); return COMMA; }
"<-"                       { printf("ASSIGNMENT\n"); return ASSIGNMENT; }
"+"                        { printf("PLUS\n"); return PLUS; }
"-"                        { printf("MINUS\n"); return MINUS; }
"/"                        { printf("DIV\n"); return DIV; }
"*"                        { printf("MUL\n"); return MUL; }
"&&"                       { printf("MUL\n"); return AND; }
"||"                       { printf("MUL\n"); return OR; }
"!"                        { printf("MUL\n"); return NOT; }
[+-]?([0-9]+L)             { yylval.val.int_val = atoi(yytext); printf("INTEGER\n"); return INTEGER; }
[a-zA-Z_][a-zA-Z0-9_]*     { yylval.identifier = strdup(yytext); return IDENTIFIER; }
[+-]?([0-9]+[.])?[0-9]+    { yylval.val.float_val = atof(yytext); return NUMERIC;}
["]([^"]|\\(.|\n))*["]     { yylval.val.str_val = malloc(yyleng * sizeof(char));
				             strcpy(yylval.val.str_val, yytext); return STRING; }
.                          {printf("Unknown symbol"); exit(0); }

%%

int yywrap() {
    return 1;
}