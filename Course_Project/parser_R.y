%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>


int yylex(void);
void yyerror(const char *s);
bool is_symbol_present(char *identifier, int type);
void add_symbol(char *identifier,int type);
int get_symbol_type(char *identifier);
void allocate();
void print_symbol_table();
extern int yylineno;

#define NUMERIC_TYPE 1
#define STR_TYPE 2
#define INT_TYPE 3
#define ARR_TYPE 4
%}

%union {
    char *identifier;
    int type;
}

%token <type> INTEGER NUMERIC STRING
%left MUL DIV
%left PLUS MINUS
%left EQ_ASSIGNMENT
%token <identifier> IDENTIFIER 
%token ASSIGNMENT ARRAY_KEYWORD COLON COMMA DIMENSION_KEYWORD CONCATENATE LEFT_PAREN RIGHT_PAREN
%token LEFT_BRACE RIGHT_BRACE FUNCTION_KEYWORD RETURN_KEYWORD
%type <type> expr numeric_sequence comma_separated_numbers array_declaration 
// %token comma_separated_arguments

%start program

%%

program:
    {allocate();} statements_list
    ;

statements_list:
    | statements_list statement
    ;

statement:
    var_declaration
    | expr
    | function_definition
    ;

var_declaration:
    IDENTIFIER ASSIGNMENT expr {
        add_symbol($1, $3);
    }
    | IDENTIFIER ASSIGNMENT NUMERIC {
        printf("%s has type: 1\n", $1);
        add_symbol($1, NUMERIC_TYPE);
    }
    | IDENTIFIER ASSIGNMENT INTEGER {
        printf("%s has type: 2\n", $1);
        add_symbol($1, INT_TYPE);
    }
    | IDENTIFIER ASSIGNMENT STRING {
        printf("%s has type: 3\n", $1);
        add_symbol($1, STR_TYPE);
    }
    | array_declaration { }
    ;

expr:
    expr PLUS expr {
        int type1 = $1;
        int type2 = $3;

        if(type1 != type2){
            yyerror("type mismatch");
        } else{
            $$ = type1;
        }
    }
    | expr MINUS expr {
        int type1 = $1;
        int type2 = $3;

        if(type1 != type2){
            yyerror("type mismatch");
        } else{
            $$ = type1;
        }
    }
    | expr DIV expr {
        int type1 = $1;
        int type2 = $3;

        if(type1 != type2){
            yyerror("type mismatch");
        } else{
            $$ = type1;
        }
    }
    | expr MUL expr {
        int type1 = $1;
        int type2 = $3;

        if(type1 != type2){
            yyerror("type mismatch");
        } else{
            $$ = type1;
        }
    }
    | IDENTIFIER { $$ = get_symbol_type($1);}
    ;


array_declaration:
    IDENTIFIER ASSIGNMENT ARRAY_KEYWORD LEFT_PAREN assigning_array_elements COMMA DIMENSION_KEYWORD EQ_ASSIGNMENT CONCATENATE LEFT_PAREN comma_separated_numbers RIGHT_PAREN RIGHT_PAREN
    {
        printf("Array inititalized\n");
        add_symbol($1,ARR_TYPE);
    }
    ;

assigning_array_elements:
    CONCATENATE LEFT_PAREN comma_separated_numbers RIGHT_PAREN
    | numeric_sequence

numeric_sequence:
    NUMERIC COLON NUMERIC
    {
        // printf("from: %d, to: %d\n",$1,$3);
    }
    ;

comma_separated_numbers:
    NUMERIC { $$ = $1; }
    | comma_separated_numbers COMMA NUMERIC {  }
    ;

function_definition:
    IDENTIFIER ASSIGNMENT FUNCTION_KEYWORD LEFT_PAREN comma_separated_arguments RIGHT_PAREN LEFT_BRACE statements_list return_statement RIGHT_BRACE
    ;

return_statement:
    | RETURN_KEYWORD LEFT_PAREN IDENTIFIER RIGHT_PAREN
    ;

comma_separated_arguments:
    | IDENTIFIER { }
    | comma_separated_arguments COMMA IDENTIFIER { }
    ;
    

%%

struct symbol_table{
    char *identifier;
    int type;
};

struct symbol_table *symbol_table_entry;


int symbol_index=0;

bool is_symbol_present(char *identifier,int type){
    for(int i=0;i<symbol_index;i++){
        if(strcmp(symbol_table_entry[i].identifier,identifier)==0){
            strcpy(symbol_table_entry[symbol_index].identifier,identifier);
            symbol_table_entry[symbol_index].type = type;
            return true;
        }
    }

    return false;
}

void add_symbol(char *identifier,int type){
    // printf("here %s\n",identifier);
    printf("identifier: %s\n",identifier);

    if(!is_symbol_present(identifier,type)){
        symbol_table_entry[symbol_index].identifier = malloc(strlen(identifier) + 1);
        strcpy(symbol_table_entry[symbol_index].identifier,identifier);
        symbol_table_entry[symbol_index].type = type;


        // printf("%s\n",symbol_table_entry[symbol_index].identifier);
        symbol_index++;

    }
}

void allocate(){
    symbol_table_entry = (struct symbol_table *)malloc(100 * sizeof(struct symbol_table));
    if (!symbol_table_entry) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
}

int get_symbol_type(char *identifier){
    for(int i=0;i<symbol_index;i++){
        if(strcmp(symbol_table_entry[i].identifier,identifier)==0){
            // printf("identifier: %s,type: %d\n",identifier,symbol_table_entry[i].type);
            return symbol_table_entry[i].type;
        }
    }

    yyerror("Variable not declared");
    return -1;
}

void print_symbol_table(){
    printf("Symbol table is here: ");
    for(int i=0;i<symbol_index;i++){
        printf("Identifier: %s, type: %d\n",symbol_table_entry[i].identifier,symbol_table_entry[i].type);
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    exit(1);
}

int main(void) {
    int parser_ret = yyparse();
    print_symbol_table();

    if(parser_ret==0){
        printf("The program is correct");
    }
    return parser_ret;
}