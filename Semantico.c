#include "Semantico.h"

void verifica_semantico(){
  if(ERRO){
    printf("\nErro Semantico\n\n");
  } else {
    gera_warnings();
  }
}

void incrementaERRO(){
  ERRO++;
}

void print_erro(int error){
  switch (error){
  case 1:
    printf("Variavel utilizada mas nunca declarada.\n");
    break;
  case 2:
    printf("Divisao por 0.\n");
    break;
  default:
    break;
  }
}
