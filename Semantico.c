#include "Semantico.h"

void verifica_semantico(){
  if(ERRO){
    printf("\n Erro Semantico");
  } else {
    gera_warnings();
  }
}

// void gera_warnings(){
//   TS* aux = criar_no();
//   aux = head;
//   if(head == NULL){
//     printf("Nulo\n");
//   }
//   while(aux != NULL){
//     printf("%d", aux->usado);
//     if(aux->usado == 0){
//       printf("Variavel declarada mas nao utilizada: %s\n", aux->nome);
//     }
//     aux = aux->prox;
//   }
// }

void print_erro(int error){
  switch (error){
  case 1:
    printf("Variavel utilizada mas nunca declarada.");
    break;
  default:
    break;
  }
}
