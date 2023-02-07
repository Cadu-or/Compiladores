/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INTEIRO = 258,                 /* INTEIRO  */
    IDENTIFICADOR = 259,           /* IDENTIFICADOR  */
    PONTO_FLUTUANTE = 260,         /* PONTO_FLUTUANTE  */
    COMENTARIO_BLOCO = 261,        /* COMENTARIO_BLOCO  */
    COMENTARIO_LINHA = 262,        /* COMENTARIO_LINHA  */
    ESCREVER = 263,                /* ESCREVER  */
    LER = 264,                     /* LER  */
    REPEAT = 265,                  /* REPEAT  */
    UNTIL = 266,                   /* UNTIL  */
    THEN = 267,                    /* THEN  */
    IF = 268,                      /* IF  */
    ELSE = 269,                    /* ELSE  */
    END = 270,                     /* END  */
    DECLARACAO = 271,              /* DECLARACAO  */
    MULT = 272,                    /* MULT  */
    DIV = 273,                     /* DIV  */
    ADC = 274,                     /* ADC  */
    SUB = 275,                     /* SUB  */
    MENOR = 276,                   /* MENOR  */
    IGUAL = 277                    /* IGUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define INTEIRO 258
#define IDENTIFICADOR 259
#define PONTO_FLUTUANTE 260
#define COMENTARIO_BLOCO 261
#define COMENTARIO_LINHA 262
#define ESCREVER 263
#define LER 264
#define REPEAT 265
#define UNTIL 266
#define THEN 267
#define IF 268
#define ELSE 269
#define END 270
#define DECLARACAO 271
#define MULT 272
#define DIV 273
#define ADC 274
#define SUB 275
#define MENOR 276
#define IGUAL 277

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 27 "sintatico.y"

	int inteiro;
	char* var;
	double pontoFlutuante;

#line 117 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
