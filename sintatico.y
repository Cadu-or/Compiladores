/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
	#include <stdio.h>
	void yyerror(char *s);
	int yylex(void);
%}

%token INTEIRO
%token IDENTIFICADOR
%token PONTO_FLUTUANTE
%token LETRA
%token COMENTARIO_BLOCO
%token COMENTARIO_LINHA
%token ESCREVER
%token LER
%token REPEAT
%token UNTIL
%token THEN
%token IF
%token ELSE
%token END
%token DECLARACAO
%token MULT DIV ADC SUB
%token MENOR IGUAL

%%

input:    /* empty */
        | input line
;

line:     '\n'
        | programa '\n'  											{printf ("Programa sintaticamente correto!\n");}
;

programa:	'{' lista_cmds '}'									{;}
;

lista_cmds:		cmd															{;}
						| cmd ';' lista_cmds							{;}
;

cmd:	cmd_associacao													{;}
		|	cmd_escrever														{;}
		| cmd_ler																	{;}
		| cmd_repeticao														{;}
		| cmd_condicao														{;}
;

cmd_associacao: IDENTIFICADOR DECLARACAO exp										{;}
;

cmd_escrever: ESCREVER exp                   	 								 	{;}
;

cmd_ler: LER IDENTIFICADOR                   										{;}
;

cmd_condicao:  	IF exp THEN lista_cmds END 										 	{;}
							| IF exp THEN lista_cmds ELSE lista_cmds END     	{;}
;

cmd_repeticao: REPEAT lista_cmds UNTIL exp 											{;}
;

exp:	exp_simples	IGUAL exp_simples															{;}
		| exp_simples MENOR exp_simples															{;}
		|	exp_simples													  										{;}
;

exp_simples: 	exp_simples ADC termo 														{;}
						| exp_simples SUB termo 														{;}
			 			| termo 																						{;}
;


termo: termo MULT fator 																				{;}
			| termo DIV fator																					{;}
			| fator 																									{;}
;

fator: '(' exp ')' 																							{;} 
			| INTEIRO 																								{;} 
			| IDENTIFICADOR 																					{;}
;

%%

void yyerror(char *s){
	printf ("Problema com a analise sintatica!\n", s);
}

int main(){
	yyparse();
	return 0;
}
