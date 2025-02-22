
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

El `target` de `test` va separado al `target` de `producción` que es el que se va a subir a la `Apple Store` por ello están separada nunca se empaquetan juntos.

`Command + R` se ejecutan el testing.
`Command + S` se ejecutan el guardar.
`Command + U` se ejecutan el testing del fichero.

Ojo si una `función test` no contiene la palabra inicialmente `test` no se va a salir el cuadrado para la ejecución ya que Xcode no lo detecta como un test.

Para acceder a los datos de nuestra aplicación al test tenemos que importar el tag de la aplicación `@testable import AppTesting`
La filosofia de `las operaciones de test` es seguir un `patrón` (que no es obligatorio pero si recomendable) en las funciones, que se rigen por 3 fases:
1. `Given` or Arrange: `preparamos los datos`, es el `estado inicial`
2. `When` or Act: donde ocurre `la acción`
3. `Then` or Asset: `calcula el resultado` o cambio de la accion o evento.

Ahora `pulsamos a nuestro fichero test` (explicado como lo hemos creado anteriormente):
`Command + N --> Filtro poner 'test' --> XCTest Case Class --> Nombre 'ViewModelTest' y Subclass of: 'XCTestCase' --> Seleccionar Target (antiguo creado de test)`

Aqui es donde vamos a hacer el test a las funciones del `ViewModel` (en el anterior se las hicimos al `Modelo`).
Podemos crear en en ciclo de vida al ejecutarse la instancia del View Model.
Tenemos que probar funciones con un Scope reducido, cuando más pequeño mejor el test
Cada función de testing es independiente y por ejemplo para actualizar una nota primero hay que crearla y como cada test al ser independiente no nos sirve tenerla antes ya el testing de prueba no reconoce a los otros testing.

## 4.1. `Test Coverage`
Es un metrica que nos permite saber que porcentaje de nuestro código de producción es el que se ha ejecutado cuando ha pasado nuestros test. Nos permite saber cuanto de testeado tenemos un tipo, clase, struct...

Vamos en la parte lateral donde estan los ficheros en al parte superior `pulsamos el ultimo icono como de unas notas --> pulsamos el ultimo test --> pulsamos 'Coverage'`

Hay vemos los archivos y los porcentajes que tenemos de cada archivo de test pasado. Si pulsamos sobre uno y vamos a su correspondiente fichero y en la parte derecha vemos cuantas veces se ha testedo (saldra con fondo verde si es 1 o más y sera en fondo rojo si es 0 veces).

Hay que buscar un equilibrio entre tener un Coverage casi nulo puede ser que nuestra aplicación no sea muy segura y poco mantenible pero tener un Coverage casi del 100 puede que ni si quiera tenga sentido.

## 4.2. ¿Diferencia dentro de los `Unit Tests` entre los `XCTest` y `Swift Testing`?
...
`RELLENAR ESTO`

PASAR A `MI APLICACIÓN LOS SIMPSON LOS TEST UNITARIOS`
...

## 5. Test `INTEGRACIÓN` (`Integration Tests`)
Test de integracion con SwiftData para persistir nuestras notas y vamos a crear en ella casos de uso.


## MIN 1:15:10