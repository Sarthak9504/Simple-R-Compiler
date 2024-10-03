%{
#include "parser.tab.h"
#include <string.h>  // Include string.h for strdup
#include <stdlib.h>  // Include stdlib.h for malloc and free
%}

%%

"int"        { return INT; }
"void"       { return VOID; }
"printf"     { return PRINTF; }
"{"          { return LBRACE; }
"}"          { return RBRACE; }
"("          { return LPAREN; }
")"          { return RPAREN; }
";"          { return SEMICOLON; }
","          { return COMMA; }
"="          { return EQ; }
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
\"[^\"]*\"   { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }
[ \t\n]+     { /* skip whitespace */ }
.            { /* catch-all for unexpected characters */ }

%%

int yywrap(void) {
    return 1;
}
