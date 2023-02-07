#ifndef _TABELA_SIMBOLOS_H_
#define _TABELA_SIMBOLOS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

typedef struct TabelaSimbolo{
    char* nome; // nome
    char* tipo; // tipo
    int usado; // sim ou nao
    int valor; // valor armazendo pela variavel

    struct TabelaSimbolo *prox; // ponteiro
}TS;

static TS* head;

TS* criar_no(void);

void inserir(char* nome, char* tipo, int valor);

TS* procurar_no(char* nome);

void print_lista();

void clear_lista(void);

void gera_warnings();

#endif