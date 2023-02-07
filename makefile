EXEC := a.out
TMEXEC := TM

all:
	bison -dy sintatico.y
	flex lex.l
	gcc lex.yy.c y.tab.c Semantico.h TabelaSimbolos.h TabelaSimbolos.c Semantico.c -ll
	./$(EXEC) Programa.mlp output.txt
	./$(TMEXEC) output.txt