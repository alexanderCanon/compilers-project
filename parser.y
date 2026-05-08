%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "comandos.h"

int yylex(void);
void yyerror(const char *s);
%}

%union {
    char *string;
}

%token <string> ARCHIVO RUTA_WIN CADENA VAR_WIN VAR_UNIX
%token <string> BANDERA_CORTA BANDERA_LARGA
%token CMD_LISTAR CMD_AYUDA CMD_COPIAR CMD_MOVER CMD_BORRAR CMD_SALIR
%token CMD_CREAR CMD_ENTRAR CMD_VER CMD_LIMPIAR CMD_DONDE
%token PIPE REDIR_OUT REDIR_APPEND AND_OP OR_OP
%token LPAREN RPAREN
%token EOL
%token INVALID

%type <string> argumento lista_argumentos lista_argumentos_opt

%%

input:
    | input linea
    ;

linea:
      expresion EOL { imprimir_prompt(); }
    | EOL           { imprimir_prompt(); }
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
      CMD_LISTAR lista_argumentos_opt { ejecutar_listar($2); }
    | CMD_AYUDA lista_argumentos_opt  { ejecutar_ayuda(); }
    | CMD_SALIR lista_argumentos_opt  { ejecutar_salir(); }
    | CMD_COPIAR lista_argumentos    { ejecutar_copiar($2); }
    | CMD_MOVER lista_argumentos     { ejecutar_mover($2); }
    | CMD_BORRAR lista_argumentos    { ejecutar_borrar($2); }
    | CMD_CREAR lista_argumentos     { ejecutar_crear($2); }
    | CMD_ENTRAR lista_argumentos    { ejecutar_entrar($2); }
    | CMD_VER lista_argumentos       { ejecutar_ver($2); }
    | CMD_LIMPIAR lista_argumentos_opt { ejecutar_limpiar(); }
    | CMD_DONDE lista_argumentos_opt  { ejecutar_donde(); }
    ;

lista_argumentos_opt:
      /* vacío */ { $$ = ""; }
    | lista_argumentos { $$ = $1; }
    ;

lista_argumentos:
      argumento { $$ = $1; }
    | lista_argumentos argumento { 
        char *res = malloc(strlen($1) + strlen($2) + 2);
        sprintf(res, "%s %s", $1, $2);
        $$ = res;
    }
    ;

argumento:
      ARCHIVO       { $$ = $1; }
    | RUTA_WIN      { $$ = $1; }
    | CADENA        { $$ = $1; }
    | VAR_WIN       { $$ = $1; }
    | VAR_UNIX      { $$ = $1; }
    | BANDERA_CORTA { $$ = $1; }
    | BANDERA_LARGA { $$ = $1; }
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