#include "semantics.h"
#include <stdio.h>
#include <stdlib.h>

int get_result_type(int type1, int type2, int op_type)
{
    switch (op_type)
    {
    case ARITHM_OP:
        if (type1 == INT_TYPE)
        {
            if (type2 == INT_TYPE)
            {
                return INT_TYPE;
            }
            else if (type2 == NUMERIC_TYPE)
            {
                return NUMERIC_TYPE;
            }
            else
            {
                type_error(type1, type2, op_type);
            }
        }
        else if (type1 == NUMERIC_TYPE)
        {
            if (type2 == INT_TYPE)
            {
                return NUMERIC_TYPE;
            }
            else if (type2 == NUMERIC_TYPE)
            {
                return NUMERIC_TYPE;
            }
            else
            {
                type_error(type1, type2, op_type);
            }
        }
        else
        {
            printf("Error: Operands of types: %d and %d not suitable for operation", type1, type2);
            exit(1);
        }
        break;

    case BOOL_OP:
        if ((type1 == INT_TYPE && type2 == INT_TYPE) || (type1 == BOOL_TYPE && type2 == BOOL_TYPE))
        {
            return BOOL_TYPE;
        }
        else
        {
            type_error(type1, type2, op_type);
        }
        break;

    case NOT_OP:
        if (type1 == INT_TYPE)
        {
            return INT_TYPE;
        }
        else
        {
            type_error(type1, type2, op_type);
        }
        break;

    default:
        printf("Error in operator selection!\n");
        exit(1);
        break;
    }
}

void type_error(int type_1, int type_2, int op_type)
{
    printf("Type conflict between %d and %d using op type %d\n", type_1, type_2, op_type);
    exit(1);
}