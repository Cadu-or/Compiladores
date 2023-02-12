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
	static int locmem = 0;
	static char * variavel;
	
	void yyerror(char *s);
	int yylex(void);

	void emitRO(char *op, int r, int s, int t, char *c);
	void emitRM(char *op, int r, int d, int s, char *c);
	void emitRR(char *op, int r, int s, int t, char *c);
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

lista_cmds:		cmd	';'														{;}
						| cmd ';' lista_cmds 							{;}
;

cmd:	cmd_associacao													{;}
		|	cmd_escrever														{;}
		| cmd_ler																	{;}
		| cmd_repeticao														{;}
		| cmd_condicao														{;}
;

cmd_associacao: IDENTIFICADOR DECLARACAO exp {
									// printf("variavel: %s\n",variavel);
									variavel = (char*) malloc(20 * sizeof(char));
									GetName($1,variavel);
									printf("%s\n",variavel);
									TS* aux = criar_no();
									aux = procurar_no(variavel);
									if(aux == NULL) {
										aux = inserir(variavel, "inteiro", locmem++);	
									}
									if(!strcmp($<var>3,"const")){
										emitRM("ST", ac, aux->mem_loc, 5,"store exp in mem(0+aux->mem_loc)");
									}
									else{
										TS* aux1 = criar_no();
										aux1 = procurar_no($<var>3);
										if(aux1 != NULL)
											emitRM("ST", aux1->mem_loc,aux->mem_loc,5,"store aux1 value in mem(0+ reg(aux->mem_loc))");
										else{
											ERRO++;
											print_erro(1);
										}
									}
								}
;

cmd_escrever: ESCREVER exp{
		if(!strcmp($<var>2,"const"))
			emitRO("OUT",ac,0,0,"write ac");
		else{
			TS* aux = criar_no();
			aux = procurar_no($<var>2);
			if(aux != NULL){
				emitRO("OUT", ac,0,0,"write aux->mem_loc (ac)");
			}
			else{
				ERRO++;
				print_erro(1);
			}
		}
	}
;

cmd_ler: LER IDENTIFICADOR{
	emitRO("IN",ac,0,0,"read");
	char nome[20];
	GetName($2,nome);
	inserir(nome, "inteiro", locmem);
	emitRM("ST",ac,locmem,5,"read store");
	locmem++;
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
				$<var>$ = $<var>1;
			}
;

exp_simples: 	exp_simples ADC termo {
								TS* aux = criar_no(), *aux1 = criar_no();

								if(!strcmp($<var>1,"const") && !strcmp($<var>3,"const")){
									//emitRR("ADD", ac, $<inteiro>1,$<inteiro>3, "r = s + t");
								}

								else if(strcmp($<var>1,"const") && !strcmp($<var>3,"const")){
									if((aux = procurar_no($<var>1)) != NULL)
										emitRR("ADD", ac, aux->mem_loc, ac, "r = s + t");
								}
								
								else if(!strcmp($<var>1,"const") && strcmp($<var>3,"const")){
									if((aux = procurar_no($<var>3)) != NULL)
										emitRR("ADD", ac, ac,$<inteiro>3, "r = s + t");
								}

								else if(strcmp($<var>1,"const") && strcmp($<var>3,"const")){
									if((aux = procurar_no($<var>1)) != NULL && (aux1 = procurar_no($<var>3)) != NULL)
										emitRR("ADD", ac, aux->mem_loc,aux1->mem_loc, "r = s + t");
								}
							}
						| exp_simples SUB termo	{
								emitRR("SUB", ac,$<inteiro>1, $<inteiro>3, "r = s - t");
							}
			 			| termo	{
								$<var>$ = $<var>1;
							}
;


termo:  termo MULT fator	{
					emitRR("MUL", ac, $<inteiro>1, $<inteiro>3," r = s * t");
				}
			| termo DIV fator		{
					if($<inteiro>3 != 0)
						emitRR("DIV", ac, $<inteiro>1, $<inteiro>3,"r = s / t");
					else
						print_erro(2);
				}
			| fator {
					$<var>$ = $<var>1;
				}
;

fator: '(' exp ')' 																							{;} 
			| INTEIRO	{
					emitRM("LDC",ac,$1,0,"load const");
					$<var>$ = "const";
				}
			| IDENTIFICADOR {
					TS* aux = criar_no();
					aux = procurar_no($1);
					if(aux != NULL){
						aux->usado = 1;
						emitRM("LD", ac, aux->mem_loc,5,"load contents of aux->mem_loc in ac");
					}
					else{
						incrementaERRO();
						printf("%s - ", $1);
						print_erro(1);
					}
					char nome[20];
					GetName($1, nome);
					$<var>$ = nome;
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

void emitRR(char *op, int r, int s,int t, char *c){
	fprintf(yyout,"%3d: %5s %d,%d,%d \n", emitLoc++, op,r,s,t);
}

void yyerror(char *s){
	printf ("Problema com a analise sintatica!\n");
	printf ("Linha: %d\n", yylineno);
	printf ("Coluna: %d\n", col);
}

int main(int argc, char** argv){
	//yydebug = 1;
	printf("\n");
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
