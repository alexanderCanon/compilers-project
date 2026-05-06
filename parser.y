%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token CMD_LISTAR CMD_AYUDA CMD_COPIAR CMD_MOVER CMD_BORRAR CMD_SALIR
%token ARCHIVO RUTA_WIN CADENA VAR_WIN VAR_UNIX
%token BANDERA_CORTA BANDERA_LARGA
%token PIPE REDIR_OUT REDIR_APPEND AND_OP OR_OP
%token LPAREN RPAREN
%token EOL
%token INVALID

%%

input:
    | input linea
    ;

linea:
      expresion EOL          { printf("Linea valida\n"); }
    | EOL                    { printf("Linea vacia\n"); }
    ;

expresion:
      expr_or
    ;

expr_or:
      expr_and
    | expr_or OR_OP expr_and
    ;

expr_and:
      expr_pipe
    | expr_and AND_OP expr_pipe
    ;

expr_pipe:
      expr_primary
    | expr_pipe PIPE expr_primary
    ;

expr_primary:
      comando
    | LPAREN expresion RPAREN
    ;

comando:
      comando_simple
    | comando_simple redireccion
    ;

comando_simple:
      CMD_LISTAR lista_argumentos_opt
    | CMD_AYUDA lista_argumentos_opt
    | CMD_SALIR lista_argumentos_opt
    | CMD_COPIAR lista_argumentos
    | CMD_MOVER lista_argumentos
    | CMD_BORRAR lista_argumentos
    ;

lista_argumentos_opt:
      /* vacío */
    | lista_argumentos
    ;

lista_argumentos:
      argumento
    | lista_argumentos argumento
    ;

argumento:
      ARCHIVO
    | RUTA_WIN
    | CADENA
    | VAR_WIN
    | VAR_UNIX
    | BANDERA_CORTA
    | BANDERA_LARGA
    ;

redireccion:
      REDIR_OUT argumento_archivo
    | REDIR_APPEND argumento_archivo
    ;

argumento_archivo:
      ARCHIVO
    | RUTA_WIN
    | CADENA
    ;

%%

void yyerror(const char *s) {
    printf("Error de sintaxis: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}