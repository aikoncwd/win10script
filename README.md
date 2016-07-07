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

![](http://i.imgur.com/vclpm3y.png)

Utiliza las teclas *s* y *n* para indicar si quieres habilitar o no cada opción.

## (2) Perfomance Tweaks

Permite deshabilitar funciones poco utilizadas y reducir el consumo de recursos del sistema:

![](http://i.imgur.com/eQvUyHp.png)

La cuarta opción permite deshabilitar el Wifi, no utilices esa opción si estás en un portátil o si tu conexión a internet depende de algún sistema Wifi. Solo recomendable para equipos de sobremesa con cable ethernet.  
El proceso de cambiar la configuración de compresión de ficheros es lento. Si decides utilizar esa opción deberás esperar varios minutos hasta que el proceso termine.  
Deshabilitar el CPU Core Parking puede evitar cuellos de botella en algunas aplicaciones y juegos, pero incrementará ligeramente la electricidad consumida por tu CPU.

## (3) Optimizar discos SSD

Éste conjunto de opciones permiten mejorar y prolongar la vida de tus discos SSD. Utiliza ésta opción si tienes Windows 10 instalado en un disco SSD:

    > Habilitar TRIM
    > Deshabilitar VSS (Shadow Copy)
    > Deshabilitar Windows Search
    > Deshabilitar Servicios de Indexacion
    > Deshabilitar defragmentador de discos
    > Deshabilitar hibernacion del sistema 
    > Deshabilitar Prefetcher + Superfetch
    > Deshabilitar ClearPageFileAtShutdown + LargeSystemCache

Al utilizar ésta opción, se deshabilita el sistema de *Shadow Copies* (no podrás usar Restaurar Sistema) y el servicio de Buscador/Indexación (no podrás usar el buscador del menú inicio). Dichas opciones pueden ser restauradas a mano desde el menú de restauración (opción 99)

## (4) Desinstalar Windows MetroApps

Windows 10 trae preinstalados muchos programas en el menú táctil/metro. El listado es el siguiente:

    > Bing, Zune, Skype, XboxApp
    > Getstarted, Messagin, 3D Builder
    > Windows Maps, Phone, Camera, Alarms, People
    > Windows Communications Apps, Sound Recorder
    > Microsoft Office Hub, Office Sway, OneNote
    > Solitaire Collection, CandyCrushSaga

Utiliza ésta opción y todas las aplicaciones serán desinstaladas.

## (5) Elimina todo el Spyware y Telemetry de Win10

Paco más que añadir, ésta opción te permite eliminar todo el telemetry de Windows 10. Si lo deseas puedes revertir los cambios para volver a habilitar el Telemetry. Con ésta nueva opción del script, Cortana no se deshabilita de form apredeterminada.

## (6) Microsoft OneDrive

Si no utilizas el servicio de OneDrive recomiendo deshabilitarlo. Si desinstalas OneDrive recuerda que la opción no es reversible
