# Alexer Command Interface

Alexer Command Interface es un interprete de comandos interactivo diseñado para simplificar la comunicacion entre el usuario y el sistema operativo. Mediante el uso de ordenes en espanol, esta herramienta permite gestionar archivos, directorios y recursos del sistema de una manera mas natural e intuitiva.

## Funcionamiento

El sistema se basa en un analisis estructural del lenguaje que identifica acciones y argumentos para ejecutarlos en el entorno local. Se adapta automaticamente para funcionar en Windows o sistemas basados en Unix, traduciendo cada orden al comando tecnico correspondiente.

## Instalacion y Puesta en Marcha

Para compilar e iniciar la interfaz, se requiere tener instalados flex, bison y gcc.

```bash
make        # Genera el ejecutable y abre la interfaz
make clean  # Elimina los archivos temporales de compilacion
```

## Diccionario de Comandos

La interfaz cuenta con una amplia gama de comandos organizados por su utilidad:

### Navegacion y Estructura
- listar: Muestra el contenido del directorio actual.
- entrar <ruta>: Cambia la ubicacion de trabajo a la ruta especificada.
- crear <nombre>: Genera una nueva carpeta.
- borrar <nombre>: Elimina de forma permanente archivos o carpetas.
- arbol: Despliega de forma visual la jerarquia de directorios.
- donde: Informa sobre la ruta actual en la que se encuentra el usuario.

### Administracion de Archivos
- copiar <origen> <destino>: Duplica archivos o carpetas.
- mover <origen> <destino>: Cambia de lugar o renombra un elemento.
- renombrar <nombre_viejo> <nombre_nuevo>: Modifica el nombre de un archivo.
- ver <archivo>: Muestra el contenido de un archivo de texto en pantalla.
- comparar <archivo1> <archivo2>: Identifica las diferencias entre dos archivos.
- reemplazar <archivo1> <archivo2>: Sustituye un archivo en el destino indicado.
- ordenar: Organiza lineas de texto alfabeticamente.
- tipo: Visualiza el contenido de archivos (comando equivalente a cat/type).

### Informacion y Estado del Equipo
- sistema: Ofrece un resumen tecnico del hardware y software.
- version: Indica la edicion del sistema operativo instalada.
- fecha: Muestra la fecha actual del sistema.
- hora: Indica la hora exacta en formato local.
- quiensoy: Identifica el nombre del usuario activo.
- red: Muestra los detalles de las interfaces de red (direcciones IP, etc).
- tiempo: Informa sobre el tiempo transcurrido desde el encendido del equipo.
- volumen: Proporciona informacion sobre la unidad de almacenamiento.

### Control y Utilidades de Consola
- limpiar: Borra todo el texto de la ventana para un espacio de trabajo limpio.
- ayuda: Muestra una guia rapida de los comandos disponibles.
- pausa: Detiene la ejecucion del sistema hasta que se presione una tecla.
- color <codigo>: Permite personalizar los tonos visuales de la consola.
- titulo <texto>: Cambia el encabezado de la ventana de la terminal.
- salir / quitar: Finaliza la sesion y cierra la aplicacion.

### Extras y Red
- clima: Obtiene el pronostico del tiempo meteorologico en tiempo real.
- pinguino <ip>: Realiza pruebas de latencia y conexion con servidores externos.
- iniciar <programa>: Abre una aplicacion o archivo externo.
- matar <proceso>: Finaliza una aplicacion en ejecucion.
- apagar: Prepara el equipo para un cierre controlado del sistema.

## Aspectos Tecnicos

La herramienta utiliza Flex para el reconocimiento de palabras clave y Bison para la construccion de la gramatica. Esta division permite que el sistema sea robusto y facil de expandir con nuevas funcionalidades en el futuro.
