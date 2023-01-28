/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
	#include <stdio.h>
	#define YYDEBUG 1
	#define ac 0
	#define mp 6
	extern FILE *yyin;
	extern FILE *yyout;

	extern int yylineno;

	extern int col;

	static int emitLoc = 0 ;
	static int highEmitLoc = 0;
	
	void yyerror(char *s);
	int yylex(void);
	void emitRO(char *op, int r, int s, int t, char *c);
	void emitRM( char * op, int r, int d, int s, char *c);
%}

%union{
	int inteiro;
	char* letra;
	char* var;
	double pontoFlutuante;
}

%token <inteiro> INTEIRO
%token <var> IDENTIFICADOR
%token <pontoFlutuante> PONTO_FLUTUANTE
%token <letra> LETRA
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
        | programa '\n'											{printf ("Programa sintaticamente correto!\n");}
;

programa: '{' lista_cmds '}'{
		// printf("\nPrograma sintaticamente correto.\n");	
						;
					}
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

cmd_escrever: ESCREVER exp{
		emitRO("OUT",ac,0,0,"write ac");
	}
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


termo:  termo MULT fator 																				{;}
			| termo DIV fator																					{;}
			| fator 																									{;}
;

fator: '(' exp ')' 																							{;} 
			| INTEIRO	{
					printf("Linha: %d\n", yylineno);
					emitRM("LDC",ac,$1,0,"load const");
				}
			| IDENTIFICADOR {
					printf("%s\n", $1);
				}
			| PONTO_FLUTUANTE {
					printf("%.3lf\n", $1);
				}
;

%%

void emitRO(char *op, int r, int s, int t, char *c){ 
	fprintf(yyout,"%3d:  %5s  %d,%d,%d \n",emitLoc++,op,r,s,t);
}

void emitRM( char * op, int r, int d, int s, char *c){ 
	fprintf(yyout,"%3d:  %5s  %d,%d(%d) \n",emitLoc++,op,r,d,s);
}

void yyerror(char *s){
	printf ("Problema com a analise sintatica!\n");
	printf ("Linha: %d\n", yylineno);
	printf ("Coluna: %d\n", col);
}

int main(int argc, char** argv){

	if(argc > 0){
		yyin = fopen(argv[1],"rt");
	}else{
		yyin = stdin;    /* cria arquivo de saida se especificado */
	}

	if(argc > 1){
		yyout = fopen(argv[2],"wt");
	}else{
		yyout = stdout;
	}

	emitRM("LD",mp,0,ac,"load maxaddress from location 0");
	emitRM("ST",ac,0,ac,"clear location 0");
	yydebug = 1;
	yyparse();

	emitRO("HALT",0,0,0,"");

	fclose(yyin);
	fclose(yyout);


	return 0;
}
