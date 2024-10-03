%{
#include <stdio.h>
#include <stdbool.h>

int count = 0;
char *string = NULL; 
%}

%%

[a][^aeiou]*[e][^aeiou]*[i][^aeiou]*[o][^aeiou]*[u]* {
    count++;
    string = yytext;
}

.   {  }

\n  {  }

%%

int main() {
    yylex();  

    if (count == 1) {
        printf("The string: %s does contains the sequence 'aeiou' in order.\n",string);
    } else if(count>1){
        printf("The string contains more than one 'aeiou' sequence in order.\n");
    } else{
        printf("The string does not contains the sequence 'aeiou' in order.\n");
    }

    return 0;
}

int yywrap() {
    return 1;
}
