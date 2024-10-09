#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symboltable.h"

int curr_scope = 0;
int declare = 0;
int param_count;

void init()
{
    hash_table = (list **)malloc(TABLE_SIZE * sizeof(list *));
    for (int i = 0; i < TABLE_SIZE; i++)
    {
        hash_table[i] = NULL;
    }
}

int hash(char *key)
{
    int hashval = 0;
    for (; *key != '\0'; key++)
        hashval += *key;
    hashval += key[0] % 11 + (key[0] << 3) - key[0];
    return hashval % TABLE_SIZE;
}

void insert(char *name, int type)
{
    int hash_val = hash(name);
    list *node = hash_table[hash_val];

    while (node != NULL && strcmp(node->identifier, name) != 0)
    {
        node = node->next;
    }

    if (node == NULL)
    {
        node = (list *)malloc(sizeof(list));
        node->identifier = name;
        node->type = type;
        node->scope = curr_scope;

        node->next = hash_table[hash_val];
        hash_table[hash_val] = node;
    }
    else
    {
        if (node->scope == curr_scope)
        {
            printf("Variable already declared in this scope!!");
            if (node->type != type)
            {
                node->type = type;
            }
        }
        else
        {
            list *new_node = (list *)malloc(sizeof(list));
            new_node->identifier = name;
            new_node->scope = curr_scope;
            new_node->type = type;
            new_node->next = hash_table[hash_val];
            hash_table[hash_val] = new_node;
        }
    }
}

list *lookup(char *name)
{
    int hash_val = hash(name);
    list *node = hash_table[hash_val];

    while (node != NULL && strcmp(node->identifier, name) != 0)
    {
        node = node->next;
    }

    return node;
}

int get_symbol_type(char *name)
{
    list *node = lookup(name);

    if (node == NULL)
    {
        printf("Error: Variable '%s' not declared\n", name);
        exit(1);
    }

    return node->type;
}

void hide_scope()
{
    print_table();
    list *curr_node;

    for (int i = 0; i < TABLE_SIZE; i++)
    {
        curr_node = hash_table[i];
        while (curr_node != NULL && curr_node->scope == curr_scope)
        {
            list *temp = curr_node;
            curr_node = curr_node->next;
            free(temp);
        }
        hash_table[i] = curr_node;
    }

    printf("Current Scope: %d is deleted\n", curr_scope);
    curr_scope--;
}

void incr_scope()
{
    curr_scope++;
}

Param func_params(char *param_name)
{
    Param param;

    strcpy(param.param, param_name);

    return param;
}

int insert_func(Param *parameters, int num_params, char *func_name, int ret_type)
{
    list *node = lookup(func_name);

    // printf("function name: %s", node->identifier);

    if (node != NULL && node->type == FUNC_TYPE)
    {
        node->num_of_params = num_params;
        node->param = (Param *)malloc(num_params * sizeof(Param));
        node->ret_type = ret_type;
        for (int i = 0; i < num_params; i++)
        {
            node->param[i].param = (char *)malloc(strlen(parameters[i].param) + 1);
            strcpy(node->param[i].param, parameters[i].param);
        }

        return 0;
    }

    return 1;
}

void check_func_call(char *func_name, Param *params, int num_params)
{
    list *node = lookup(func_name);
    if (node == NULL)
    {
        printf("Function %s does not exist\n", func_name);
        exit(1);
    }
    if (num_params != node->num_of_params)
    {
        printf("Function call for %s does not matches the formal parameters\n", func_name);
        exit(1);
    }
    for (int i = 0; i < num_params; i++)
    {
        node->param[i].type = params[i].type;
    }
}

void print_table()
{
    printf("------------ ------ ------ ------------\n");
    printf("Name         Type   Scope   Return Type\n");
    printf("------------ ------ ------ ------------\n");

    for (int i = 0; i < TABLE_SIZE; i++)
    {
        list *node = hash_table[i];
        while (node != NULL)
        {
            if (node->type == FUNC_TYPE)
            {
                printf("%-12s %-6d %-6d %-12d\n", node->identifier, node->type, node->scope, node->ret_type);
            }
            else
            {
                printf("%-12s %-6d %-6d\n", node->identifier, node->type, node->scope);
            }

            if (node->type == FUNC_TYPE)
            {
                printf("  Parameters (%d):\n", node->num_of_params);
                for (int j = 0; j < node->num_of_params; j++)
                {
                    printf("    %-12s\n", node->param[j].param, node->param[j].type);
                }
            }

            node = node->next;
        }
    }
    printf("------------ ------ ------ ------------\n");
}
