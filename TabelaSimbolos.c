#include "TabelaSimbolos.h"

void ClearLista(void){
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

void inserir(char* nome, char* tipo){
    TS *novo_no = criar_no();
    novo_no->tipo = tipo;
    novo_no->nome = nome;
    novo_no->usado = 0;

    novo_no->prox = head;
    head = novo_no;
}

TS* procurar_no(char* nome){
    TS * aux = criar_no();
    aux = head;
    while(aux != NULL && (strcmp(aux->nome, nome) != 0)){
        printf("%s != %s\n" , aux->nome, nome);
        aux = aux->prox;
    }

    if (aux == NULL){
        printf("Variavel nao encontrada\n");
        return aux;
    }else{
        printf("Varivael encontrada\n");
        return aux;
    }
}

void printlista(void){
    if(head == NULL) return;
    TS* aux = criar_no();
    aux = head;
    while(aux->prox != NULL){
        printf("%s - %s  ->  " , aux->nome, aux->tipo);
        aux=aux->prox;
    };
    printf("%s - %s\n" , aux->nome, aux->tipo);
}
