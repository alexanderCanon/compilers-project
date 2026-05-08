%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

DIGITO       [0-9]
LETRA      [a-zA-Z]
ALNUM_GUION     [a-zA-Z0-9_.] 
LISTAR          listar
SALIR           (salir|quitar)
COPIAR          copiar
MOVER           mover
BORRAR          borrar
AYUDA           ayuda

ARCHIVO         ([a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*|\.|\.\.)
RUTA_WIN        [A-Za-z]:[\\/][A-Za-z0-9_\\.\/-]*
BANDERA_CORTA   -[a-zA-Z]+
BANDERA_LARGA   --[a-zA-Z]+
CADENA          \"[^\"]*\"
VAR_WIN         %[a-zA-Z_][a-zA-Z0-9_]*%
VAR_UNIX        \$[a-zA-Z_][a-zA-Z0-9_]*



IMPRIMIR        imprimir
SI              si
MIENTRAS        mientras
PARA            para
CREAR           crear
ENTRAR          entrar
VER             ver
LIMPIAR         limpiar
DONDE           donde

PIPE            "|"
REDIR_OUT       ">"
REDIR_APPEND    ">>"
AND_OP          "&&"
OR_OP           "||"
LPAREN          "("
RPAREN          ")"


ESPACIO           [ ]
ENTRADA          \n
TODO           .

%%
           
{LISTAR}        { return CMD_LISTAR; }
{SALIR}         { return CMD_SALIR; }
{COPIAR}        { return CMD_COPIAR; }
{MOVER}         { return CMD_MOVER; }
{BORRAR}        { return CMD_BORRAR; }
{AYUDA}         { return CMD_AYUDA; }
{CREAR}         { return CMD_CREAR; }
{ENTRAR}        { return CMD_ENTRAR; }
{VER}           { return CMD_VER; }
{LIMPIAR}       { return CMD_LIMPIAR; }
{DONDE}         { return CMD_DONDE; }

{REDIR_APPEND}  { return REDIR_APPEND; }
{AND_OP}        { return AND_OP; }
{OR_OP}         { return OR_OP; }
{PIPE}          { return PIPE; }
{REDIR_OUT}     { return REDIR_OUT; }

{LPAREN}        { return LPAREN; }
{RPAREN}        { return RPAREN; }

{BANDERA_LARGA} { yylval.string = strdup(yytext); return BANDERA_LARGA; }
{BANDERA_CORTA} { yylval.string = strdup(yytext); return BANDERA_CORTA; }

{RUTA_WIN}      { yylval.string = strdup(yytext); return RUTA_WIN; }
{ARCHIVO}       { yylval.string = strdup(yytext); return ARCHIVO; }
{CADENA}        { yylval.string = strdup(yytext); return CADENA; }
{VAR_WIN}       { yylval.string = strdup(yytext); return VAR_WIN; }
{VAR_UNIX}      { yylval.string = strdup(yytext); return VAR_UNIX; }

{ESPACIO}+        { /* Ignorar espacios */ }
{ENTRADA}         { return EOL; }
{TODO}           { return INVALID; }

%%

/* int main(int argc, char **argv)
{
    yylex();
    return 0;
} */

