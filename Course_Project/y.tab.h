
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INTEGER = 258,
     NUMERIC = 259,
     STRING = 260,
     NOT = 261,
     AND = 262,
     OR = 263,
     DIV = 264,
     MUL = 265,
     MINUS = 266,
     PLUS = 267,
     EQ_ASSIGNMENT = 268,
     ASSIGNMENT = 269,
     IDENTIFIER = 270,
     ARRAY_KEYWORD = 271,
     COLON = 272,
     COMMA = 273,
     DIMENSION_KEYWORD = 274,
     CONCATENATE = 275,
     LEFT_PAREN = 276,
     RIGHT_PAREN = 277,
     LEFT_BRACE = 278,
     RIGHT_BRACE = 279,
     FUNCTION_KEYWORD = 280,
     RETURN_KEYWORD = 281
   };
#endif
/* Tokens.  */
#define INTEGER 258
#define NUMERIC 259
#define STRING 260
#define NOT 261
#define AND 262
#define OR 263
#define DIV 264
#define MUL 265
#define MINUS 266
#define PLUS 267
#define EQ_ASSIGNMENT 268
#define ASSIGNMENT 269
#define IDENTIFIER 270
#define ARRAY_KEYWORD 271
#define COLON 272
#define COMMA 273
#define DIMENSION_KEYWORD 274
#define CONCATENATE 275
#define LEFT_PAREN 276
#define RIGHT_PAREN 277
#define LEFT_BRACE 278
#define RIGHT_BRACE 279
#define FUNCTION_KEYWORD 280
#define RETURN_KEYWORD 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 22 "parser_R.y"

    int type;
    char *identifier;



/* Line 1676 of yacc.c  */
#line 111 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


