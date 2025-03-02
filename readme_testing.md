
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
### 5.3. ¿Diferencia entre `test unitarios` y `test integrados`?
## 6. `Mocks` e `inyección de dependecias` en Swift
### 6.1. `Arreglo` de `test Unitarios` en el `View Model`
## 7. `Realizar lo mismo` hasta ahora para `Actualizar y Eliminar` una nota.
### 7.1. Crear `UseCase` de actualizar nota
### 7.2. Crear `UseCase` de borrar nota
### 7.3. Editar el `ViewModel`
### 7.4. Arreglar `Unit Tests` creando `Mocks` para los nuevos métodos
### 7.5. Añadir `Integration Tests`
### 7.6. Manejamos `errores` y forma de capturarlos.
## 8. Test de pruebas de capturas instantaneas `Snapshot Tests`
## 9. Test EndToEnd `UITests Xcode`

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

Fijandonos en la imagen de la piramide ya hemos visto los `Unit Tests` testeando el `Modelo` y el `View Model` (con sus funciones). Estos se enfocaban en pequeñas partes del código con funciones y métodos que son fáciles y rápidos de ejecutar. Esos son `la mayoria de test` de nuestra aplicación y deberian de ser de tipo `Unit Tests`. Son la `base de la piramide`.

La segunda capa son los `Test de integración`, esta capa se enfoca en `diferentes partes` de la aplicación que trabajan juntas, estos test son más lentos. Aun asi deberian de ser bastante frecuentes, están en `medio de la piramide` lo que indican que deberia de haber menos `Test de integración` que `Test Unitarios`.

[IMAG 2]

### 5.1. Añadimos en `App de Notas` persistencia con `SwiftData`
Vamos a mejorar la aplicación que teniamos con `SwiftData` para persistir nuestras notas y vamos a crear en ella `casos de uso`. Asi si se cierra la aplicación y la volvemos abrir siguen estando las notas.

[IMAG 3]

Vamos a crear nuevas capas para Swift Data con esta estructura: `DataBase --> Usecase --> ViewModel --> View`.

Vamos a extraer toda la lógica del `View Model` en el fichero `UseCase` con 4 casos de uso `obtener, crear, actualizar, eliminar` las notas y de esta manera desacoplamos la lógica del `View Model` y conformamos unos de los `principios SOLID` el de `responsabilidad única`.

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
Vamos a `validar` que cuando se `cree una nota`, la nota de verdad `persista` en `la BD de SwiftData` y que cuando tambien llamemos al VM para obtener las notas de la BD de SwiftData, efectivamente se recuperen las notas almacenadas en la BD.

Vamos a la carpeta de testing principal que ya habiamos creado y creamos un nuevo fichero:
`Filtro por 'test' --> * Unit Test Case Class --> Nombre 'ViewModelIntegrationTests' y Subclass of: 'XCTestCase' --> Pulsado el Target de testing`
¿No me sale que exista el `Unit Test Case Class`? Eligo `XCTest Unit Test`.

Queremos hacer la comprobación de que funcionan bien como deberia del `ViewModel --> UseCases --> DataBase` y que la acción sea crear una nota en la base de datos.

Podemos usar una `terminología` muy común en `testing` que es cuando se quiere testear `un componente en concreto` llamada `SUT` (System Under Test)
Vamos a crear la configuración de nuestra base de datos cada vez que se genere un test y vamos a hacer que nuestra base de datos este en memoria, es decir no queremos persistir la información en el dispositivo.

En el fichero del test (`ViewModelIntegrationTests.swift`):
Debemos de configurar `el contenedor` que se debe de repetir en cada ejecución de un test. Lo hacemos al declarar nuestro `Singleton` de la Base de datos, eligiendo en `memoria`, declarando los `Use Cases` inicializamos nuestro `ViewModel` con los `Use Cases`.

Luego ya declaramos `las funciones de SwiftData` en el `ViewModel` para testearlo.

Vemos que los test me funcionan pero ahora los test realizados anteriormente en otro fichero `ViewModelTest.swift` de hacer `test unitarios en el View Model` dan `error`, ya que no tiene los `Use Cases` correspondientes y hay un lio de lógica, ya que tenemos funciones que se hacen `en memoria y otras persistencia de disco`.

En el fichero del test unitario antiguo (`ViewModelTest.swift`):
Los `test de modificar y eliminar` que aun no hemos cambiado las operaciones en el `View Model` los vamos a comentar.
Los test de `añadir nuevas notas` que si hemos cambiando en el `View Model` tambien dan `error` ya que usamos la base de datos donde se persisten los datos en disco y por lo tanto el estado al lanzar un test se guarda en disco y esto no es lo que queremos. Es decir, queremos que nuestros `test unitarios` no dependan de otros `componentes` ya que no son su proposito.
No queremos que el `View Model` dependa de `otro componente` como `la Base de datos`. Pero ahora mismo al inicializar nuestro `View Model` se esta creando una instancia con los casos de uso (ya que los tenemos en el `init` por defecto). Pero lo que queremos aqui es crear unos `tipos nuevos` engañando que `simulen` que hemos contactado con `las capas inferiores`, en este caso con la `Base de datos`. Y esto se hace `mockeando` los `Use Cases`.

[IMAG 4]

Vamos a crear unos `Use Cases` que no se conecten a la base de datos sino que `simulen` que hacen algo y que nos retornan un resultado que nosotros especificamos. Gracias a estos escenarios que podemos controlar podemos saber como se comporta nuestra app y prepararla. Para todo esto debemos entender los `Mocks` que es lo que veremos en el siguiente apartado.

### 5.3. ¿Diferencia entre `test unitarios` y `test integrados`?
1️⃣ Test Unitario (`Unit Test`)
✅ Prueban una `única unidad de código` de manera aislada (`una función, un método, una clase, etc.`).
✅ `No dependen de otras componentes` del código `ni de servicios externos` (`red, base de datos, etc.`).
✅ Son rápidos y eficientes.

2️⃣ Test Integrado (`Integration Test`)
✅ Prueban la interacción entre `múltiples componentes` (por ejemplo, entre `ViewModel y un servicio de red`).
✅ No se centran en un único método, sino en el `flujo de datos entre diferentes partes del sistema`.
✅ Pueden incluir `llamadas a bases de datos, redes o almacenamiento local como SwiftData`.

¿Cuándo usar cada uno?
• Los `test unitarios` se usan para asegurar que cada `pieza de código` funcione correctamente `por sí sola`.
• Los `test integrados` verifican que las `distintas partes del sistema` funcionen `bien juntas`.

🛠 Lo ideal es `combinarlos`: muchos `test unitarios + algunos test integrados` para garantizar que todo funcione correctamente. 🚀

## 6. `Mocks` e `inyección de dependecias` en Swift

### 6.1. `Arreglo` de `test Unitarios` en el `View Model`
Para volver a los test unitarios y arreglar las métodos con el View Model de forma aislado de otros componentes como la Base de datos.

Lo que crearemos es un `protocolo` que simule la creación de nuestro `Uses Cases`.
Hasta el momento en el `View Model` en el `init` por defecto se inyectaba los `Uses Cases` de la `Base de datos`, lo que haremos es crear un `protocolo` que simule el comportamiento de nuestros `Uses Cases`.

Repito aqui `no queremos testear el comportamiento` del `View Model` con los `demás componentes` ya que para eso tenemos los `test de integración`.

Lo que queremos es como `engañar a nuestra aplicación` pero solo en el `target de testing`, nos permite `simular diferentes escenarios'` que se pueden contemplar en nuestra aplicación.

- ¿Qué beneficios tiene?
1. Nos permite controlar el comportamiento dentro de nuestra aplicación: podemos devovler valores especificos o lanzar errores solo para pobrar como se comporta nuestor View Model en diferentes escenarios.
2. Podemos probar diferentes caminos que pueden seguir nuestrro código. Es decir, que nuestro Use Cases retornen un error cuando queremos crear una nota nueva o que retorne una un array de notas y todo esto sin conectarse al a Base de Datos, solo simulando los escenarios.
3. Podemos aislar el código que estamos testeando, al usar mocks nos aseguramos que solo testeamos el View Model y nos aislamos de otros componentes como la base de datos.

[IMAG 5.1, 5.2, 5.3]

Vamos a crear una abstraccionde nuestro `CreateNoteUseCase` como un protocolo.
Similar a cuando creamos el protocolo `NotasDatabaseProtocol` es ese caso creamos la abstraccion para no tener que trabajar directamente con el tipo `NotasDatabase`.

+ Entramos en acción:
Vamos al fichero `CreateNoteUseCase.swift` y creamos el protocolo `CreateNoteProtocol` y hacemos que nuestra struct `CreateNoteUseCase` este conformado por ese protocolo `CreateNoteProtocol`. E sun paso simple que conforma muchos beneficios que entendermos cuando creemos el primer mock en el target del test mas adelante.
Algunos de los beenficios es que estamos mejorando el desacoplamiento, ahora nuestro ViewModel no usara directamente el tipo struct `CreateNoteUseCase` sino una abstracción al inyectarle protocolo `CreateNoteProtocol`.

Un ejemplo es pensar en un protocolo como unos contratos que se deben cumplir. Por ejemplo en los regalos de amigos invisibles se crean unos contratos como que debe valer menos de 100€ el regalo, de tematica sobre superheroes y deben de colocarse en una caja. Pues eso estaria en un protocolo porque son contratos que definen lo que se necesita pero no como lograrlo. Es decir, como cumplir la actraccion del protocolo pero no los pasos para cumplirlo. Ty ahora podrias ir a una tienda de comic y elegir entre diferentes comic y cumplir los pasos de diferente manera al poder elegir entre una gran variedad de comics o figuras pero cumpliendo los contratos de ser de superheroes, valer menos de 100€, etc.

Del mismo modo muchas clases, struct o enum diferentes pueden conformar el mismo protocolo siempre que contengan los mismos contratos. Asi se permite tener flexibilidad  en la impplementación mientras se asegura que se cumplan ciertos criterios esenciales.

[IMAG 6]

Lo mismo que hemos hecho creando el protocolo para `CreateNoteUseCase.swift` lo hacemos para `FetchAllNoteUseCase.swift`.
Después vamos al `ViewModel.swift` en el init en vez de las inyecciones de los `UseCases` vamos a utilizar las abstracciones de dichos casos de uso cambiando la llamada a los struct de los casos de usos pro la llamada los protocolos (que contienen estos casos de uso).

Antes de pasar al test comentar que los protocolos son muy estrictos todas las funciones y tipos que tiene un protocolo debe los metodos (contratos) de dicho protocolo.

Vamos al `ViewModelTest.swift`:
Vamos a crear nuestro primer mock (aunque es aconsejable crearlo en otro fichero). Demomento lo creamos aqui y ya lo pasaremos a otro fichero.
Vamos a crear un mock llamado `CreateNoteUseCaseMock` que contenga el protocolo creado `CreateNoteProtocol` para testear solo el `ViewModel`.
Igualmente creamos un mock para `FetchAllNoteUseCase`.

Y dentro del `método del test que se iniciliza antes de ejecutarse el test` donde declaro el `ViewModel` le paso los `protocolos del mock creados` en vez de pasarle vacio que `por defecto tenia los de la Base de datos`.

Al ejecutarlo ahora vemos como en la primera función de crear una nota funciona bien pero en la segunda de crear dos notas funciona mal. ¿A que se debe esto?
Al ejecuta el primer test esta insertando en nuestro mock ya una nota entonces al entrar en el otro método ya no parte de 0 notas sino de 1 nota. Pero como queremos que cada ejecución de nuestro test sean independientes tenemos que resetear el contendido de nuestra mock de datos (`mockDBNotas`). Esto es tan simple como que en la función por defecto de cuando se acaba una ejecución del test `tearDownWithError` haga algo como que pase a vaciarse el `mockDBNotas` es decir `mockDBNotas = []`

Y ya funciona perfectamente.

En resumen: hemos aprendido a `crear mocks` para usarlos en nuestros `test unitarios` y para hacerlo nos hemos basado en los `protocolos` y sobretodo en `la inyección de independecias` que es importante a la hora de crear test.

## 7. `Realizar lo mismo` hasta ahora para `Actualizar y Eliminar` una nota.
Realizaremos ahora lo mismo para otras operaciones como actualizar y eliminar.
Pasos a realizar:
- Crear `UseCase Actualizar` Nota
- Crear `UseCase Borrar` Nota
- Crear `Integration Tests`
- Arreglar `Unit Tests`

### 7.1. Crear `UseCase` de actualizar nota
Vamos a la carpeta `Casos de uso` y creamos el archivo `UpdateNoteUseCase.swift`
Editamos en el archivo `NotaDatabase.swift` creando la `función de SwiftData` para `modificar una nota` y se lo añadimos a `su protocolo`. Esta función se la pasaremos a través de `su protocolo` (de `NotaDatabase.swift`) a nuestro caso de uso antes justo creado `UpdateNoteUseCase.swift`.

### 7.2. Crear `UseCase` de borrar nota
Vamos a la carpeta `Casos de uso` y creamos el archivo `DeleteNoteUseCase.swift`
Editamos en el archivo `NotaDatabase.swift` creando la `función de SwiftData` para `eliminar una nota` y se lo añadimos a `su protocolo`. Esta función se la pasaremos a través de `su protocolo` (de `NotaDatabase.swift`) a nuestro caso de uso antes justo creado `DeleteNoteUseCase.swift`.

### 7.3. Editar el `ViewModel`
Ahora vamos al `ViewModel.swift` donde teniamos inicializado `los 2 UseCases antiguos`. Y añadimos los `2 nuevos UseCases` de forma `abstracta` a través de los `protocolos` y no los `useCases en concreto`. Y cambiamos las funciones correspondientes en dicha clase.

Ahora mismo deberia tener `nuestra aplicación` toda la `funcionalidad` en `Swift Data`.

### 7.4. Arreglar `Unit Tests` creando `Mocks` para los nuevos métodos
Necesitamos crear un mock para retornar la información que nosotros queremos de nuestros `UseCases`. De esta manera no bajaremos varias capas  de nuestra arquitectura hasta llegar a la BD sino que simulamos un comportamiento.

Lo que vamos a hacer es mejor crear una `carpeta` llamada `mocks` y dentro `crear los archivos cada uno con un mock` (esto seria lo ideal), pero para simplicar los vamos a meter todos dentrr del mismo archivo llamado `Mock.swift`.

Vamos a nuestro `ViewModelTest.swift` e inyectamos en la instancia de `ViewModel` nuestros `protocolos` con cada `mock`.

### 7.5. Añadir `Integration Tests`
Vamos a crear dos test uno para comprobar que `la integración con la BD` funciona y por lo tanto `actualiza la nota` y el otro para ver que se `borra la BD`. Estos `test de integración` son completamente diferentes a los `test unitarios`, ya que estso no interactuaban con la BD.

Estos de `test de integración` interactuan con la BD, es decir usamos un BD real pero lo que usamos es una configuración especifica para persistir la información en memoria.
Añadimos las dos funciones.

En resumen hemos creado la `implementación` que faltaba para poder `actualizar y eliminar una nota`, tambien hemos creado los `casos de uso` para poderlo inyectar dentro del `ViewModel`, al crear el `init del ViewModel` basandonos en abstracciones de `protocolos` dentro de nuestro `target de testing` hemos podido `crear mocks` de nuestros casos de uso para especificar que comportamiento queremos tener y asi testear nuestro código sin tener que envolucrar para nada la `Base de datos` y esto ha pasado en los `test unitarios`. Finalmente hemos hecho los `test de integración` que involucran nuestra base de datos en memoria. En este caso estamos comprobando `la integración` de varias capas de nuestra `arquitectura` para comprobar que la integración de distintas partes de código funciona como deberia.

### 7.6. Manejamos `errores` y forma de capturarlos.
En el `ViewModel` añadimos una variable `var databaseError:DatabaseError?` lo vamos a capturar es el error de la base de datos. Pro ejemplo en el método de borrar añadimos un `catch let error as DatabaseError` ue nos devuelve el error y lo guarde en la variable antes definida.

En `ViewModelIntegrationTests` creamos un test que lance un error y que comprobemos que el error que da va a ser el que hemos creado en el `ViewModel` cuando se da dicho error.
Porque no siempre se deben de crear test de cosas que esperamos si no tambien de posible errores.

## 8. Test de pruebas de capturas instantaneas `Snapshot Tests`
Sirven para comparar visualmente la `UI` de la aplicación pudiendo saber si se ha cometido un error muy facilmente.

Primero creamos el `Snapshot` de nuestra vista (de la vista que queremos testear). Al ejecutar por `primera vez el test` se crea una captura con la pantalla de la vista que queremos testear. Esta captura se guarda como `referencia` para poder comparar en futuras referencias que hagamos de la vista. Es decir por ejemplo añadir mas `subvistas, cambiar colores, eliminar, subvistas, etc`.

Imaginamos que hacemos `captura de la pantalla` de crear una nueva nota, esta no debemos hacer de `forma manual`, sino que las hará el `test por nosotros`. Lo siguiente seria ejecutar el test cada vez que cambiemos la vista de la cual hemos creado el `Snapshot`. Al ser `test automatizado` se toma una nueva `captura de la vista`. Ahora deberiamos de `comparar las captura`. La `captura que hicimos del test` se compara con la `captura de referencia` que se guardo la primera vez que se creo la vista, si hay alguna `diferencia` entre las dos el test este `fallará`.

[IMAG 7] [IMAG 7.1]

Vamos a la práctica:
1. Instalamos una dependencia de Swift Package Manager llamada `swift-snapshot-testing`: `https://github.com/pointfreeco/swift-snapshot-testing`

2. Creamos un `test` en nuestro target de `testing` --> `Unit Test Case Class` --> Le ponemos el nombre `CreateViewNoteSnapshotTest`

* 3. Como tenemos muchas ficheros dentro de la `target test` lo voy a dividir en un carpeta según el tipo de test: `UnitTest`, `IntegrationTest` y `SnapshotTest`

4. En el fichero `CreateViewNoteSnapshotTest.swift` creamos el método del test.
La primera vez que lo ejecutemos dara `error` porque esa la vez que se guarde la instacia de referencia. Si le damos a ver el error tendra `un enlace` que nos redirigira a la carpeta donde se va a encontrar el `snapshot de referencia` para las próximas ejecuciones.

Ejemplo del error en la linea, al pulsar la linea vemos esto y ese enlace almacena la imagen de referencia para futuras ejecuciones:
`failed - No reference was found on disk. Automatically recorded snapshot: … open "file:///Users/carlosCG/Desktop/Swift%20Testing/AppTesting/AppTestingUnitTest/SnapshotTest/__Snapshots__/CreateViewNoteSnapshotTest/testCreateNoteView.1.png"`

Cogemos donde esta `la ruta del png` la pulsamos a la derecha y le damos a `Open Link` y nos muestra la imagen que nos ha creado nuestro test.

5. Si lo `volvemos a ejecutar` al no a ver cambiado nada de nuestra vista ya `deberia de pasar`.
Imaginate que `cambiamos ahora la vista` un simple color del texto en una etiqueta o cualquier cosa. Ahora la imagen de referencia va a ser diferente a la que tenemos y `dara error`. Podemos de la misma forma ver los `enlaces de las dos imágenes` y como `difiere una imagen de la otra` para saber lo que ha cambiado de una vista a la otra.

[IMAG 8]

* ¿Y que pasa si queremos `cambiar esa referencia de la imagen`, ya que nos queremos quedar con la ultima actualización de la vista?

Lo que tenemos es que ir a` la carpeta de la imagen de referencia y cambiar la imagen` por la versión de error que es la que queremos usar ahora y ponersela a la carpeta de referencia. Ambas rutas salen en el error con junto un `+` y un `-`. Al poner en el Finder `cmd + mayus + g` y poner la ruta desde el `file ... .png` y dar a intro accedemos a las carpetas.

6. Creamos `otro método test de ejemplo` donde le pasamos la vista de crear una nota con los campos por defecto rellenos.
Recordamos que al crear la primera refencia va a dar error.

## 9. Test EndToEnd `UITests Xcode`
Si recordamos enla [IMAG 1] son en la piramide los más altos que se encuentran arriba del todo.
Son los test EndToEnd de extremo a extremo, donde se interactua con la UI.
Con el podemos testear flujos de nuetra app, por el ejemplo el login, los registros, entrar a nuestra app y lueog navegar sila logica se comporta tal y como esperamos, etc.

Vamos a crear `2 UITests`:
1. Crear una nota y ver que se ha creado correctamente.
2. Otro para borrar la nota que acabamos de crear.

Usaremos la base de datos de la aplicación pero es recomedable usar lo que hemos visto de inyectar una base de datos en memoria cunado trabajemos con los test.

Vamos a usar directamente el simulador y a medida que interactuamos con nuestra aplicación en el simulador van a ir apareciendo instrucciones dentro de nuestro test de forma automatica. Estamos grabando todos los pasos que queremos seguir al ejecutar nuestro test para que luego al ejecutarlo realice los mismo pasos que hemos realizado en el simulador.

Son test costosos porque son mas lentos que los test unitarios o integración por eso s¡estan arriba del todo en la piramide del testing. Es de los tres que menos debemos hacer en nuestra app.

Empezamos:
Para poder crear los UITest hay que crear otro target diferente al principal y al de test que llevamos usando todo el rato.
`Xcode --> File -->  New --> Target --> Filtramos: 'test' --> UI Testing Bundle --> Dejamos el nombre: 'AppTestingUITests'`

Vemos dentro del Target dos ficheros, entramos en el que pone `AppTestingUITests` y el otro lo borramos.

En Xcode en el botón de la parte superior justo en el centro vemos `AppTesting` le damos y creamos `un nuevo esquema` le damos un nombre que tiene por defecto y en target elegimos el nuevo target creado.
Ahora nos quedamos en ese nmuevo esquema y pulsamos `Cmd + U` para lanzar todos los test. Al pulsar `Cmd + U` solo se ejecutan los test del target nuevo (donde tenemos puesto la vista del esquema).

AHora en nuestro fichero de `AppTestingUITests`
Nos quedamos solo cone ste método:
```swift
@MainActor
    func testExample() throws {

    }
```

Y en la consola sale `un botón circular rojo` que es para grabar a las instrucciones. Entonces le pulsamos. Nos sale un error. Vamos a el esquema lo editamos en la seccion `Run` en  `Executable` seleccionamos al target principal, en mi caso `AppTesting.app`
Ahora la pulsar el `botón circular rojo` sale la pantalla del simulador del iPhone y tenemos que realizar las acciones. Luego en el código van aparecer las acciones que hemos realizado en el simulador.
La unica linea de instruccion que hay que añadir manualmente es `app.launch()`.

Al ejecutarlo las acciones que teniamos realizadas en el simulador fueron de añadir una nueva nota escirbiendola en el formulario.
Al ejecurtar el test cuando ya ha introducido el código se ejecuta solo la aplicación en el simulador pero no rellena nada de texto en el formulario.

Para arreglarlo añadimos estas lineas:
```swift
// ...
 tituloTextField.typeText("Prueba de Título")
//...
 descripciNTextField.typeText("Prueba de Texto")
```

Hacemos el nuevo método: `testCrearDosNotaBorrarPrimera()`.

'''''' ¡TUTORIAL COMPLETADO! ''''''

# EXTRA - LOGS
[IMAG 9]

¿Por qué generar `logs` en vez de mostrar `mensajes por pantalla` en `SwiftUI`?
1. `Mejor depuración` → Los logs permiten `rastrear el flujo` de la aplicación sin interrumpir la experiencia del usuario.
2. `Análisis posterior` → Se pueden almacenar logs para `revisar fallos` después de que ocurran.
3. `Menos intrusivo` → `No afecta la UI` ni la experiencia del usuario con alertas o mensajes emergentes.
4. `Mejor rendimiento` → Es más eficiente que imprimir en pantalla, especialmente en procesos en segundo plano.
5. `Facilidad de diagnóstico` → Puedes filtrar `logs por niveles` (`info, warning, error, debug`) y verlos organizados en Xcode o en archivos.

## Características clave para los logs
1. `Nivel de severidad` (`INFO, DEBUG, WARNING, ERROR, CRITICAL`)
2. `Fecha` y hora exacta del evento
3. `Módulo` o categoría (p. ej. `Mock`, `Networking, Database, UI, Auth`)
4. `Función o archivo de origen` donde se generó el log
5. `ID del usuario` o sesión (si la app maneja usuarios)
6. `Contexto adicional` (ejemplo: quoteID=12345, username=CarlosCG)

## ¿Cómo generar logs en SwiftUI?
1. Usando `print(_:)` (Solo en desarrollo, no recomendado en producción)
❌ `Limitaciones`: No permite niveles de log, difícil de gestionar en producción.

2. Usando `os.Logger` (Recomendado para producción)
Desde `iOS 14` en adelante, puedes usar `os.Logger`, que es más eficiente que `print()`.
✅ Ventajas:
• Más eficiente que `print()`.
• Permite `filtrar logs` por niveles en `Xcode > Debug Console`.
• Se `integra` con la herramienta `Console.app` en `macOS` para ver logs del sistema.

* Ejemplo:
```swift
import OSLog

let logger = Logger(subsystem: "com.miapp.SimpsonsApp", category: "Networking")

logger.info("✅ Respuesta recibida con éxito, URL: https://api.simpsons.com/quotes")
logger.error("❌ Error 404 al obtener personajes.")
```

- Salida en la consola de Xcode
```swift
2025-02-24 12:35:10.123456+0000 com.miapp.SimpsonsApp [Networking] ✅ Respuesta recibida con éxito, URL: https://api.simpsons.com/quotes
2025-02-24 12:35:12.654321+0000 com.miapp.SimpsonsApp [Networking] ❌ Error 404 al obtener personajes.
```

* `Filtrar logs` con estas características
1. Por `nivel de severidad`:
• Buscar [INFO], [ERROR], [DEBUG] en los logs.
• Si usas OSLog, en la Consola de Xcode puedes filtrar logs por `log.level(.error)`.
2. Por `categoría`:
• Filtrar logs de `Networking, Database, UI, Auth`.
• En `OSLog`, usar `log.category("Networking")` para ver solo esos logs.
3. Por `contexto específico`:
• Si guardas `IDs (quoteID=12345)`, puedes buscar logs de una `cita específica`.
4. Por `fecha`:
• Buscar `logs dentro de un rango de fechas` para depurar errores recientes.

3. Guardar `logs` en un archivo (Para `depuración avanzada o soporte`)
✅ Ventaja: Permite almacenar logs persistentes para análisis posterior.

* 1. Si quieres `almacenar logs` en un archivo para analizarlos después:
Añade esta función en un `LoggerManager.swift` para escribir los logs en un archivo dentro de la carpeta de `Documentos` de la app:
```swift
import Foundation
import OSLog

struct LogWriter {
    static let logFileName = "app_logs.txt"

    static func writeLog(_ message: String) {
        let timestamp = Date().formatted(date: .numeric, time: .standard)
        let logMessage = "[\(timestamp)] \(message)\n"

        do {
            let fileURL = getLogFileURL()
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                fileHandle.seekToEndOfFile()
                if let data = logMessage.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            } else {
                try logMessage.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        } catch {
            print("❌ Error al escribir el log: \(error)")
        }
    }

    static func getLogFileURL() -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(logFileName)
    }
}
```

* 2. `Usar el log` en tu app
Ahora, en cualquier parte de la app donde necesites `guardar un log`, usa:
``` swift
import OSLog

let logger = Logger(subsystem: "com.miapp.SimpsonsApp", category: "General")

logger.info("🏁 Inicio de la app.")
LogWriter.writeLog("🏁 Inicio de la app.")
```

* 3. `Consultar el archivo de logs`
Puedes ver los logs guardados en la carpeta Documents de la app:
```swift
let logURL = LogWriter.getLogFileURL()
print("📂 Ruta del archivo de logs: \(logURL.path)")
```

Si necesitas acceder al `archivo de logs` desde Finder en un `simulador`:
+ 1. Ejecuta la app en el simulador
+ 2. Abre Terminal y usa:
```bash
open $(xcrun simctl get_app_container booted com.miapp.SimpsonsApp data)/Documents
```

🔥 Bonus: Leer los `logs` desde la app
Si quieres ver los logs directamente en tu app:
```swift
func readLogs() -> String {
    let fileURL = LogWriter.getLogFileURL()
    return (try? String(contentsOf: fileURL, encoding: .utf8)) ?? "No hay logs aún."
}
```
Y lo muestras en una vista de `SwiftUI`:
```swift
Text(readLogs())
    .padding()
    .font(.caption)
```
✅ Ahora los logs quedarán guardados en un archivo y podrás analizarlos fácilmente. 🚀

# ___________________________________________
PASAR A MI APLICACIÓN LOS SIMPSON
- LOS `TEST UNITARIOS` TANTO CON `XCTest` y `Swift Testing` PARA `Model` Y `View Model` DE LA SECCIÓN `Character` ✅
- LOS `TEST INTEGRADOS` CAMBIANDO EN `SwiftData` EL `CONTENEDOR` Y CREANDO `CASOS DE USOS` CONECTANDO AL `VIEW MODEL` ✅
- ARREGLAR LOS `TEST UNITARIOS` CREANDO `MOCKS` A PARTIR DE `PROTOCOLOS` E `INYECCIÓN DE DEPENDENCIAS` ✅
- LOS `TEST SNAPSHOT` ✅
- LOS `TEST ENT_TO_ENT - UITEST` ✅

+ ¿Por qué usar `Singleton para (punto 1)` una instancia unica en nuestra aplicación para la clase que del `contenedor que interactua con la Base de Datos`?
+ Crear el `contenedor separado de la App` con los métodos y un protocolo para que se lo pase a unos ficheros con los `Casos de uso` y que se llaman en el `View Model` para que los uso la `View`.


