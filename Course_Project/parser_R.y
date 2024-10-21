%{
#include "semantics.h"
#include "symboltable.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>


int yylex(void);
void yyerror(const char *s);
Param *init_param(Param *param);
void incr_param_count();
void add_arr_vals(Value val); 

extern int yylineno;
extern FILE *yyout;

Param *param;
Value *vals;

int array_size = 0;
int ret_type = -1;
int param_count = 0;
char *curr_func_name;
%}

%union {
    int type;
    char *identifier;
    Value val;
}

%token<val> INTEGER NUMERIC STRING
%right NOT
%left AND
%left OR
%left MUL DIV 
%left PLUS MINUS
%right EQ_ASSIGNMENT 
%right ASSIGNMENT
%token<identifier> IDENTIFIER
%token ASSIGNMENT ARRAY_KEYWORD COLON COMMA DIMENSION_KEYWORD CONCATENATE LEFT_PAREN RIGHT_PAREN
%token LEFT_BRACE RIGHT_BRACE FUNCTION_KEYWORD RETURN_KEYWORD
%type<type> expr numeric_sequence comma_separated_numbers array_declaration return_statement parameters ret_value
%type<node> var_declaration
// bool_expr 
// %token comma_separated_arguments

%start program

%%

program:
    { init(); param = init_param(param);} statements_list
    ;

statements_list:
    | statements_list statement
    ;

statement: 
    var_declaration
    | functions_optional
    | function_call
    // | bool_expr
    ;    

var_declaration:
    IDENTIFIER ASSIGNMENT expr {
        insert($1,$3);
    }
    | IDENTIFIER ASSIGNMENT NUMERIC {
        printf("%s has type: 1\n", $1);
        insert_const($1,NUMERIC_TYPE,$3);
    }
    | IDENTIFIER ASSIGNMENT INTEGER {
        printf("%s has type: 2\n", $1);
        insert_const($1, INT_TYPE,$3);
    }
    | IDENTIFIER ASSIGNMENT STRING {
        printf("%s has type: 3\n", $1);
        insert_const($1, STR_TYPE,$3);
    }
    | array_declaration { }
    ;

expr:
    expr PLUS expr {
        $$ = get_result_type($1,$3,ARITHM_OP);
    }
    | expr MINUS expr {
        $$ = get_result_type($1,$3,ARITHM_OP);
    }
    | expr DIV expr {
        $$ = get_result_type($1,$3,ARITHM_OP);
    }
    | expr MUL expr {
        $$ = get_result_type($1,$3,ARITHM_OP);
    }
    | IDENTIFIER { $$ = get_symbol_type($1);}
    ;

/*
bool_expr:
    expr ASSIGNMENT expr
    | bool_expr AND bool_expr {
        $$ = get_symbol_type($1, $3, BOOL_OP);
    }
    | bool_expr OR bool_expr {
        $$ = get_symbol_type($1, $3, BOOL_OP);
    }
    | NOT bool_expr {
        $$ = get_symbol_type($2, BOOL_OP);
    }
    | IDENTIFIER {
        $$ = get_symbol_type($1);
    }
    ;
*/


array_declaration:
    IDENTIFIER ASSIGNMENT ARRAY_KEYWORD LEFT_PAREN assigning_array_elements COMMA DIMENSION_KEYWORD EQ_ASSIGNMENT CONCATENATE LEFT_PAREN comma_separated_numbers RIGHT_PAREN RIGHT_PAREN
    {
        printf("Array inititalized\n");
        insert_arr($1,ARR_TYPE,array_size-1,vals);
        array_size = 0;
    }
    | IDENTIFIER ASSIGNMENT ARRAY_KEYWORD LEFT_PAREN assigning_array_elements RIGHT_PAREN
    {
        printf("Array inititalized\n");
        insert_arr($1,ARR_TYPE,array_size,vals);
        array_size = 0;
    }
    ;

assigning_array_elements:
    CONCATENATE LEFT_PAREN comma_separated_numbers RIGHT_PAREN 
    | numeric_sequence
    ;

numeric_sequence:
    NUMERIC COLON NUMERIC
    {
        for (float i = $1.float_val; i <= $3.float_val; i++) {
            // printf("%f ",i);
            Value val;
            val.float_val = i;
            add_arr_vals(val);
        }
    }
    ;

comma_separated_numbers:
    NUMERIC {
        Value val;
        val = $1;
        add_arr_vals(val); 
    }
    | comma_separated_numbers COMMA NUMERIC {
        Value val;
        val = $3;
        add_arr_vals(val);
    }
    ;

function_call: IDENTIFIER LEFT_PAREN call_params RIGHT_PAREN {
        check_func_call($1, param, param_count);
        param_count = 0;
    }
    ; 

call_params:
    parameter
    | call_params COMMA parameter
    | 
    ;

parameter:
    IDENTIFIER { param[param_count].type = get_symbol_type($1); incr_param_count(); }
    | INTEGER { param[param_count].type = INT_TYPE; incr_param_count(); }
    | NUMERIC { param[param_count].type = NUMERIC_TYPE; incr_param_count(); }
    | STRING { param[param_count].type = STR_TYPE; incr_param_count(); }
    ;

functions_optional: 
    function
    ;

function: 
    function_head function_tail {
        // printf("Current func name: %s",curr_func_name);
        insert_func(param, param_count, curr_func_name, ret_type);
        param_count = 0;
        hide_scope();
    }
    ;

function_head:
    IDENTIFIER ASSIGNMENT FUNCTION_KEYWORD LEFT_PAREN RIGHT_PAREN
    {
        insert($1, FUNC_TYPE);
        curr_func_name = $1;
        incr_scope();
    }
    | IDENTIFIER ASSIGNMENT FUNCTION_KEYWORD LEFT_PAREN parameters RIGHT_PAREN
    {
        insert($1, FUNC_TYPE);
        curr_func_name = $1;
        incr_scope();
    }
    ;

function_tail:
    LEFT_BRACE function_body RIGHT_BRACE
    ;

function_body:
    statements_list return_statement   
    ;

return_statement:
    RETURN_KEYWORD LEFT_PAREN ret_value RIGHT_PAREN { ret_type = $3; }
    | {  }
    ;

ret_value:
    IDENTIFIER { $$ = get_symbol_type($1); }
    | STRING { $$ = STR_TYPE; }
    | NUMERIC { $$ = NUMERIC_TYPE; }
    | INTEGER { $$ = INT_TYPE; }
    ;

parameters:
    IDENTIFIER { param[param_count].param = $1; param[param_count].type = -1; incr_param_count(); }
    | parameters COMMA IDENTIFIER { param[param_count].param = $3; param[param_count].type = -1; incr_param_count(); }
    ;

%%

Param *init_param(Param *param)
{
    param_count = 0;
    if(param!=NULL){
        free(param);
    }
    param = (Param *)malloc(10 * sizeof(Param));
    return param;
}

void incr_param_count()
{
    param_count++;
}

void add_arr_vals(Value val){
	if(array_size == 0){
		array_size = 1;
		vals = (Value *) malloc(1 * sizeof(Value));
		vals[0] = val;
	}
	else{
		array_size++;
		vals = (Value *) realloc(vals, array_size * sizeof(Value));
		vals[array_size - 1] = val;
	}

}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    exit(1);
}

int main(void) {
    int parser_ret = yyparse();
    print_table();

    if(parser_ret==0){
        printf("The program is correct");
    }
    return parser_ret;
}