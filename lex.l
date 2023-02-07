%option yylineno

%{
  #include <stdio.h>
  #include "y.tab.h"

  void yyeror(char *s);
  int col = 1;
%}

INTEIRO             [1-9][0-9]*|0
PONTO_FLUTUANTE     [0-9]*[.][0-9]+

COMENTARIO_BLOCO    "/*"([^*]|\*+[^*/])*\*+"/"
COMENTARIO_LINHA    "//".*

IDENTIFICADOR       ([a-zA-Z])([a-zA-Z]|[0-9]|_)*

%%


"read"                          {return LER;}
"write"                         {return ESCREVER;}

"repeat"                        {return REPEAT;}
"until"                         {return UNTIL;}

"if"                            {return IF;}
"else"                          {return ELSE;}
"then"                          {return THEN;}
"end"                           {return END;}
":="                            {return DECLARACAO;}

"+"                             {return ADC;}
"-"                             {return SUB;}

"*"                             {return MULT;}
"/"                             {return DIV;}

"="                             {return IGUAL;}
"<"                             {return MENOR;}

{INTEIRO}                       {yylval.inteiro = atoi(yytext); return INTEIRO;}

{PONTO_FLUTUANTE}               {yylval.pontoFlutuante = atof(yytext);return PONTO_FLUTUANTE;}

{COMENTARIO_BLOCO}              {yylineno++; return COMENTARIO_BLOCO;}
{COMENTARIO_LINHA}              {yylineno++; return COMENTARIO_LINHA;}

{IDENTIFICADOR}                 {yylval.var = yytext;return IDENTIFICADOR;}

[ \t\f\r]+                      {col+= yyleng;}
\n                              {yylineno++; col=1;}
.  				                      {return yytext[0];}

%%

// int main(){
//   printf("Informe um token e tecle <enter>:\n");
//   yylex();
// }

int yywrap(){

  return 1;
}
