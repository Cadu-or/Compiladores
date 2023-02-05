#ifndef _TABELA_SIMBOLOS_H_
#define _TABELA_SIMBOLOS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

typedef struct TabelaSimbolo
{
    char* nome; // nome
    char* tipo; // tipo
    int usado; // sim ou nao

    struct TabelaSimbolo *prox; // ponteiro
}TS;

static TS* head = NULL;

TS* criar_no(void);

void inserir(char* nome, char* tipo);

TS* procurar_no(char* nome);

void printlista();

void ClearLista(void);

#endif