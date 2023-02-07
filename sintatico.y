/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
	#include "Semantico.h"

	#define YYDEBUG 1
	#define ac 0
	#define mp 6
	extern FILE *yyin;
	extern FILE *yyout;

	extern int yylineno;

	extern int col;

	static int emitLoc = 0 ;
	static int highEmitLoc = 0;

	static char * variavel;
	
	void yyerror(char *s);
	int yylex(void);
	void emitRO(char *op, int r, int s, int t, char *c);
	void emitRM( char * op, int r, int d, int s, char *c);
%}

%union{
	int inteiro;
	char* var;
	double pontoFlutuante;
}

%token <inteiro> INTEIRO
%token <var> IDENTIFICADOR
%token <pontoFlutuante> PONTO_FLUTUANTE
%token COMENTARIO_BLOCO
%token COMENTARIO_LINHA
%token ESCREVER
%token <var> LER
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

programa: '{' lista_cmds '}'{
							printf("\nPrograma sintaticamente correto.\n");
							verifica_semantico();
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

cmd_associacao: IDENTIFICADOR {
									// printf("%s\n", $1);
									variavel = (char*)malloc(20);
									strcpy(variavel, $1); 
								}
								DECLARACAO exp {
									// printf("variavel: %s\n",variavel);
									TS* aux = criar_no();
									aux = procurar_no(variavel);
									if(aux == NULL) {
										inserir(variavel, "inteiro", $<inteiro>4);
									}else{
										aux->valor = $<inteiro>4;
									}
								}
;

cmd_escrever: ESCREVER exp{
		emitRM("LDC",ac,$<inteiro>2,0,"load const");
		emitRO("OUT",ac,0,0,"write ac");
	}
;

cmd_ler: LER IDENTIFICADOR{
	inserir($2, "inteiro", 0);
}
;

cmd_condicao:  	IF exp THEN lista_cmds END 										 	{;}
							| IF exp THEN lista_cmds ELSE lista_cmds END     	{;}
;

cmd_repeticao: REPEAT lista_cmds UNTIL exp 											{;}
;

exp:	exp_simples	IGUAL exp_simples															{;}
		| exp_simples MENOR exp_simples															{;}
		|	exp_simples	{
				$<inteiro>$ = $<inteiro>1;
			}
;

exp_simples: 	exp_simples ADC termo {
								$<inteiro>$ = $<inteiro>1 + $<inteiro>3;
							}
						| exp_simples SUB termo	{
								$<inteiro>$ = $<inteiro>1 - $<inteiro>3;
							}
			 			| termo	{
								$<inteiro>$ = $<inteiro>1;
							}
;


termo:  termo MULT fator	{
					$<inteiro>$ = $<inteiro>1 * $<inteiro>3;
				}
			| termo DIV fator		{
					$<inteiro>$ = $<inteiro>1 / $<inteiro>3;
				}
			| fator {
					$<inteiro>$ = $<inteiro>1;
				}
;

fator: '(' exp ')' 																							{;} 
			| INTEIRO	{
					$<inteiro>$ = $1;
				}
			| IDENTIFICADOR {
					TS* aux = criar_no();
					aux = procurar_no($1);
					if(aux != NULL){
						aux->usado = 1;
						$<inteiro>$ = aux->valor;
					}
					else{
						ERRO++;
						print_erro(1);
					}

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
	//yydebug = 1;
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
	yyparse();

	print_lista();
	emitRO("HALT",0,0,0,"");

	fclose(yyin);
	fclose(yyout);
	clear_lista();


	return 0;
}
