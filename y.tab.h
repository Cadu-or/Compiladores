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
    LETRA = 261,                   /* LETRA  */
    COMENTARIO_BLOCO = 262,        /* COMENTARIO_BLOCO  */
    COMENTARIO_LINHA = 263,        /* COMENTARIO_LINHA  */
    ESCREVER = 264,                /* ESCREVER  */
    LER = 265,                     /* LER  */
    REPEAT = 266,                  /* REPEAT  */
    UNTIL = 267,                   /* UNTIL  */
    THEN = 268,                    /* THEN  */
    IF = 269,                      /* IF  */
    ELSE = 270,                    /* ELSE  */
    END = 271,                     /* END  */
    DECLARACAO = 272,              /* DECLARACAO  */
    MULT = 273,                    /* MULT  */
    DIV = 274,                     /* DIV  */
    ADC = 275,                     /* ADC  */
    SUB = 276,                     /* SUB  */
    MENOR = 277,                   /* MENOR  */
    IGUAL = 278,                   /* IGUAL  */
    ENDOF = 279                    /* ENDOF  */
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
#define LETRA 261
#define COMENTARIO_BLOCO 262
#define COMENTARIO_LINHA 263
#define ESCREVER 264
#define LER 265
#define REPEAT 266
#define UNTIL 267
#define THEN 268
#define IF 269
#define ELSE 270
#define END 271
#define DECLARACAO 272
#define MULT 273
#define DIV 274
#define ADC 275
#define SUB 276
#define MENOR 277
#define IGUAL 278
#define ENDOF 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 24 "sintatico.y"

	int inteiro;
	char* letra;
	char* var;
	double pontoFlutuante;

#line 122 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
