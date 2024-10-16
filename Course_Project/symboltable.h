#define TABLE_SIZE 101

#define NUMERIC_TYPE 1
#define STR_TYPE 2
#define INT_TYPE 3
#define BOOL_TYPE 4
#define ARR_TYPE 5
#define FUNC_TYPE 6

typedef union Value
{
    int int_val;
    float float_val;
    char *str_val;
} Value;

typedef struct parameters
{
    char *param;
    int type;

    Value val;
} Param;

typedef struct list_node
{
    char *identifier;
    int type;
    Value val;
    int scope;

    // for functions
    Param *param;
    int num_of_params;
    int ret_type;

    // for arrays
    int arr_size;
    Value *vals;

    struct list_node *next;
} list;

list **hash_table;

void init();
void insert(char *name, int type);
void insert_const(char *name, int type, Value val);
void insert_arr(char *name, int type, int arr_size, Value *vals);
list *lookup(char *name);
int get_symbol_type(char *name);
void hide_scope();
void incr_scope();
Param func_params(char *param_name);
int insert_func(Param *parameters, int num_params, char *func_name, int ret_type);
void check_func_call(char *func_name, Param *params, int num_params);
void print_table();