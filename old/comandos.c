#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "comandos.h"

#define COLOR_RESET  "\033[0m"
#define COLOR_BOLD   "\033[1m"
#define COLOR_CYAN   "\033[36m"
#define COLOR_PURPLE "\033[35m"
#define COLOR_BLUE   "\033[34m"

void imprimir_bienvenida() {
    printf(COLOR_CYAN COLOR_BOLD "\n");
    printf("   ┌───────────────────────────────────────────┐\n");
    printf("   │                                           │\n");
    printf("   │      ALEXER COMMAND INTERFACE v1.0        │\n");
    printf("   │      Compiladora en Español GT SI         │\n");
    printf("   │                                           │\n");
    printf("   └───────────────────────────────────────────┘\n");
    printf(COLOR_RESET "\n");
}

void imprimir_prompt() {
    char cwd[256];
    getcwd(cwd, sizeof(cwd));
    printf(COLOR_PURPLE "✦ " COLOR_RESET COLOR_BOLD "Alexer " COLOR_CYAN "%s" COLOR_RESET " › ", cwd);
    fflush(stdout);
}

void ejecutar_listar(char *args) {
    char cmd[512];
    printf(COLOR_BLUE "Listing files...\n" COLOR_RESET);
    sprintf(cmd, "ls --color=always %s", args);
    system(cmd);
}

void ejecutar_ayuda() {
    printf(COLOR_CYAN COLOR_BOLD "\nAvailable Commands:\n" COLOR_RESET);
    printf("  %-10s %s\n", "listar", "Muestra archivos en el directorio");
    printf("  %-10s %s\n", "copiar", "Copia archivos (origen destino)");
    printf("  %-10s %s\n", "mover", "Mueve o renombra archivos");
    printf("  %-10s %s\n", "borrar", "Elimina archivos o carpetas");
    printf("  %-10s %s\n", "crear", "Crea una nueva carpeta");
    printf("  %-10s %s\n", "ver", "Muestra el contenido de un archivo");
    printf("  %-10s %s\n", "limpiar", "Limpia la consola");
    printf("  %-10s %s\n", "donde", "Muestra la ruta actual");
    printf("  %-10s %s\n", "salir", "Cierra la sesión");
    printf("\n");
}

void ejecutar_salir() {
    printf(COLOR_PURPLE "Saliendo del sistema. ¡Hasta pronto!\n" COLOR_RESET);
    exit(0);
}

void ejecutar_copiar(char *args) {
    char cmd[512];
    sprintf(cmd, "cp -v %s", args);
    system(cmd);
}

void ejecutar_mover(char *args) {
    char cmd[512];
    sprintf(cmd, "mv -v %s", args);
    system(cmd);
}

void ejecutar_borrar(char *args) {
    char cmd[512];
    sprintf(cmd, "rm -rfv %s", args);
    system(cmd);
}

void ejecutar_crear(char *args) {
    char cmd[512];
    printf(COLOR_BLUE "Creating directory: %s\n" COLOR_RESET, args);
    sprintf(cmd, "mkdir -p %s", args);
    system(cmd);
}

void ejecutar_entrar(char *args) {
    if (chdir(args) != 0) {
        printf(COLOR_PURPLE "Error: " COLOR_RESET "No se pudo acceder a '%s'\n", args);
    }
}

void ejecutar_ver(char *args) {
    char cmd[512];
    printf(COLOR_CYAN "--- Content of %s ---\n" COLOR_RESET, args);
    sprintf(cmd, "cat %s", args);
    system(cmd);
    printf(COLOR_CYAN "----------------------\n" COLOR_RESET);
}

void ejecutar_limpiar() {
    system("clear");
    imprimir_bienvenida();
}

void ejecutar_donde() {
    char cwd[256];
    getcwd(cwd, sizeof(cwd));
    printf(COLOR_CYAN "Current Path: " COLOR_RESET "%s\n", cwd);
}
