
# CURSO TESTING en SWIFT y SWIFTUI (`https://www.youtube.com/watch?v=7CUeUB3y66o`)

`Tipos de testing` que vamos a ver:
* (1) `Unit Tests` (2) `Integration Tests` (3) `Snapshot Tests` (4) `UITests Xcode`

[IMAG 1]

# 0. Índice
## 1. Secciones (7)
## 2. ¿Qué son `los tests` y para que sirven?
### 2.1. `Beneficios` de testear el código
## 3. Creamos `App de Notas` en `SwiftUI`
## 4. Test `UNITARIOS` (`Unit Tests`)
### 4.1. `Test Coverage`
### 4.2. ¿`Diferencia` dentro de los `Unit Tests` entre los `XCTest` y `Swift Testing`?
## 5. Test `INTEGRACIÓN` (`Integration Tests`)
### 5.1. Añadimos en `App de Notas` persistencia con `SwiftData`
### 5.2. Pasos del `test de integración`
## 6. `Mocks` e `inyección de dependecias` en Swift
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
`⇧ + ⌘ + K (Shift + Command + K)`: limpiar proyecto y test.

Ojo si una `función test` no contiene la palabra inicialmente `test` no se va a salir el cuadrado para la ejecución ya que Xcode no lo detecta como un test.

Para acceder a los datos de nuestra aplicación al test tenemos que importar el tag de la aplicación `@testable import AppTesting`
La filosofia de `las operaciones de test` es seguir un `patrón` (que no es obligatorio pero si recomendable) en las funciones, que se rigen por 3 fases:
1. `Given` or Arrange: `preparamos los datos`, es el `estado inicial`
2. `When` or Act: donde ocurre `la acción`
3. `Then` or Asset: `calcula el resultado` o cambio de la accion o evento.

+ Añadimos mas `ficheros de test`:
Ahora `pulsamos a nuestro fichero test` (explicado como lo hemos creado anteriormente):
`Command + N --> Filtro poner 'test' --> XCTest Case Class --> Nombre 'ViewModelTest' y Subclass of: 'XCTestCase' --> Seleccionar Target (antiguo creado de test)`

Aqui es donde vamos a hacer el test a las funciones del `ViewModel` (en el anterior se las hicimos al `Modelo`).
Podemos crear en en ciclo de vida al ejecutarse la instancia del View Model.
Tenemos que probar funciones con un Scope reducido, cuando más pequeño mejor el test
Cada función de testing es independiente y por ejemplo para actualizar una nota primero hay que crearla y como cada test al ser independiente no nos sirve tenerla antes ya el testing de prueba no reconoce a los otros testing.

### 4.1. `Test Coverage`
Es un metrica que nos permite saber que porcentaje de nuestro código de producción es el que se ha ejecutado cuando ha pasado nuestros test. Nos permite saber cuanto de testeado tenemos un tipo, clase, struct...

Vamos en la parte lateral donde estan los ficheros en al parte superior `pulsamos el ultimo icono como de unas notas --> pulsamos el ultimo test --> pulsamos 'Coverage'`

Hay vemos los archivos y los porcentajes que tenemos de cada archivo de test pasado. Si pulsamos sobre uno y vamos a su correspondiente fichero y en la parte derecha vemos cuantas veces se ha testedo (saldra con fondo verde si es 1 o más y sera en fondo rojo si es 0 veces).

Hay que buscar un equilibrio entre tener un Coverage casi nulo puede ser que nuestra aplicación no sea muy segura y poco mantenible pero tener un Coverage casi del 100 puede que ni si quiera tenga sentido.

### 4.2. ¿`Diferencia` dentro de los `Unit Tests` entre los `XCTest` y `Swift Testing`?
En Swift, existen dos principales frameworks para realizar `unit tests`:
1. `XCTest` (el tradicional, parte de Xcode).
2. `Swift Testing` (nuevo, introducido en Swift 5.9).

1. `XCTest` (el clásico, usado en Xcode)
🔹 Es el framework tradicional de Apple para pruebas en `Swift y Objective-C`.
🔹 Se basa en clases y métodos con prefijos `test`.
🔹 Utiliza `XCTestCase` como clase base para `escribir pruebas`.
🔹 Se ejecuta dentro del `entorno de pruebas de Xcode`.
🔹 Se usa en `@testable import` para probar módulos internos.
🔹 Ejecutar `pruebas`:
• Se ejecutan desde el `panel de pruebas` de Xcode.
• Se pueden integrar en `CI/CD` con herramientas como `xcodebuild test.`

2. `Swift Testing` (nuevo, más moderno)
🔹 Introducido en `Swift 5.9`, es más moderno y expresivo.
🔹 Usa una sintaxis más `declarativa` con `test y expect`.
🔹 `No` necesita `XCTestCase`, usa funciones directamente.
🔹 Se ejecuta con swift test en proyectos con `Swift Package Manager (SPM)`.
🔹 Ejecutar `pruebas`:
• Se ejecutan con `swift test` (útil en proyectos SPM).
• Son más fáciles de `escribir y leer`.
• `No dependen de Xcode`, por lo que funcionan en cualquier entorno `Swift`.

| Característica       | `XCTest` 🏛️ (Clásico) | `Swift Testing` 🚀 (Nuevo) |
|----------------------|----------------------|----------------------------|
| **Sintaxis**         | Basado en clases (`XCTestCase`) | Basado en funciones (`test { }`) |
| **Framework**        | `XCTest` (nativo de Xcode) | `Testing` (Swift 5.9+) |
| **Ejecución**        | Xcode (`cmd + U` o `xcodebuild test`) | `swift test` (ideal para SPM) |
| **Expresividad**     | Más verbo (`XCTAssertEqual(...)`) | Más declarativo (`expect(...) == ...`) |
| **Uso en CI/CD**     | Compatible con Xcode | Más portable, independiente de Xcode |
| **Compatibilidad**   | iOS, macOS, tvOS, watchOS | Solo para proyectos en Swift 5.9+ |

- **¿Cuál elegir?**
- **Si trabajas en Xcode y desarrollas para iOS/macOS:** `XCTest` (es el estándar y bien integrado).
- **Si trabajas con Swift Package Manager o buscas tests más modernos:** `Swift Testing`.
- **Si necesitas compatibilidad máxima:** `XCTest` sigue siendo la mejor opción.

🚀 *En el futuro, Swift Testing podría reemplazar a XCTest, pero por ahora XCTest sigue siendo el más utilizado en el ecosistema Apple.*

## 5. Test `INTEGRACIÓN` (`Integration Tests`)
[IMAG 1]

Fijandonos en la imagen de la piramide ya hemos visto los `Unit Tests` testeando el Modelo y el View Model (con sus funciones). Estos se enfocaban en pequeñas partes del codigo com funciones y métodos que son faciles y rapidas de ejecutar. Esos son `la mayoria de test` de nuestra aplicación y deberian de ser de es tipo `Unit Tests`. Son la base de la piramide.

La segunda capa son los `Test de integración`, esta capa s eenfoca en diferentes partes de la aplicación que trabajan juntas, estos test son más lentos. Aun asi deberian de ser bastate frecuentes, están en medio de la piramide lo que indican que deberia de haber menos `Test de integración` que `Test Unitarios`.

[IMAG 2]

### 5.1. Añadimos en `App de Notas` persistencia con `SwiftData`
Vamos a mejorar la aplicación que teniamos con SwiftData para persistir nuestras notas y vamos a crear en ella casos de uso. Asi si se cierra la aplicación y la volvemos abrir siguen estnado las notas.

[IMAG 3]

Vamos a crear nuevas capas para Swift Data con esta estructura: `DataBase --> Usecase --> ViewModel --> View`
Vamos a extraer toda la lógica del `View Model` en el fichero `UseCase` con 4 casos de uso `obtener, crear, actualizar, eliminar` las notas y de esta manera desacoplamos la lógica del `View Model` y conformamos unos de los `principios SOLID` el de responsabilidad única.

* Vamos a testear con `test de integración` desde la capa de `Base de datos` hasta la de `View Model`.

1. Creamos una clase `NotaDatabase.swift` para interactuar con la `base de datos`.
Vamos a crear un `Singleton`, una `única instacia` que se ejecuta una única vez en nuestra aplicación.
Creamos el `contenedor del modelo` que tenga el contexto para `base de datos en Swift Data`.
Tambien voy a definir `los funciones con las operaciones a la base de datos` directamente en este archivo que son de crear, obtener, modificar y borrar.
Creo un protocolo que va a conformar a la clase `NotaDatabase`. Lo hacemos para que nos `facilite la inyección de dependecias` en `los casos de uso`. Y en vez de que usen `implementaciones` usen `abstracciones` concretas.

2. Editamos la `Nota.swift`.
Importamos `SwiftData`, añadimos la macro `@Model` y cambia el tipo de `struct` por `class`.
Hay que cambiar los atributos de tipo `let` por `var`. Y el `id` añadirle la macro `@Attribute(.unique)`.

3. Creamos una carpeta `Casos de uso` con los casos de uso `CreateNoteUseCase.swift`, `FetchAllNoteUseCase.swift`
Vamos a usar el `protocolo` del `NotaDatabase.swift` asi en vez de utilizar `implementaciones` usaremos `abstracciones` concretas.

4. Editamos la `ViewModel.swift`.
Añadimos las referencias de cada caso de uso.

### 5.2. Pasos del `test de integración`
Vamos a valdiar que cuando se cree una nota la nota de verdad persista en la BD de SwiftData y que cuando tambien llamemos al VM para obtener las notas de la BD de SwiftData, efectivamente se recuperen las notas almacenadas en la BD.

Vamos a la carpeta de testing principal que ya habiamos creado y creamos un nuevo fichero:
`Filtro por 'test' --> * Unit Test Case Class --> Nombre 'ViewModelIntegrationTests' y Subclass of: 'XCTestCase' --> Pulsado el Target de testing`
¿No me sale que exista el `Unit Test Case Class`? Eligo `XCTest Unit Test`.

Queremos hacer la comprobación de que funcionan bien como deberia del `ViewModel --> UseCases --> DataBase` y que la acción sea crear una nota en la base de datos.

Podemos usar una `terminología` muy común en `testing` que es cuando se quiere testear `un componente en concreto` llamada `SUT` (System Under Test)
Vamos a crear la configuración de nuestra base de datos cada vez que se genere un test y vamos a hacer que nuestra base de datos este en memoria, es decir no queremos persistir la información en el dispositivo.

Debemos de configurar el contenedor que se debe de repetir en cada ejecución de un test. Lo hacemos al declarar nuestro Singleton de la Base de datos, elegiendo en memoria, declarando los use cases inicializamos nuestro ViewModel con los use case.

Luego ya declaramos las funciones de SwiftData en el ViewModel para testearlo.

Vemos que los test me funcionan pero ahora los test realizados anteriormente en otro fichero `ViewModelTest.swift` de hacer test unitarios en el View Model dan error, ya que no tiene los useCases correspondientes y hay un lio de logica, ya que tenemos funciones que se hacen en memoria y otras persistencia de disco.

Los test de modificar y eliminar que aun no hemos cambiado las operaciones en el View Model los vamos a comentar.
Los test de añadir nuesas notras que si hemos cambiando en el View Model tambien dan error ya que usamos la base de datos donde se persisten los datos en disco y por lo tanto el estado al lanzar unt est se guarda en disco y esto no es lo que queremos. Es decir queremos que nuestros test unitarios no dependan de otros componentes ya que no son su proposito. No queremos que el View Model dependa de otro componente como la Base de datos. Pero ahora mismo al inicializar nuestro View Model se esta creando una instancia con los casos de uso (ya que los tenemos en el init por defecto). Pero lo que queremos aqui es crear unos tipos nuevos engañando que simulen que hemos contactado con las capas inferiores, en este caso con la Base de datos. Y esto se hace mockeando los Use cases.

[IMAG 4]

Vamos a crear unos UseCases que no se conecten a la base de datos sino que simulen que hacen algo y que nos retornan un resultado que nosotros especificamos. Gracias a estos escenarios que podemos controlar podemos saber como se comporta nuestra app y prepararla. Para todo esto debemos entender los Mocks que es lo que veremos en el siguiente apartado.

## 6. `Mocks` e `inyección de dependecias` en Swift



+ DIFERENCIA ENTRE TEST UNITARIOS E INTEGRADOS (QUE DEPENDEN DE COMPONENTES)
+ REALIZAR LA PARTE DEL VIDEO DEL TEST INTEGRADOS EN EL PROYECTO


## MIN 1:56:05

# ___________________________________________
PASAR A MI APLICACIÓN LOS SIMPSON
- LOS `TEST UNITARIOS` TANTO CON `XCTest` y `Swift Testing` PARA `Model` Y `View Model` DE LA SECCIÓN `Character` ✅
- LOS `TEST INTEGRADOS` CAMBIANDO EN `SwiftData` EL `CONTENEDOR` Y CREANDO `CASOS DE USOS` CONECTANDO AL `VIEW MODEL` ❌

+ ¿Por qué usar `Singleton para (punto 1)` una instancia unica en nuestra aplicación para la clase que del `contenedor que interactua con la Base de Datos`?
+ Crear el `contenedor separado de la App` con los métodos y un protocolo para que se lo pase a unos ficheros con los `Casos de uso` y que se llaman en el `View Model` para que los uso la `View`.


