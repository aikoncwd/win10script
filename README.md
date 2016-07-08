# AikonCWD Windows 10 Script

![](http://i.imgur.com/WUAw09U.png)

## Información rápida
|||
|---|---|
|**Versión**|v5.1|
|**Fecha**|07/07/2016|
|**Descarga**|[ZIP File](www.google.es)|

## Introducción

Éste script escrito en VBS permite personalizar a fondo tu instalación de Windows 10, la idea nació principalmente como herramienta sencilla para que cualquier usuario pudiera eliminar el *telemetry* de Windows 10 (conocido coloquialmente como Win10 Spyware). El script ha ido creciendo desde entonces y ahora agrega muchas más funciones, tales como:

- Habilitar diferentes tweaks del sistema
- Mejorar el rendimiento del equipo
- Optimizar y prolongar la vida de los discos SSD
- Desinstalar aplicaciones basura de Windows 10
- Eliminar el Telemetry y el Spyware de Windows 10
- Eliminar Microsoft One Drive
- Eliminar Microsoft Cortana
- Eliminar Windows Defender
- Configurar Windows Update
- Optiones de licencia y CD-key de Windows 10
- Y un laaargo etc...

## Instalar y utilizar el script

Realmente el script no necesita instalación, simplemente accedemos a la zona de *releases* y descargamos la versión deseada. Recomiendo siempre la versión más actualizada:

[Download win10script](https://github.com/aikoncwd/win10script/tree/master/releases)

Descomprimimos el fichero y situamos el script en cualquier carpeta (Mis Documentos, por ejemplo). Hacemos doble click y el script se iniciará. Para utilizar el script simplemente hemos de leer las opciones del menú y escribir el número/opción deseado. Todas las opciones del script se pueden revertir desde el menú de restauración.

## (1) System Tweaks

Permite personalizar el aspecto de tu Windows 10, habilitando o deshabilitando algunas características ocultas:

    # Deshabilitar 'Acceso Rapido' como opcion por defecto en Explorer?
    # Crear icono 'Modo Dios' en el Escritorio?
    # Habilitar el tema oscuro de Windows 'Dark Theme'?
    # Mostrar icono 'Mi PC' en el Escritorio?
    # Mostrar siempre la extension para archivos conocidos?
    # Deshabilitar 'Lock Screen'?
    # Forzar 'Vista Clasica' en el Panel de Control?
    # Deshabilitar 'Reporte de Errores' de Windows?
    # Abrir cmd.exe al pulsar Win+U?
    # Habilitar/Deshabilitar el control de cuentas de usuario UAC?
    # Habilitar/Deshabilitar el inicio de sesion sin password?
    # Utilizar control de volumen clasico?
    # Utilizar el centro de notificaciones clasico?
    # Utilizar el visor de fotos clasico?

Utiliza las teclas *s* y *n* para indicar si quieres habilitar o no cada opción.

## (2) Perfomance Tweaks

Permite deshabilitar funciones poco utilizadas y reducir el consumo de recursos del sistema:

![](http://i.imgur.com/eQvUyHp.png)

Encontrarás una opción para deshabilitar wl Wifi. **Si tu PC utiliza conexión Wifi para acceder a Internet (por ejemplo un portátil), no desactives el Wifi.** Ésta opción solo es recomendable para equipos de sobremesa que utilicen cable ethernet para conectarse.

**El proceso de cambiar la configuración de compresión de ficheros es lento.** Si decides utilizar esa opción deberás esperar varios minutos hasta que el proceso termine.

Deshabilitar el **CPU Core Parking** puede evitar cuellos de botella en algunas aplicaciones y juegos, pero incrementará ligeramente la electricidad consumida por tu CPU.

## (3) Optimizar discos SSD

Éste conjunto de opciones permiten mejorar y prolongar la vida de tus **discos SSD**. Utiliza ésta opción si tienes Windows 10 instalado en un disco SSD:

    > Habilitar TRIM
    > Deshabilitar VSS (Shadow Copy)
    > Deshabilitar Windows Search
    > Deshabilitar Servicios de Indexacion
    > Deshabilitar defragmentador de discos
    > Deshabilitar hibernacion del sistema 
    > Deshabilitar Prefetcher + Superfetch
    > Deshabilitar ClearPageFileAtShutdown + LargeSystemCache

Al utilizar ésta opción, se deshabilita el sistema de **Shadow Copies** (no podrás usar Restaurar Sistema en caso de fallo o virus!) y el servicio de **Buscador/Indexación** (no podrás usar el buscador del menú inicio). Dichas opciones pueden ser restauradas a mano desde el menú de restauración (opción 99). Si deseas optimizar tu **SSD** pero deseas mantener las opciones del buscador de Windows y Restaurar Sistema, haz lo siguiente:

1. Opción (3): Aplica optimización de SSD
2. Opción (99): Menu restaurar
3. Opción (7): Restaura Shadow Copies
4. Opción (8): Restaura Indexación
5. Opción (0): Salir de Restore Menu
6. Opción (0): Salir del script
7. Reiniciar tu PC

## (4) Desinstalar Windows MetroApps

Windows 10 trae preinstalados muchos programas en el menú táctil/metro. El 99% de los casos, esos programas no los utilizarás y ocupan memória en tu disco duro. El listado es el siguiente:

    > Bing, Zune, Skype, XboxApp
    > Getstarted, Messagin, 3D Builder
    > Windows Maps, Phone, Camera, Alarms, People
    > Windows Communications Apps, Sound Recorder
    > Microsoft Office Hub, Office Sway, OneNote
    > Solitaire Collection, CandyCrushSaga

Utiliza ésta opción y todas las aplicaciones serán desinstaladas. El proceso dura varios minutos (aparecerán pantallas azules), espera a que termine todo el proceso. El proceso de desinstalar las MetroApps, es irreversible.

## (5) Elimina todo el Spyware y Telemetry de Win10

Poco más que añadir, ésta opción te permite eliminar todo el telemetry de Windows 10. Si lo deseas puedes revertir los cambios para volver a habilitar el Telemetry. Con ésta nueva opción del script, Cortana no se deshabilita de forma predeterminada.

Además se descargará un fichero hosts personalizado que bloquea todos los servidores de spyware/telemetry de Windows 10, así como los principales dominios de publicidad y adware de Internet.

## (6) Microsoft OneDrive

Si no utilizas el servicio de OneDrive recomiendo deshabilitarlo. Si desinstalas OneDrive recuerda que la opción no es reversible

## (7) Microsoft Cortana

¿Utilizas Cortana como asistente personal? No? Pues ahorra algo de espacio y recursos deshabilitando o desinstalando Cortana. Desinstalar Cortana es una función algo compleja, para restaurar Cortana en un futuro deberás usar la opción (4) para ejecutar un `sfc.exe /scannow`, ésta opción suele demorar varios minutos (incluso 1 hora), así que prepara el tiempo con antelación.

## (8) Windows Defender

Con ésta opción podrás deshabilitar Windows Defender de forma definitiva. De ésta forma podrás instalar otro Antivirus de tu preferencia. Si decides deshabilitar Windows Defender asegurate de instalar otra solución antivirus, yo te recomiendo:

- 360 Total Security
- Avira Antivirus
- Avast! Antivirus
- AVG Antivirus

## (9) Windows Updater

Podrás personalizar de que modo quieres que tu Windows 10 se actualice, las opciones posibles son:

    # Deshabilitar 'Windows Auto Update'? (s/n) > n
    # Deshabilitar 'Windows Update Sharing'? (s/n) > n
    # Deshabilitar 'Windows Update App'? (s/n) > n
    # Deshabilitar 'Windows Update Driver'? (s/n) > n

Utiliza las teclas *s* y *n* para indicar si quieres habilitar o no cada opción.

## (10) Opciones de Licencia Windows 10

Desde aquí podrás 3 útiles opciones relacionadas con la activación y licencia de tu Windows 10:

1. Mostrar estado d ela licencia; Un sencillo script mostrará si tienes activado correctamente tu Windows 10, aquí un ejemplo de un Windows correctamente actualizado:

![](http://i.imgur.com/jflOhlW.png)

2. Mostrar la licencia y cd-key instalada. Compatible con OEM; Un sencillo programa te mostrará tu licencia actual, incluso se has upgradeado desde una versión anterior de Windows:

![](http://i.imgur.com/7G3scY3.png)

3. Activar tu Windows 10 (también sirve para Office); Un sencillo activador KMS para activar y licenciar tu Windows 10. Requiere una constraseña para evitar un mal uso.

## (11) Atajos de teclado para Windows 10

to be continued...