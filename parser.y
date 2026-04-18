%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

/* Helper function to concatenate two strings dynamically */
char* concat(const char *s1, const char *s2) {
    if (!s1) s1 = "";
    if (!s2) s2 = "";
    char *res = malloc(strlen(s1) + strlen(s2) + 2);
    if (strlen(s1) > 0 && strlen(s2) > 0) {
        sprintf(res, "%s %s", s1, s2);
    } else {
        sprintf(res, "%s%s", s1, s2);
    }
    return res;
}

char* concat_op(const char *s1, const char *op, const char *s2) {
    if (!s1) s1 = "";
    if (!s2) s2 = "";
    char *res = malloc(strlen(s1) + strlen(op) + strlen(s2) + 3);
    sprintf(res, "%s %s %s", s1, op, s2);
    return res;
}
%}

%union {
    char *str;
}

%token CMD_LISTAR CMD_AYUDA CMD_COPIAR CMD_MOVER CMD_BORRAR CMD_SALIR
%token <str> ARCHIVO RUTA_WIN CADENA VAR_WIN VAR_UNIX
%token <str> BANDERA_CORTA BANDERA_LARGA
%token PIPE REDIR_OUT REDIR_APPEND AND_OP OR_OP
%token LPAREN RPAREN
%token EOL
%token INVALID

%type <str> expresion expr_or expr_and expr_pipe expr_primary comando comando_simple
%type <str> lista_argumentos_opt lista_argumentos argumento redireccion argumento_archivo

%%

input:
    | input linea
    ;

linea:
      expresion EOL          {
          printf("Ejecutando: %s\n", $1);
          system($1);
          free($1);
      }
    | CMD_SALIR EOL          {
          printf("Saliendo...\n");
          exit(0);
      }
    | CMD_SALIR lista_argumentos_opt EOL {
          printf("Saliendo...\n");
          if ($2) free($2);
          exit(0);
      }
    | EOL                    { /* Linea vacia */ }
    ;

expresion:
      expr_or                { $$ = $1; }
    ;

expr_or:
      expr_and               { $$ = $1; }
    | expr_or OR_OP expr_and {
          $$ = concat_op($1, "||", $3);
          free($1); free($3);
      }
    ;

expr_and:
      expr_pipe              { $$ = $1; }
    | expr_and AND_OP expr_pipe {
          $$ = concat_op($1, "&&", $3);
          free($1); free($3);
      }
    ;

expr_pipe:
      expr_primary           { $$ = $1; }
    | expr_pipe PIPE expr_primary {
          $$ = concat_op($1, "|", $3);
          free($1); free($3);
      }
    ;

expr_primary:
      comando                { $$ = $1; }
    | LPAREN expresion RPAREN {
          $$ = malloc(strlen($2) + 3);
          sprintf($$, "(%s)", $2);
          free($2);
      }
    ;

comando:
      comando_simple         { $$ = $1; }
    | comando_simple redireccion {
          $$ = concat($1, $2);
          free($1); free($2);
      }
    ;

comando_simple:
      CMD_LISTAR lista_argumentos_opt {
          $$ = concat("dir", $2);
          if ($2) free($2);
      }
    | CMD_AYUDA lista_argumentos_opt {
          $$ = concat("help", $2);
          if ($2) free($2);
      }
    | CMD_COPIAR lista_argumentos {
          $$ = concat("copy", $2);
          free($2);
      }
    | CMD_MOVER lista_argumentos {
          $$ = concat("move", $2);
          free($2);
      }
    | CMD_BORRAR lista_argumentos {
          $$ = concat("del", $2);
          free($2);
      }
    ;

lista_argumentos_opt:
      /* vacío */            { $$ = strdup(""); }
    | lista_argumentos       { $$ = $1; }
    ;

lista_argumentos:
      argumento              { $$ = $1; }
    | lista_argumentos argumento {
          $$ = concat($1, $2);
          free($1); free($2);
      }
    ;

argumento:
      ARCHIVO                { $$ = strdup($1); }
    | RUTA_WIN               { $$ = strdup($1); }
    | CADENA                 { $$ = strdup($1); }
    | VAR_WIN                { $$ = strdup($1); }
    | VAR_UNIX               { $$ = strdup($1); }
    | BANDERA_CORTA          { $$ = strdup($1); }
    | BANDERA_LARGA          { $$ = strdup($1); }
    ;

redireccion:
      REDIR_OUT argumento_archivo {
          $$ = concat(">", $2);
          free($2);
      }
    | REDIR_APPEND argumento_archivo {
          $$ = concat(">>", $2);
          free($2);
      }
    ;

argumento_archivo:
      ARCHIVO                { $$ = strdup($1); }
    | RUTA_WIN               { $$ = strdup($1); }
    | CADENA                 { $$ = strdup($1); }
    ;

%%

void yyerror(const char *s) {
    printf("Error de sintaxis: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
