all:
	bison -d parser.y
	flex lexer.l
	gcc -o a.exe parser.tab.c lex.yy.c
	./a.exe