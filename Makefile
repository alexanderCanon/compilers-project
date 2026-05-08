all:
	bison -d parser.y
	flex regex.l
	gcc parser.tab.c lex.yy.c comandos.c main.c -o shell.exe

clean:
	rm -rf shell.exe
	rm -rf parser.tab.c lex.yy.c
	rm -rf lex.yy.c