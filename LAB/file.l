%{
#include <stdio.h>
#include <string.h>
%}

%%
[a].*[a]\n   { printf("%s", yytext); }   
\n            {  }
.*            {  }
%%

int main()
{
    yylex();  
    return 0;
}

int yywrap()
{
    return 1;
}
