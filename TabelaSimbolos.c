#include "TabelaSimbolos.h"


void clear_lista(void){
    TS* aux = criar_no();
    while(head != NULL){
        aux = head;
        head = head->prox;
        free(aux);
    }
}

TS* criar_no(){
    TS *lista = (TS*) malloc(sizeof(TS));   
    return lista;
}

TS* inserir(char* nome, char* tipo, int mem_loc){
    TS *novo_no = criar_no();
    novo_no->tipo = tipo;
    novo_no->nome = nome;
    novo_no->usado = 0;
    novo_no->mem_loc = mem_loc;

    novo_no->prox = head;
    head = novo_no;

    return novo_no;
}

TS* procurar_no(char* nome){
    TS * aux = criar_no();
    aux = head;
    while(aux != NULL && (strcmp(aux->nome, nome) != 0)){
        // printf("%s != %s\n" , aux->nome, nome);
        aux = aux->prox;
    }

    if (aux == NULL){
        // printf("Variavel nao encontrada\n");
    }else{
        // printf("Varivael encontrada\n");    
    }
    return aux;
}

void print_lista(void){
    if(head == NULL) return;
    TS* aux = criar_no();
    aux = head;
    printf("NOME \t\t TIPO \t\t ENDERECO \t\t USADO\n");
    while(aux->prox != NULL){
        printf("%s \t\t %s \t  %d \t\t\t  %d\n" , aux->nome, aux->tipo, aux->mem_loc, aux->usado);
        aux=aux->prox;
    }
    printf("%s \t\t %s \t  %d \t\t\t  %d\n" , aux->nome, aux->tipo, aux->mem_loc, aux->usado);
}


void gera_warnings(){
  TS* aux = criar_no();
  aux = head;
  if(head == NULL){
    printf("Nulo\n");
  }
  while(aux != NULL){
    if(aux->usado == 0){
      printf("WARNING!!! Variavel declarada mas nao utilizada: %s\n", aux->nome);
    }
    aux = aux->prox;
  }
}

void GetName(char* s,char* name){
    int i, size = strlen(s);

    for(i = 0;s[i] != ' ' && s[i] != ';' && s[i] != '\n' && i < size;i++){
		name[i] = s[i];
	}
}