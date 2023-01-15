EXEC := a.out

all:
	bison -dy sintatico.y
	flex lex.l
	gcc lex.yy.c y.tab.c -ll
	./$(EXEC)