%{
#include <stdio.h>

int word_count = 0;
int char_count = 0;
int line_count = 0;
%}

%%
\n              { line_count++; }
[^ \n]+ { word_count++; char_count+=yyleng; }
%%

int main() {
yylex();
printf("Lines: %d\nWords: %d\nChars: %d\n", line_count, word_count, char_count);
return 0;
}

int yywrap() {
return 1;
}