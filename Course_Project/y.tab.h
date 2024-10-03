
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
     DIV = 261,
     MUL = 262,
     MINUS = 263,
     PLUS = 264,
     EQ_ASSIGNMENT = 265,
     IDENTIFIER = 266,
     ASSIGNMENT = 267,
     ARRAY_KEYWORD = 268,
     COLON = 269,
     COMMA = 270,
     DIMENSION_KEYWORD = 271,
     CONCATENATE = 272,
     LEFT_PAREN = 273,
     RIGHT_PAREN = 274,
     LEFT_BRACE = 275,
     RIGHT_BRACE = 276,
     FUNCTION_KEYWORD = 277,
     RETURN_KEYWORD = 278
   };
#endif
/* Tokens.  */
#define INTEGER 258
#define NUMERIC 259
#define STRING 260
#define DIV 261
#define MUL 262
#define MINUS 263
#define PLUS 264
#define EQ_ASSIGNMENT 265
#define IDENTIFIER 266
#define ASSIGNMENT 267
#define ARRAY_KEYWORD 268
#define COLON 269
#define COMMA 270
#define DIMENSION_KEYWORD 271
#define CONCATENATE 272
#define LEFT_PAREN 273
#define RIGHT_PAREN 274
#define LEFT_BRACE 275
#define RIGHT_BRACE 276
#define FUNCTION_KEYWORD 277
#define RETURN_KEYWORD 278




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 23 "parser_R.y"

    char *identifier;
    int type;



/* Line 1676 of yacc.c  */
#line 105 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


