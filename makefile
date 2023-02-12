EXEC := a.out
TMEXEC := TM

all:
	bison -dy sintatico.y
	flex lex.l
	gcc lex.yy.c y.tab.c TabelaSimbolos.h Semantico.h TabelaSimbolos.c Semantico.c -ll
	gcc TM.c -o TM
	./$(EXEC) Programa.mlp output.txt
	./$(TMEXEC) output.txt