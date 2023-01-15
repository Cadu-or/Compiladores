%{
  #include <stdio.h>
  void yyeror(char *s);
  #include "y.tab.h"
%}

INTEIRO             [+-]?[1-9][0-9]*|0
PONTO_FLUTUANTE     [+-]?[0-9]*[.][0-9]+

LETRA               [a-zA-Z]

COMENTARIO_BLOCO    "/*"([^*]|\*+[^*/])*\*+"/"
COMENTARIO_LINHA    "//".*

IDENTIFICADOR       ({LETRA})({LETRA}|[0-9]|_)*

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


{INTEIRO}                       {/*printf("[Inteiro]\n");*/ return INTEIRO;}

{PONTO_FLUTUANTE}               {return PONTO_FLUTUANTE;}

{LETRA}                         {return LETRA;}

{COMENTARIO_BLOCO}              {return COMENTARIO_BLOCO;}
{COMENTARIO_LINHA}              {return COMENTARIO_LINHA;}

{IDENTIFICADOR}                 {return IDENTIFICADOR;}

[ \t]+			                    {;}
.|\n				                    {return yytext[0];}

%%

// int main(){
//   printf("Informe um token e tecle <enter>:\n");
//   yylex();
// }

int yywrap(){
  return 1;
}
