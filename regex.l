%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

DIGIT       [0-9]
LETTER      [a-zA-Z]
ALNUM_GUION     [a-zA-Z0-9_.] 
LISTAR          listar
SALIR           salir
COPIAR          copiar
MOVER           mover
BORRAR          borrar
AYUDA           ayuda

ARCHIVO         [a-zA-Z0-9_]+\.[a-zA-Z0-9]+
RUTA_WIN        [A-Za-z]:"\\"[A-Za-z0-9_\\.-]+
BANDERA_CORTA   -[a-zA-Z]
BANDERA_LARGA   --[a-zA-Z]+
CADENA          \"[^\"]+\"
VAR_WIN         %[a-zA-Z_][a-zA-Z0-9_]*%
VAR_UNIX        \$[a-zA-Z_][a-zA-Z0-9_]*



IMPRIMIR        imprimir
SI              si
MIENTRAS        mientras
PARA            para

PIPE            "|"
REDIR_OUT       ">"
REDIR_APPEND    ">>"
AND_OP          "&&"
OR_OP           "||"
LPAREN          "("
RPAREN          ")"


SPACE           [ ]
ENTER          \n
ALL           .

%%
           
{LISTAR}        { return CMD_LISTAR; }
{SALIR}         { return CMD_SALIR; }
{COPIAR}        { return CMD_COPIAR; }
{MOVER}         { return CMD_MOVER; }
{BORRAR}        { return CMD_BORRAR; }
{AYUDA}         { return CMD_AYUDA; }

{REDIR_APPEND}  { return REDIR_APPEND; }
{AND_OP}        { return AND_OP; }
{OR_OP}         { return OR_OP; }
{PIPE}          { return PIPE; }
{REDIR_OUT}     { return REDIR_OUT; }

{LPAREN}        { return LPAREN; }
{RPAREN}        { return RPAREN; }

{BANDERA_LARGA} { return BANDERA_LARGA; }
{BANDERA_CORTA} { return BANDERA_CORTA; }

{RUTA_WIN}      { return RUTA_WIN; }
{ARCHIVO}       { return ARCHIVO; }
{CADENA}        { return CADENA; }
{VAR_WIN}       { return VAR_WIN; }
{VAR_UNIX}      { return VAR_UNIX; }

{SPACE}+        { /* Ignorar espacios */ }
{ENTER}         { return EOL; }
{ALL}           { return INVALID; }

%%

/* int main(int argc, char **argv)
{
    yylex();
    return 0;
} */

