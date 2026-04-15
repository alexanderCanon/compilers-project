all:
	bison -d parser.y
	flex regex.l
	gcc parser.tab.c lex.yy.c -o shell.exe