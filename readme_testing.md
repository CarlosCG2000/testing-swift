
# CURSO TESTING en SWIFT y SWIFTUI (`https://www.youtube.com/watch?v=7CUeUB3y66o`)

`Tipos de testing` que vamos a ver:
* (1) `Unit Tests` (2) `Integration Tests` (3) `Snapshot Tests` (4) `UITests Xcode`

[IMAG 1]

# 0. Índice
## 1. Secciones (7)
## 2. ¿Qué son `los tests` y para que sirven?
### 2.1. `Beneficios` de testear el código
## 3. Creamos `App de Notas` en `SwiftUI`
## ...
## ...
## ...

## 1. Secciones (7)
1. Creación de una aplicación `TodoApp` con `SwiftUI` y `SwiftData` (de esta app vamos a realizar varios `tipos de testing`).
2. Realización de `Test Unitarios`.
3. Realización de `Tests Integración` -> añadiremos una capa extra con `casos de uso`.
4. `Mocks` y inyeccción de `dependencias`.
5. Realización de `ejercicios`.
6. Realización de `Snapshots Tests`.
7. Realización de `Test EndToEnd (E2E)`.

## 2. ¿Qué son `los tests` y para que sirven?
Nos permiten poder `detectar antes de la ejecución` cuando nuestro código `no se comporta` como esperamos.
`Añadimos seguridad` y `aumentamos la calidad` de nuestro código a nuestra aplicación ya que `no podemos confiar` solo en el `código de producción`.

### 2.1. `Beneficios` de testear el código
- `Incrementa la confianza` para cambiar código existente, de forma que si se rompe el código los test te lo harán saber.
- `Menos tiempo dedicado al debugging`, ya que con los test podemos identificarlos antes.
- `Documentación clara`, es un tipo de `documentación viva` donde viendo los tests se puede ver que comportamiento se espera en cada caso de uso de la app.
- `Mejor diseño de Software`.

Los test cuando `mas pequeños mejor`, son más estables y menos dolorosos.
Mejor que ocupen `poco contenido (Scope)` y que funcionen bien.
Queremos `test deterministas`, que aunque lo ejecuten 100 veces siempre den el mismo resultado.

Para `ejecutar los test` en Xcode usamos el comando: `Cmd + U`

Se pueden ejecutar test tanto en remoto (por ejemplo en github) como en local.

Existe la figura de `QA` en las empresas: se asegura que la app cumple con la suficiente calidad para poder lanzar una nueva versión al App Store.

## 3. Creamos `App de Notas` en `SwiftUI`
Creamos un proyecto con `SwiftData` por defecto.
El proyecto inicialmente en el punto de entrada `ContentView` crea un código con un `listado de items` donde se puede `añadir y borrar elementos` y esto se `almacena` de forma persistente en el dispositivo en `SwiftData` (aunque esta por defecto puesto el `almacenamiento en memoria` y no en el `dispositivo`).

Creamos la carpeta `Modelo` con archivo `Nota` que contiene `la estructura de una nota`
Creamos el archivo `View Model` donde se encuentra un array de notas y las funciones de añadir, modificar o borrar notas en dicho array.
Creamos la carpeta `Vista` con los archivos `NuevaNotaView` y `ModificarEliminarNotaView` con formularios para editar, eliminar o crear una nueva nota
Modificamos el `ContentView` para poder visualizar las notas y navegar a los otros archivos de las vistas.

De momento la aplicación funciona `sin persistencia` de datos sin usar `SwiftData`. El proyecto sirve para visualizar notas y poder crearlas, modificarlas y borrarlas, cuando reinicies el dispositivo se borrará todo.

## 4. Test `UNITARIOS` (`Unit Tests`)

Vamos a crear nuestro Target de Testing: `File --> New --> Target --> Filtro poner 'test' --> Unit Testing Bundle --> Testing System: 'XCTest' (tambien esta 'Swift Testing' que es la forma moderna)`

#### ¿DIFERENCIA DENTRO DE LOS `Unit Tests` ENTRE TEST `XCTest` y `Swift Testing`?

El `target` de `test` va separado al `target` de `producción` que es el que se va a subir a la `Apple Store` por ello están separada nunca se empaquetan juntos.

`Command + R` se ejecutan el testing.

MIN 58:00
