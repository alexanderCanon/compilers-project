#include <stdio.h>
#include "comandos.h"

int yyparse();

int main() {
    imprimir_bienvenida();
    imprimir_prompt();
    yyparse();
    return 0;
}
