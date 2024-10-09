#define NUMERIC_TYPE 1
#define STR_TYPE 2
#define INT_TYPE 3
#define BOOL_TYPE 4
#define ARR_TYPE 5
#define FUNC_TYPE 6

#define ARITHM_OP 1
#define BOOL_OP 2
#define NOT_OP 3

int get_result_type(int type1, int type2, int op_type);
void type_error(int type_1, int type_2, int op_type);