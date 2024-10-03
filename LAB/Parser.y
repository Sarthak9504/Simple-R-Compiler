%{
#include <stdio.h>
#include <stdlib.h>

/* Declare the lexer function */
int yylex(void);
void yyerror(const char *s);
%}

%token INT VOID PRINTF
%token IDENTIFIER NUMBER
%token SEMICOLON COMMA EQ LBRACE RBRACE LPAREN RPAREN
%token STRING

%start program

%%
program:
    statements
    ;

statements:
    /* Empty */
    | statements statement
    ;

statement:
    var_declaration
    | function_declaration
    | print_statement
    ;

var_declaration:
    type IDENTIFIER EQ NUMBER SEMICOLON
    ;

function_declaration:
    VOID IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
    ;

print_statement:
    PRINTF STRING SEMICOLON
    ;

type:
    INT
    | VOID
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}