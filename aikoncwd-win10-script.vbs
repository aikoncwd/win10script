On Error Resume Next
Randomize

Set oADO = CreateObject("Adodb.Stream")
Set oWSH = CreateObject("WScript.Shell")
Set oAPP = CreateObject("Shell.Application")
Set oFSO = CreateObject("Scripting.FileSystemObject")
Set oWEB = CreateObject("MSXML2.ServerXMLHTTP")
Set oVOZ = CreateObject("SAPI.SpVoice")
Set oWMI = GetObject("winmgmts:\\.\root\CIMV2")

currentVersion = "5.5"
currentFolder  = oFSO.GetParentFolderName(WScript.ScriptFullName)

Call ForceConsole()
Call showBanner()
Call printf(" Comprobando sistema Windows 10 y privilegios...")
Call checkW10()
Call runElevated()
Call printf(" Privilegios de Administrador OK!")
Call printf(" Comprobando actualizaciones en GitHub...")
Call updateCheck()
Call showMenu(1)

Function showBanner()
	printf " _____ _ _           _____         _    _____         _     _   "
	printf "|  _  |_| |_ ___ ___|     |_ _ _ _| |  |   __|___ ___|_|___| |_ "
	printf "|     | | '_| . |   |   --| | | | . |  |__   |  _|  _| | . |  _|"
	printf "|__|__|_|_,_|___|_|_|_____|_____|___|  |_____|___|_| |_|  _|_|  "
	printf "                                                       |_|     v" & currentVersion
End Function

Function showMenu(n)
	wait(n)
	cls
	Call showBanner
	printf " Selecciona una opcion:"
	printf ""
	printf "   1 = Activar/Desactivar varios tweaks de sistema"
	printf "   2 = Activar/Desactivar varios tweaks para mejorar el rendimiento"
	printf "   3 = Optimizar y prolongar la vida de tu disco duro SSD"
	printf "   4 = Desinstalar MetroApps de Windows 10 pre-instaladas"
	printf ""
	printf "   5 = Impedir que se envien datos a Microsoft (Spyware & Telemetry)"
	printf "   6 = Configurar Microsoft One Drive"
	printf "   7 = Configurar Microsoft Cortana"
	printf "   8 = Configurar Windows Defender"
	printf "   9 = Configurar Windows Update"
	printf ""
	printf "  10 = Opciones de licencia de Windows 10"
	printf "  11 = Mostrar atajos de teclado utiles para Windows 10"
	printf ""
	printf "  99 = Restore Menu -> Restaurar modificaciones del script"
	printf " 999 = Colabora con el crecimiento de este script!"
	printf ""
	printf " 0 = Salir"
	printf ""
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " ERROR: Opcion invalida, solo se permiten numeros..."
		Call showMenu(2)
		Exit Function
	End If
	Select Case RP
		Case 1
			Call menuSysTweaks()
		Case 2
			Call menuPerfomance()
		Case 3
			Call menuPowerSSD()
		Case 4
			Call menuCleanApps()
		Case 5
			Call menuTelemetry()
		Case 6
			Call menuOneDrive()
		Case 7
			Call menuCortana()
		Case 8
			Call menuWindowsDefender()
		Case 9
			Call menuWindowsUpdate()
		Case 10
			Call menuLicense()
		Case 11
			Call showKeyboardTips()
		Case 99
			Call restoreMenu()
		Case 999
			Call donatePaypal()
		Case 0
			cls
			printf ""
			printf " Gracias por utilizar mi script :)"
			printf "                          AikonCWD"
			wait(1)
			If oFSO.FileExists(currentFolder & "\CPM.exe") = True then oFSO.DeleteFile(currentFolder & "\CPM.exe")
			If oFSO.FileExists(currentFolder & "\IWT.exe") = True then oFSO.DeleteFile(currentFolder & "\IWT.exe")
			If oFSO.FileExists(currentFolder & "\ACT.exe") = True then oFSO.DeleteFile(currentFolder & "\ACT.exe")
			If oFSO.FileExists(currentFolder & "\SKP.exe") = True then oFSO.DeleteFile(currentFolder & "\SKP.exe")
			If oFSO.FileExists(currentFolder & "\deleteOneDrive.bat") = True then oFSO.DeleteFile(currentFolder & "\deleteOneDrive.bat")
			If oFSO.FileExists(currentFolder & "\deleteCortana.bat") = True then oFSO.DeleteFile(currentFolder & "\deleteCortana.bat")
			If oFSO.FileExists(currentFolder & "\telemetryOFF.bat") = True then oFSO.DeleteFile(currentFolder & "\telemetryOFF.bat")
			If oFSO.FileExists(currentFolder & "\telemetryON.bat") = True then oFSO.DeleteFile(currentFolder & "\telemetryON.bat")
			If oFSO.FileExists(currentFolder & "\photoview.reg") = True then oFSO.DeleteFile(currentFolder & "\photoview.reg")
			WScript.Quit
		Case Else
			printf ""
			printf " INFO: Opcion invalida, ese numero no esta disponible"
			Call showMenu(2)
			Exit Function
	End Select
End Function

Function menuSysTweaks()
	cls
	On Error Resume Next
	printf ""
	printf " _____         _                _____               _       "
	printf "|   __|_ _ ___| |_ ___ _____   |_   _|_ _ _ ___ ___| |_ ___ "
	printf "|__   | | |_ -|  _| -_|     |    | | | | | | -_| .'| '_|_ -|"
	printf "|_____|_  |___|_| |___|_|_|_|    |_| |_____|___|_|_|_,_|___|"
	printf "      |___|                                                 "	
	printf ""
	printl " # Deshabilitar 'Acceso Rapido' como opcion por defecto en Explorer? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 1, "REG_DWORD"
	Else
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 2, "REG_DWORD"
	End If
	printl " # Crear icono 'Modo Dios' en el Escritorio? (s/n) > "
	If LCase(scanf) = "s" Then
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = False Then oFSO.CreateFolder(godFolder)
	Else
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = True Then oFSO.DeleteFolder(godFolder)	
	End If
	printl " # Habilitar el tema oscuro de Windows 'Dark Theme'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"		
	End If
	printl " # Mostrar icono 'Mi PC' en el Escritorio? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\{20D04FE0-3AEA-1069-A2D8-08002B30309D}", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\{20D04FE0-3AEA-1069-A2D8-08002B30309D}", 1, "REG_DWORD"
	End If
	printl " # Mostrar siempre la extension para archivos conocidos? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 1, "REG_DWORD"
	End If
	printl " # Deshabilitar 'Lock Screen'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization\NoLockScreen", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\Software\Policies\Microsoft\Windows\System\DisableLogonBackgroundImage", 1, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization\NoLockScreen", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\Software\Policies\Microsoft\Windows\System\DisableLogonBackgroundImage", 0, "REG_DWORD"
	End If
	printl " # Forzar 'Vista Clasica' en el Panel de Control? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 1, "REG_DWORD"
	Else
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 0, "REG_DWORD"
	End If
	printl " # Deshabilitar 'Reporte de Errores' de Windows? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\Disabled", 1, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\Disabled", 0, "REG_DWORD"
	End If
	printl " # Abrir cmd.exe al pulsar Win+U? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger", "cmd.exe", "REG_SZ"
	Else
		oWSH.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger"
	End If
	printl " # Habilitar/Deshabilitar el control de cuentas de usuario UAC? (s/n) > "
	If LCase(scanf) = "s" Then
		printf ""
		printf " Ahora se ejecutara una ventana..."
		printf " Mueve la barra vertical hasta el nivel mas bajo"
		printf " Acepta los cambios y reinicia el ordenador"
		wait(2)
		printf ""
		printf " > Executing UserAccountControlSettings.exe"
		oWSH.Run "UserAccountControlSettings.exe"
		printf ""
	End If
	printl " # Habilitar/Deshabilitar el inicio de sesion sin password? (s/n) > "
	If LCase(scanf) = "s" Then
		printf ""
		printf " Ahora se ejecutara una ventana..."
		printf " Desmarca la opcion: Los usuarios deben escribir su nombre y password para usar el equipo"
		printf " Acepta los cambios y reinicia el ordenador"
		wait(2)
		printf ""
		printf " > Executing control userpasswords2"
		oWSH.Run "control userpasswords2"
		printf ""
	End If
	printl " # Utilizar control de volumen clasico? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 1, "REG_DWORD"
	End If
	printl " # Utilizar el centro de notificaciones clasico? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\UseActionCenterExperience", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\UseActionCenterExperience", 1, "REG_DWORD"
	End If
	printl " # Utilizar el visor de fotos clasico? (s/n) > "
	If LCase(scanf) = "s" Then
		oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/photoview.reg", False
		oWEB.Send
		wait(1)
		Set F = oFSO.CreateTextFile(currentFolder & "\photoview.reg")
			F.Write oWEB.ResponseText
		F.Close
		wait(1)
		oWSH.Run "reg import " & currentFolder & "\photoview.reg"
	End If
	printf ""
	printf " >> Reiniciando el explorador de Windows... espera 5 segundos!"
	oWSH.Run "taskkill.exe /F /IM explorer.exe"
	wait(5)
	oWSH.Run "explorer.exe"
	printf ""
	printf " Todos los tweaks de sistema se han aplicado correctamente"
	Call showMenu(2)
End Function

Function menuOneDrive()
	cls
	On Error Resume Next	
	printf " _____ _                     ___ _      _____            ____      _         "
	printf "|     |_|___ ___ ___ ___ ___|  _| |_   |     |___ ___   |    \ ___|_|_ _ ___ "
	printf "| | | | |  _|  _| . |_ -| . |  _|  _|  |  |  |   | -_|  |  |  |  _| | | | -_|"
	printf "|_|_|_|_|___|_| |___|___|___|_| |_|    |_____|_|_|___|  |____/|_| |_|\_/|___|"                                                                         
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "  1 = Deshabilitar Microsoft One Drive"
	printf "  2 = Habilitar Microsoft One Drive"
	printf "  3 = Desinstalar Microsoft One Drive (!)"
	printf ""
	printf "  0 = Volver al menu principal"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Deshabilitando OneDrive..."
			wait(1)
				oWSH.Run "taskkill.exe /F /IM OneDrive.exe /T"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegDelete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\OneDrive"
			printf ""
			printf " INFO: OneDrive deshabilitado correctamente"
			wait(2)
		Case "2"
			printf ""
			printf " Habilitando OneDrive..."
			wait(1)
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
			printf ""
			printf " INFO: OneDrive habilitado correctamente"
			wait(2)
		Case "3"
			printf ""
			printl "  >> Desinstalar definitivamente OneDrive. Opcion no reversible. Continuar? (s/n) > "
			If scanf = "s" Then
				oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/deleteOneDrive.bat", False
				oWEB.Send
				wait(1)
				Set F = oFSO.CreateTextFile(currentFolder & "\deleteOneDrive.bat")
					F.Write oWEB.ResponseText
				F.Close
				oWSH.Run currentFolder & "\deleteOneDrive.bat"
			End If
		Case "0"
			Call showMenu(0)
		Case Else
			Call menuOneDrive()
	End Select
	Call menuOneDrive()
End Function

Function menuCortana()
	cls
	On Error Resume Next
	printf " _____ _                     ___ _      _____         _               "
	printf "|     |_|___ ___ ___ ___ ___|  _| |_   |     |___ ___| |_ ___ ___ ___ "
	printf "| | | | |  _|  _| . |_ -| . |  _|  _|  |   --| . |  _|  _| .'|   | .'|"
	printf "|_|_|_|_|___|_| |___|___|___|_| |_|    |_____|___|_| |_| |_|_|_|_|_|_|"                                                                  
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "  1 = Deshabilitar Microsoft Cortana"
	printf "  2 = Habilitar Microsoft Cortana"
	printf "  3 = Desinstalar Microsoft Cortana (!)"
	printf "  4 = Reinstalar Microsoft Cortana  (!)"
	printf ""
	printf "  0 = Volver al menu principal"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 0, "REG_DWORD"
			printf ""
			printf " >> Reiniciando el explorador de Windows... espera 5 segundos!"
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait(5)
			oWSH.Run "explorer.exe"
		Case "2"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 1, "REG_DWORD"
			printf ""
			printf " >> Reiniciando el explorador de Windows... espera 5 segundos!"
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait(5)
			oWSH.Run "explorer.exe"
		Case "3"
			printf ""
			printf "  >> Perderas la opcion de usar el buscador del menu inicio"
			printl "  >> Desinstalar definitivamente Cortana. Continuar? (s/n) > "
			If scanf = "s" Then
				oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/deleteCortana.bat", False
				oWEB.Send
				wait(1)
				Set F = oFSO.CreateTextFile(currentFolder & "\deleteCortana.bat")
					F.Write oWEB.ResponseText
				F.Close
				oWSH.Run currentFolder & "\deleteCortana.bat"			
			End If
		Case "4"
			printf ""
			printf "  >> Utiliza esta opcion SOLO si has desinstalado Cortana usando la opcion (3)"
			printl "  >> El proceso de reinstalacion de Cortana es lento..."
			printl "  >> Una vez finalizado el proceso, reinicia el PC. Continuar? (s/n) > "
			If scanf = "s" Then
				oWSH.Run "sfc /scannow"
			End If
		Case "0"
			Call showMenu(0)
		Case Else
			Call menuCortana()
	End Select
	Call menuCortana()
End Function

Function menuTelemetry()
	cls
	On Error Resume Next
	printf " _____                              _____     _               _           "
	printf "|   __|___ _ _ _ _ _ ___ ___ ___   |_   _|___| |___ _____ ___| |_ ___ _ _ "
	printf "|__   | . | | | | | | .'|  _| -_|    | | | -_| | -_|     | -_|  _|  _| | |"
	printf "|_____|  _|_  |_____|_|_|_| |___|    |_| |___|_|___|_|_|_|___|_| |_| |_  |"
	printf "      |_| |___|                                                      |___|"
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "  1 = Deshabilitar TODO el Telemetry"
	printf "  2 = Habilitar TODO el Telemetry"
	printf "  3 = Solucionar problemas con Skype"
	printf ""
	printf "  0 = Volver al menu principal"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Aplicando parches para deshabilitar Telemetry (10 segundos)..."
			oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/telemetryOFF.bat", False
			oWEB.Send
			wait(1)
			Set F = oFSO.CreateTextFile(currentFolder & "\telemetryOFF.bat")
				F.Write oWEB.ResponseText
			F.Close
			oWSH.Run currentFolder & "\telemetryOFF.bat"
			wait(9)
			printf " Deshabilitando Telemetry usando el registro..."
			wait(1)
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection\AllowTelemetry", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\AllowTelemetry", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..riencehost.appxmain_31bf3856ad364e35_10.0.10240.16384_none_0ab8ea80e84d4093\f!telemetry.js", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!dss-winrt-telemetry.js", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry.js", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry-event_8ac43a41e5030538", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry-inter_58073761d33f144b", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\MRT\DontOfferThroughWUAU", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\AITEnable", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows\CEIPEnable", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\DisableUAR", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata\PreventDeviceMetadataFromNetwork", 1, "REG_DWORD"		
			printf ""
			printf " INFO: Telemetry deshabilitado correctamente"
			pathLOG = oWSH.ExpandEnvironmentStrings("%ProgramData%") & "\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
			printf ""
			printf " Borrando DiagTrack Log..."
			wait(1)
				If oFSO.FileExists(pathLOG) Then oFSO.DeleteFile(pathLOG)
				oWSH.Run "cmd /C echo " & chr(34) & chr(34) & " > " & pathLOG
			printf ""
			printf " INFO: DiagTrack Log borrado correctamente"
			printf ""
			printf " Deshabilitando servicios de seguimiento..."
			wait(1)
				oWSH.Run "sc stop TrkWks"
				oWSH.Run "sc stop DiagTrack"
				oWSH.Run "sc stop RetailDemo"
				oWSH.Run "sc stop WMPNetworkSvc"
				oWSH.Run "sc stop dmwappushservice"
				oWSH.Run "sc stop diagnosticshub.standardcollector.service"
				oWSH.Run "sc config TrkWks start=disabled"
				oWSH.Run "sc config DiagTrack start=disabled"
				oWSH.Run "sc config RetailDemo start=disabled"
				oWSH.Run "sc config WMPNetworkSvc start=disabled"
				oWSH.Run "sc config dmwappushservice start=disabled"
				oWSH.Run "sc config diagnosticshub.standardcollector.service start=disabled"
			printf ""
			printf " INFO: Servicios de seguimiento deshabilitados"
			printf ""			
			printf " Deshabilitando tareas programadas que envian datos a Microsoft..."	
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Application Experience\ProgramDataUpdater" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\AppID\SmartScreenSpecific" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\NetTrace\GatherNetworkInfo" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Error Reporting\QueueReporting" & chr(34) & " /DISABLE"
			printf ""
			printf " INFO: Tareas programadas de seguimiento deshabilitadas"
			printf ""
			printf " Descargando listado actualizado para bloquear los servidores de publicidad de Microsoft..."
			wait(1)
			hostsFile = oWSH.ExpandEnvironmentStrings("%WinDir%") & "\System32\drivers\etc\hosts"
			If oFSO.FileExists(hostsFile & ".cwd") = False Then
				oWEB.Open "GET", "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts", False
				oWEB.Send
				wait(1)
				oFSO.CopyFile hostsFile, hostsFile & ".cwd"
				Set F = oFSO.OpenTextFile(hostsFile, 8, True)
					F.Write oWEB.ResponseText
				F.Close
				Set F = oFSO.OpenTextFile(hostsFile, 8, True)
					F.WriteLine "#Antimalware"
					F.WriteLine "0.0.0.0 tracking.opencandy.com.s3.amazonaws.com"
					F.WriteLine "0.0.0.0 media.opencandy.com"
					F.WriteLine "0.0.0.0 cdn.opencandy.com"
					F.WriteLine "0.0.0.0 tracking.opencandy.com"
					F.WriteLine "0.0.0.0 api.opencandy.com"
					F.WriteLine "0.0.0.0 api.recommendedsw.com"
					F.WriteLine "0.0.0.0 installer.betterinstaller.com"
					F.WriteLine "0.0.0.0 installer.filebulldog.com"
					F.WriteLine "0.0.0.0 d3oxtn1x3b8d7i.cloudfront.net"
					F.WriteLine "0.0.0.0 inno.bisrv.com"
					F.WriteLine "0.0.0.0 nsis.bisrv.com"
					F.WriteLine "0.0.0.0 cdn.file2desktop.com"
					F.WriteLine "0.0.0.0 cdn.goateastcach.us"
					F.WriteLine "0.0.0.0 cdn.guttastatdk.us"
					F.WriteLine "0.0.0.0 cdn.inskinmedia.com"
					F.WriteLine "0.0.0.0 cdn.insta.oibundles2.com"
					F.WriteLine "0.0.0.0 cdn.insta.playbryte.com"
					F.WriteLine "0.0.0.0 cdn.llogetfastcach.us"
					F.WriteLine "0.0.0.0 cdn.montiera.com"
					F.WriteLine "0.0.0.0 cdn.msdwnld.com"
					F.WriteLine "0.0.0.0 cdn.mypcbackup.com"
					F.WriteLine "0.0.0.0 cdn.ppdownload.com"
					F.WriteLine "0.0.0.0 cdn.riceateastcach.us"
					F.WriteLine "0.0.0.0 cdn.shyapotato.us"
					F.WriteLine "0.0.0.0 cdn.solimba.com"
					F.WriteLine "0.0.0.0 cdn.tuto4pc.com"
					F.WriteLine "0.0.0.0 cdn.appround.biz"
					F.WriteLine "0.0.0.0 cdn.bigspeedpro.com"
					F.WriteLine "0.0.0.0 cdn.bispd.com"
					F.WriteLine "0.0.0.0 cdn.bisrv.com"
					F.WriteLine "0.0.0.0 cdn.cdndp.com"
					F.WriteLine "0.0.0.0 cdn.download.sweetpacks.com"
					F.WriteLine "0.0.0.0 cdn.dpdownload.com"
					F.WriteLine "0.0.0.0 cdn.visualbee.net"
					F.WriteLine "#Telemetry"
					F.WriteLine "0.0.0.0 vortex.data.microsoft.com"
					F.WriteLine "0.0.0.0 vortex-win.data.microsoft.com"
					F.WriteLine "0.0.0.0 telecommand.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 telecommand.telemetry.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 oca.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 oca.telemetry.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 sqm.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 watson.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 watson.telemetry.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 redir.metaservices.microsoft.com"
					F.WriteLine "0.0.0.0 choice.microsoft.com"
					F.WriteLine "0.0.0.0 choice.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 df.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 wes.df.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 reports.wes.df.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 services.wes.df.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 sqm.df.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 watson.ppe.telemetry.microsoft.com"
					F.WriteLine "0.0.0.0 telemetry.appex.bing.net"
					F.WriteLine "0.0.0.0 telemetry.urs.microsoft.com"
					F.WriteLine "0.0.0.0 telemetry.appex.bing.net:443"
					F.WriteLine "0.0.0.0 settings-sandbox.data.microsoft.com"
					F.WriteLine "0.0.0.0 vortex-sandbox.data.microsoft.com"
					F.WriteLine "0.0.0.0 survey.watson.microsoft.com"
					F.WriteLine "0.0.0.0 watson.live.com"
					F.WriteLine "0.0.0.0 watson.microsoft.com"
					F.WriteLine "0.0.0.0 statsfe2.ws.microsoft.com"
					F.WriteLine "0.0.0.0 corpext.msitadfs.glbdns2.microsoft.com"
					F.WriteLine "0.0.0.0 compatexchange.cloudapp.net"
					F.WriteLine "0.0.0.0 cs1.wpc.v0cdn.net"
					F.WriteLine "0.0.0.0 a-0001.a-msedge.net"
					F.WriteLine "0.0.0.0 statsfe2.update.microsoft.com.akadns.net"
					F.WriteLine "0.0.0.0 sls.update.microsoft.com.akadns.net"
					F.WriteLine "0.0.0.0 fe2.update.microsoft.com.akadns.net"
					F.WriteLine "0.0.0.0 diagnostics.support.microsoft.com"
					F.WriteLine "0.0.0.0 corp.sts.microsoft.com"
					F.WriteLine "0.0.0.0 statsfe1.ws.microsoft.com"
					F.WriteLine "0.0.0.0 pre.footprintpredict.com"
					F.WriteLine "0.0.0.0 i1.services.social.microsoft.com"
					F.WriteLine "0.0.0.0 i1.services.social.microsoft.com.nsatc.net"
					F.WriteLine "0.0.0.0 feedback.windows.com"
					F.WriteLine "0.0.0.0 feedback.microsoft-hohm.com"
					F.WriteLine "0.0.0.0 feedback.search.microsoft.com"
				F.Close
				printf ""
				printf " INFO: Fichero HOSTS escrito correctamente"
			End If
			wait(2)
		Case "2"
			oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/telemetryON.bat", False
			oWEB.Send
			wait(1)
			Set F = oFSO.CreateTextFile(currentFolder & "\telemetryON.bat")
				F.Write oWEB.ResponseText
			F.Close
			oWSH.Run currentFolder & "\telemetryON.bat"
		Case "3"
			oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/dependencias/telemetryON.bat", False
			oWEB.Send
			wait(1)
			Set F = oFSO.CreateTextFile(currentFolder & "\telemetryON.bat")
				F.Write oWEB.ResponseText
			F.Close
			oWSH.Run currentFolder & "\telemetryON.bat"
		Case "0"
			Call showMenu(0)
		Case Else
			Call menuTelemetry()
	End Select
	Call menuTelemetry()
End Function

Function menuWindowsDefender()
	cls
	On Error Resume Next
	printf " _ _ _ _       _                  ____      ___           _         "
	printf "| | | |_|___ _| |___ _ _ _ ___   |    \ ___|  _|___ ___ _| |___ ___ "
	printf "| | | | |   | . | . | | | |_ -|  |  |  | -_|  _| -_|   | . | -_|  _|"
	printf "|_____|_|_|_|___|___|_____|___|  |____/|___|_| |___|_|_|___|___|_|  "
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "  1 = Deshabilitar Microsoft Windows Defender"
	printf "  2 = Habilitar Microsoft Windows Defender"
	printf ""
	printf "  0 = Volver al menu principal"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Deshabilitando Windows Defender usando el registro..."
			wait(1)
				oWSH.Run "sc stop WdNisSvc"
				oWSH.Run "sc stop WinDefend"
				oWSH.Run "sc config WdNisSvc start=disabled"
				oWSH.Run "sc config WinDefend start=disabled"	
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"
			printf ""
			printf " INFO: Windows Defender deshabilitado correctamente"
			printf " WARNING: Si no tienes antivirus, te recomiendo 360 Total Security: www.360totalsecurity.com"
			wait(3)
		Case "2"
			printf ""
			printf " Habilitando Windows Defender usando el registro..."
			wait(1)
				oWSH.Run "sc config WdNisSvc start=auto"
				oWSH.Run "sc config WinDefend start=auto"	
				oWSH.Run "sc start WdNisSvc"
				oWSH.Run "sc start WinDefend"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /ENABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /ENABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /ENABLE"
				oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /ENABLE"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 1, "REG_DWORD"
			printf ""
			printf " INFO: Windows Defender habilitado correctamente"
			wait(2)
		Case "0"
			Call showMenu(0)
		Case Else
			Call menuWindowsDefender()
	End Select
	Call menuWindowsDefender()
End Function

Function menuWindowsUpdate()
	cls
	On Error Resume Next
	printf " _ _ _ _       _                  _____       _     _       "
	printf "| | | |_|___ _| |___ _ _ _ ___   |  |  |___ _| |___| |_ ___ "
	printf "| | | | |   | . | . | | | |_ -|  |  |  | . | . | .'|  _| -_|"
	printf "|_____|_|_|_|___|___|_____|___|  |_____|  _|___|_|_|_| |___|"
	printf "                                       |_|                  "
	printf ""
	printl " # Deshabilitar 'Windows Auto Update'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\DeferUpgrade", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions", 2, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\NoAutoUpdate", 1, "REG_DWROD"
		oWSH.Run "sc stop wuauserv"
		oWSH.Run "sc config wuauserv start=disabled"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\DeferUpgrade", 0, "REG_DWORD"
		oWSH.RegDelete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\NoAutoUpdate", 0, "REG_DWROD"
		oWSH.Run "sc config wuauserv start=auto"
		oWSH.Run "sc start wuauserv"
	End If
	printl " # Deshabilitar 'Windows Update Sharing'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DownloadMode", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DODownloadMode", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\SystemSettingsDownloadMode", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DownloadMode", 3, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DODownloadMode", 3, "REG_DWORD"
		oWSH.RegDelete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\SystemSettingsDownloadMode"
	End If
	printl " # Deshabilitar 'Windows Update App'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate\AutoDownload", 2, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate\AutoDownload", 4, "REG_DWORD"
	End If
	printl " # Deshabilitar 'Windows Update Driver'? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching\DontSearchWindowsUpdate", 1, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching\DontSearchWindowsUpdate", 0, "REG_DWORD"
	End If
	printf ""
	printf "Todos los tweaks de Windows Update se han aplicado correctamente"
	Call showMenu(2)
End Function

Function menuPerfomance()
	cls
	On Error Resume Next
	printf " _____         ___                              _____               _   "
	printf "|  _  |___ ___|  _|___ _____ ___ ___ ___ ___   |_   _|_ _ _ ___ ___| |_ "
	printf "|   __| -_|  _|  _| . |     | .'|   |  _| -_|    | | | | | | -_| .'| '_|"
	printf "|__|  |___|_| |_| |___|_|_|_|_|_|_|_|___|___|    |_| |_____|___|_|_|_,_|"                                                                        
	printf ""
	printl " # Desinstalar WindowsFeedbackReport y WindowsContactSupport? (s/n) > "
	If LCase(scanf) = "s" Then
		oWEB.Open "GET", "https://github.com/aikoncwd/win10script/raw/master/dependencias/exe/install_wim_tweak.exe", False
		oWEB.Send
		oADO.Type = 1
		oADO.Open
		oADO.Write oWEB.ResponseBody
		oADO.SaveToFile currentFolder & "\IWT.exe", 2
		oADO.Close
		wait(3)
		oWSH.Run currentFolder & "\IWT.exe /o /l"
		oWSH.Run currentFolder & "\IWT.exe /o /c Microsoft-Windows-ContactSupport /r"
		oWSH.Run currentFolder & "\IWT.exe /o /c Microsoft-WindowsFeedback /r"
		oWSH.Run currentFolder & "\IWT.exe /h /o /l"
		wait(3)
		oFSO.DeleteFile(currentFolder & "\IWT.exe")
	End If
	printl " # Acelerar el cierre de aplicaciones y servicios? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKCU\Control Panel\Desktop\WaitToKillAppTimeout", 1000, "REG_SZ"
		oWSH.RegWrite "HKCU\Control Panel\Desktop\AutoEndTasks", 1, "REG_SZ"
		oWSH.RegWrite "HKCU\Control Panel\Desktop\HungAppTimeout", 1000, "REG_SZ"
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\WaitToKillServiceTimeout", 1000, "REG_SZ"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize\StartupDelayInMSec", 0, "REG_DWORD"
	End If
	printl " # Deshabilitar servicios: BitLocker, Cifrado y OfflineFiles? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.Run "sc config BDESVC start=disabled"
		oWSH.Run "sc config EFS start=disabled"
		oWSH.Run "sc config CscService start=disabled"
		oWSH.Run "sc stop BDESVC"
		oWSH.Run "sc stop EFS"
		oWSH.Run "sc stop CscService"
	Else
		oWSH.Run "sc config BDESVC start=auto"
		oWSH.Run "sc config EFS start=auto"
		oWSH.Run "sc config CscService start=auto"
		oWSH.Run "sc start BDESVC"
		oWSH.Run "sc start EFS"
		oWSH.Run "sc start CscService"
	End If
	printf ""
	printf " >> No utilizar si usas un portatil o Wifi <<"
	printf ""
	printl " # Deshabilitar servicios Wifi? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.Run "sc config WlanSvc start=disabled"
		oWSH.Run "sc stop WlanSvc"
	Else
		oWSH.Run "sc config WlanSvc start=auto"
		oWSH.Run "sc start WlanSvc"
	End If
	printl " # Ejecutar limpiador de Windows. Libera espacio y borrar Windows.old (s/n) > "
	If LCase(scanf) = "s" Then	
		printf ""
		printf " Ahora se ejecutara una ventana..."
		printf " Marca las opciones deseadas de limpieza"
		printf " Acepta los cambios y reinicia el ordenador"
		wait(2)
		printf ""
		printf " > Executing cleanmgr.exe"
		oWSH.Run "cleanmgr.exe"
		printf ""
	End If
	printl " # Instalar/Desinstalar caracteristicas adicionales de Windows (s/n) > "
	If LCase(scanf) = "s" Then
		printf ""
		printf " Ahora se ejecutara una ventana..."
		printf " Marca/Desmarca las opciones deseadas"
		printf " Acepta los cambios y reinicia el ordenador"
		wait(2)
		printf ""
		printf " > Executing optionalfeatures.exe"
		oWSH.Run "optionalfeatures.exe"
		printf ""
	End If
	printl " # Cambiar la configuracion de la compresion de ficheros? (tarda un poco!) (s/n) > "
	If LCase(scanf) = "s" Then
		printl " -> Deshabilitar la compresion de ficheros en el disco duro principal? (s/n) > "
		If LCase(scanf) = "s" Then
			oWSH.Run "compact /CompactOs:never"
		Else
			oWSH.Run "compact /CompactOs:always"
		End If
		wait(3)
	End If
	printl " # Habilitar el 100% del ancho de banda para el sistema? (s/n) > "
	If LCase(scanf) = "s" Then
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 0, "REG_DWORD"
	Else
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 20, "REG_DWORD"
	End If
	printl " # Modificar la configuracion de 'CPU Core Parking'? (s/n) > "
	If LCase(scanf) = "s" Then
		printf ""
		printf "  ---------------------------------------------------------------------"
		printf "  | Por defecto, Windows aparca los cores de tu CPU cuando no hay una |"
		printf "  | alta demanda de trabajo. Deshabilitar el Core Parking obliga a tu |"
		printf "  | CPU a trabajar a su maxima velocidad.                             |"
		printf "  |                                                                   |"
		printf "  | Tambien aumenta ligeramente el consumo electrico de tu PC         |"
		printf "  |                                                                   |"
		printf "  | Se va a descargar un programa, mueve la barra al 100% y pulsa     |"
		printf "  | aplicar.                                                          |"
		printf "  |                                                                   |"
		printf "  | > Pulsa una INTRO para continuar...                               |"
		printf "  ---------------------------------------------------------------------"
		scanf
		printf " >> Descargando CPM.exe desde las dependencias de GitHub..."
		oWEB.Open "GET", "https://github.com/aikoncwd/win10script/raw/master/dependencias/exe/CPM.exe", False
		oWEB.Send
		oADO.Type = 1
		oADO.Open
		oADO.Write oWEB.ResponseBody
		oADO.SaveToFile currentFolder & "\CPM.exe", 2
		oADO.Close
		wait(3)
		printf " >> Ejecutando CPM.exe..."
		oWSH.Run currentFolder & "\CPM.exe"
	End If
	printf ""
	printf " Todos los tweaks de sistema se han aplicado correctamente"	
	showMenu(3)
End Function

Function menuPowerSSD()
	cls
	On Error Resume Next
	printf " _____ _____ ____  _____     _   _       _             "
	printf "|   __|   __|    \|     |___| |_|_|_____|_|___ ___ ___ "
	printf "|__   |__   |  |  |  |  | . |  _| |     | |- _| -_|  _|"
	printf "|_____|_____|____/|_____|  _|_| |_|_|_|_|_|___|___|_|  "
	printf "                        |_|                            "
	printf ""
	printf " Este script va a modificar las siguientes configuraciones:"
	printf ""
	printf "  > Habilitar TRIM"
	printf "  > Deshabilitar VSS (Shadow Copy)"
	printf "  > Deshabilitar Windows Search"
	printf "  > Deshabilitar Servicios de Indexacion"
	printf "  > Deshabilitar defragmentador de discos"
	printf "  > Deshabilitar hibernacion del sistema"
	printf "  > Deshabilitar Prefetcher + Superfetch"
	printf "  > Deshabilitar ClearPageFileAtShutdown + LargeSystemCache"
	printf ""
	printl "  # Deseas continuar y aplicar los cambios? (s/n) "	
	If scanf = "s" Then
		printf ""
		oWSH.Run "fsutil behavior set disabledeletenotify 0"
		printf " # TRIM habilitado"
		wait(1)
		oWSH.Run "vssadmin Delete Shadows /All /Quiet"
		oWSH.Run "sc stop VSS"
		oWSH.Run "sc config VSS start=disabled"
		printf " # Shadow Copy eliminada y deshabilitada"
		wait(1)
		oWSH.Run "sc stop WSearch"
		oWSH.Run "sc config WSearch start=disabled"
		printf " # Windows Search + Indexing Service deshabilitados"
		wait(1)
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction\OptimizeComplete", "No"
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction\Enable", "N"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Defrag\ScheduledDefrag" & chr(34) & " /DISABLE"
		printf " # Defragmentador de disco deshabilitado"
		wait(1)		
		oWSH.Run "powercfg -h off"
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power\HiberbootEnabled", 0, "REG_DWORD"
		printf " # Hibernacion deshabilitada"
		wait(1)
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnablePrefetcher", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnableSuperfetch", 0, "REG_DWORD"
		oWSH.Run "sc stop SysMain"
		oWSH.Run "sc config SysMain start=disabled"
		printf " # Prefetcher + Superfetch deshabilitados"
		wait(1)
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\LargeSystemCache", 0, "REG_DWORD"
		printf " # ClearPageFileAtShutdown + LargeSystemCache deshabilitados"
		wait(1)
		printf ""
		printf " INFO: Felicidades, acabas de prolongar la vida y el rendimiento de tu SSD"
		printf "       Es recomendable que reinicies tu PC para aplicar cambios..."
	Else
		printf ""
		printf " INFO: Operacion cancelada por el usuario"
	End If
	Call showMenu(3)
End Function

Function menuLicense()
	cls
	On Error Resume Next
	printf " _ _ _ _       _                  __    _                     "
	printf "| | | |_|___ _| |___ _ _ _ ___   |  |  |_|___ ___ ___ ___ ___ "
	printf "| | | | |   | . | . | | | |_ -|  |  |__| |  _| -_|   |_ -| -_|"
	printf "|_____|_|_|_|___|___|_____|___|  |_____|_|___|___|_|_|___|___|"
	printf ""
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "  1 = Mostrar estado de la activacion de Windows 10"
	printf "  2 = Mostrar el cd-key actual de Win10 (OEM compatible)"
	printf "  3 = Activar Windows 10 / Microsoft Office con KMS"
	printf ""
	printf "  0 = Volver al menu principal"
	printf ""
	printl "  > "
	s = scanf
	Select Case s
		Case "1"
			printf ""
			printf " En unos segundos aparecera el estado de tu activacion..."
			oWSH.Run "slmgr.vbs /dli"
			oWSH.Run "slmgr.vbs /xpr"
			wait(2)
		Case "2"
			printf ""
			printf " >> Descargando SKP.exe desde las dependencias de GitHub..."
			oWEB.Open "GET", "https://github.com/aikoncwd/win10script/raw/master/dependencias/exe/SKP.exe", False
			oWEB.Send
			oADO.Type = 1
			oADO.Open
			oADO.Write oWEB.ResponseBody
			oADO.SaveToFile currentFolder & "\SKP.exe", 2
			oADO.Close
			wait(3)
			printf " >> Ejecutando SKP.exe..."
			oWSH.Run currentFolder & "\SKP.exe"
		Case "3"
			Execute(chr(166-54)& chr(169-55)& chr(12+93)& chr(1650/15)& chr(21+95)& chr(176-74)& chr(320/10)& chr(3094/91)& chr(2244/66)& chr(-35+48)& chr(31-21)& chr(171-59)& chr(139-25)& chr(15*7)& chr(125-15)& chr(11252/97)& chr(8316/77)& chr(-42+74)& chr(2312/68)& chr(4+28)& chr(3220/92)& chr(103-71)& chr(6*15)& chr(46+65)& chr(2200/20)& chr(970/10)& chr(224/7)& chr(1640/20)& chr(146-45)& chr(5290/46)& chr(139-23)& chr(18+96)& chr(89+16)& chr(58+52)& chr(167-64)& chr(7*15)& chr(8600/86)& chr(5820/60)& chr(123-64)& chr(125-93)& chr(-25+98)& chr(10670/97)& chr(40+76)& chr(101+13)& chr(3552/32)& chr(600/6)& chr(4095/35)& chr(7227/73)& chr(94+7)& chr(-33+65)& chr(158-57)& chr(3996/37)& chr(-18+50)& chr(3024/27)& chr(4+93)& chr(171-56)& chr(164-49)& chr(60+59)& chr(188-77)& chr(84+30)& chr(9500/95)& chr(8*4)& chr(2*56)& chr(171-74)& chr(168-54)& chr(139-42)& chr(704/22)& chr(133-34)& chr(7437/67)& chr(157-47)& chr(5104/44)& chr(143-38)& chr(22*5)& chr(216-99)& chr(124-27)& chr(91+23)& chr(22+10)& chr(109-47)& chr(2272/71)& chr(884/26)& chr(273/21)& chr(580/58)& chr(72+40)& chr(16*2)& chr(4392/72)& chr(130-98)& chr(122-7)& chr(32+67)& chr(22+75)& chr(67+43)& chr(6426/63)& chr(-30+43)& chr(730/73)& chr(4964/68)& chr(7+95)& chr(119-87)& chr(18+94)& chr(1*32)& chr(155-94)& chr(54-22)& chr(-20+54)& chr(84+29)& chr(60+59)& chr(28+73)& chr(570/5)& chr(1508/13)& chr(2420/20)& chr(1029/21)& chr(138-88)& chr(3723/73)& chr(3230/95)& chr(1696/53)& chr(183-99)& chr(22+82)& chr(124-23)& chr(9240/84)& chr(-62+75)& chr(620/62)& chr(9*1)& chr(134-22)& chr(74+40)& chr(62+43)& chr(55*2)& chr(157-41)& chr(61+41)& chr(1888/59)& chr(113-79)& chr(56-22)& chr(92-79)& chr(-74+84)& chr(621/69)& chr(3808/34)& chr(4902/43)& chr(97+8)& chr(144-34)& chr(82+34)& chr(3060/30)& chr(42-10)& chr(37-3)& chr(2848/89)& chr(4030/65)& chr(43-11)& chr(3876/57)& chr(3636/36)& chr(165-50)& chr(77+22)& chr(7857/81)& chr(6*19)& chr(171-68)& chr(4947/51)& chr(110*1)& chr(900/9)& chr(162-51)& chr(1728/54)& chr(126-51)& chr(1+76)& chr(141-58)& chr(37+9)& chr(129-83)& chr(-25+71)& chr(5+29)& chr(1053/81)& chr(520/52)& chr(-74+83)& chr(7437/67)& chr(696/8)& chr(131-62)& chr(3498/53)& chr(89-43)& chr(175-96)& chr(672/6)& chr(2424/24)& chr(75+35)& chr(-54+86)& chr(2*17)& chr(5538/78)& chr(1656/24)& chr(4620/55)& chr(89-55)& chr(-1+45)& chr(1760/55)& chr(-16+50)& chr(26*4)& chr(50+66)& chr(3828/33)& chr(210-98)& chr(8395/73)& chr(42+16)& chr(57-10)& chr(60-13)& chr(117-14)& chr(52+53)& chr(188-72)& chr(1456/14)& chr(29+88)& chr(154-56)& chr(68-22)& chr(119-20)& chr(4662/42)& chr(153-44)& chr(60-13)& chr(108-11)& chr(203-98)& chr(127-20)& chr(10989/99)& chr(30+80)& chr(107-8)& chr(150-31)& chr(11+89)& chr(4089/87)& chr(11186/94)& chr(93+12)& chr(21+89)& chr(245/5)& chr(35+13)& chr(82+33)& chr(5841/59)& chr(7752/68)& chr(9345/89)& chr(172-60)& chr(56+60)& chr(17+30)& chr(9462/83)& chr(5+92)& chr(125-6)& chr(141/3)& chr(85+24)& chr(75+22)& chr(105+10)& chr(133-17)& chr(7171/71)& chr(38+76)& chr(9+38)& chr(37+63)& chr(40+61)& chr(188-76)& chr(44+57)& chr(59+51)& chr(5500/55)& chr(23+78)& chr(9570/87)& chr(149-50)& chr(196-91)& chr(2813/29)& chr(163-48)& chr(92-45)& chr(65+36)& chr(8*15)& chr(113-12)& chr(3290/70)& chr(138-73)& chr(113-46)& chr(13+71)& chr(5+41)& chr(12+89)& chr(205-85)& chr(6060/60)& chr(54-20)& chr(69-25)& chr(2432/76)& chr(1610/23)& chr(7275/75)& chr(18*6)& chr(94+21)& chr(8686/86)& chr(65-52)& chr(-16+26)& chr(1*9)& chr(3219/29)& chr(177-90)& chr(4899/71)& chr(-32+98)& chr(2*23)& chr(6806/82)& chr(707/7)& chr(113-3)& chr(94+6)& chr(-81+94)& chr(450/45)& chr(-8+17)& chr(4551/41)& chr(31+34)& chr(88-20)& chr(5+74)& chr(29+17)& chr(-4+88)& chr(138-17)& chr(164-52)& chr(90+11)& chr(115-83)& chr(4575/75)& chr(2848/89)& chr(-33+82)& chr(455/35)& chr(330/33)& chr(49-40)& chr(1554/14)& chr(6370/98)& chr(-13+81)& chr(1738/22)& chr(3082/67)& chr(95-16)& chr(125-13)& chr(168-67)& chr(138-28)& chr(83-70)& chr(81-71)& chr(80-71)& chr(171-60)& chr(100-35)& chr(204/3)& chr(3476/44)& chr(2484/54)& chr(1653/19)& chr(118-4)& chr(45+60)& chr(40+76)& chr(79+22)& chr(-40+72)& chr(119-8)& chr(107-20)& chr(153-84)& chr(126-60)& chr(84-38)& chr(27+55)& chr(135-34)& chr(134-19)& chr(2016/18)& chr(8547/77)& chr(146-36)& chr(64+51)& chr(179-78)& chr(126-60)& chr(62+49)& chr(6100/61)& chr(58+63)& chr(10+3)& chr(660/66)& chr(1+8)& chr(191-80)& chr(5265/81)& chr(4964/73)& chr(3713/47)& chr(99-53)& chr(181-98)& chr(6+91)& chr(207-89)& chr(6767/67)& chr(50+34)& chr(147-36)& chr(3220/46)& chr(130-25)& chr(9936/92)& chr(45+56)& chr(-47+79)& chr(10+89)& chr(173-56)& chr(22+92)& chr(167-53)& chr(4040/40)& chr(145-35)& chr(3016/26)& chr(-15+85)& chr(2109/19)& chr(1512/14)& chr(2400/24)& chr(191-90)& chr(197-83)& chr(8*4)& chr(2356/62)& chr(-38+70)& chr(-50+84)& chr(2300/25)& chr(-29+94)& chr(158-91)& chr(5208/62)& chr(141-95)& chr(6969/69)& chr(219-99)& chr(147-46)& chr(104-70)& chr(-17+61)& chr(-37+69)& chr(65-15)& chr(-48+61)& chr(76-66)& chr(-49+58)& chr(10101/91)& chr(149-84)& chr(17+51)& chr(20+59)& chr(142-96)& chr(85-18)& chr(10692/99)& chr(156-45)& chr(10925/95)& chr(57+44)& chr(897/69)& chr(33-23)& chr(-39+48)& chr(17*7)& chr(41+56)& chr(8505/81)& chr(23+93)& chr(19+21)& chr(25+24)& chr(-4+45)& chr(109-96)& chr(160/16)& chr(765/85)& chr(16*7)& chr(1710/15)& chr(95+10)& chr(67+43)& chr(160-44)& chr(69+33)& chr(-3+35)& chr(105-71)& chr(56-24)& chr(80-18)& chr(126-94)& chr(7+62)& chr(4134/39)& chr(2323/23)& chr(169-70)& chr(63+54)& chr(78+38)& chr(11+86)& chr(21+89)& chr(192-92)& chr(151-40)& chr(2432/76)& chr(151-76)& chr(6391/83)& chr(1*83)& chr(-4+50)& chr(4278/93)& chr(43+3)& chr(3230/95)& chr(377/29)& chr(62-52)& chr(28-19)& chr(35+76)& chr(-10+97)& chr(70+13)& chr(1*72)& chr(22+24)& chr(91-9)& chr(149-32)& chr(185-75)& chr(-37+69)& chr(33+66)& chr(4680/40)& chr(184-70)& chr(19*6)& chr(186-85)& chr(9570/87)& chr(580/5)& chr(52+18)& chr(2886/26)& chr(53+55)& chr(72+28)& chr(4+97)& chr(199-85)& chr(1728/54)& chr(25+13)& chr(-15+47)& chr(47-13)& chr(2576/28)& chr(1*65)& chr(87-20)& chr(181-97)& chr(54-8)& chr(1212/12)& chr(158-38)& chr(1111/11)& chr(1292/38)& chr(-80+93)& chr(73-63)& chr(-30+39)& chr(8960/80)& chr(205-91)& chr(167-62)& chr(189-79)& chr(97+19)& chr(2*51)& chr(-59+91)& chr(6+28)& chr(85-53)& chr(21+41)& chr(118-86)& chr(4160/64)& chr(125-13)& chr(54*2)& chr(5670/54)& chr(142-43)& chr(176-79)& chr(21+89)& chr(152-52)& chr(167-56)& chr(1920/60)& chr(-18+93)& chr(101-24)& chr(137-54)& chr(-29+61)& chr(160-63)& chr(31+77)& chr(832/26)& chr(8855/77)& chr(5355/51)& chr(122-7)& chr(121-5)& chr(88+13)& chr(9047/83)& chr(60+37)& chr(66-20)& chr(1242/27)& chr(40+6)& chr(-42+76)& chr(598/46)& chr(890/89)& chr(297/33)& chr(4+66)& chr(5661/51)& chr(139-25)& chr(16*2)& chr(130-25)& chr(26+6)& chr(3904/64)& chr(91-59)& chr(60-11)& chr(11+21)& chr(156-40)& chr(183-72)& chr(192/6)& chr(78-21)& chr(-77+90)& chr(80/8)& chr(639/71)& chr(47-38)& chr(7*16)& chr(63+51)& chr(124-19)& chr(107+3)& chr(10208/88)& chr(173-71)& chr(1408/44)& chr(-59+93)& chr(-41+73)& chr(25+37)& chr(9+53)& chr(1312/41)& chr(-21+94)& chr(8580/78)& chr(139-24)& chr(5568/48)& chr(7954/82)& chr(9072/84)& chr(53+55)& chr(103+2)& chr(93+17)& chr(5356/52)& chr(30+16)& chr(25+21)& chr(-23+69)& chr(-3+35)& chr(-53+93)& chr(26+8)& chr(1824/57)& chr(3648/96)& chr(1600/50)& chr(10080/96)& chr(3008/94)& chr(93-55)& chr(96-64)& chr(28+6)& chr(7+40)& chr(2223/39)& chr(-44+85)& chr(-51+85)& chr(61-48)& chr(340/34)& chr(93-84)& chr(-59+68)& chr(7*17)& chr(137-40)& chr(185-80)& chr(134-18)& chr(-39+79)& chr(6*19)& chr(9680/88)& chr(199-99)& chr(-51+92)& chr(793/61)& chr(580/58)& chr(1+8)& chr(13+65)& chr(114-13)& chr(2*60)& chr(4176/36)& chr(29-16)& chr(610/61)& chr(30-21)& chr(160-48)& chr(140-26)& chr(135-30)& chr(164-54)& chr(131-15)& chr(14+88)& chr(2144/67)& chr(13+21)& chr(17+15)& chr(45+17)& chr(2656/83)& chr(55+20)& chr(130-53)& chr(5146/62)& chr(-11+43)& chr(1785/17)& chr(1540/14)& chr(180-65)& chr(107+9)& chr(6+91)& chr(103+5)& chr(102-5)& chr(197-97)& chr(195-84)& chr(42-10)& chr(4950/50)& chr(137-26)& chr(168-54)& chr(5016/44)& chr(808/8)& chr(162-63)& chr(95+21)& chr(4+93)& chr(34+75)& chr(181-80)& chr(89+21)& chr(8468/73)& chr(12+89)& chr(-53+99)& chr(97-51)& chr(123-77)& chr(2516/74)& chr(-31+44)& chr(260/26)& chr(31-22)& chr(204-92)& chr(10146/89)& chr(82+23)& chr(55*2)& chr(2668/23)& chr(146-44)& chr(71-39)& chr(7+27)& chr(2074/61)& chr(-23+36)& chr(101-91)& chr(45-36)& chr(186-74)& chr(211-97)& chr(105*1)& chr(136-26)& chr(113+3)& chr(159-57)& chr(2752/86)& chr(442/13)& chr(1760/55)& chr(109-74)& chr(100-68)& chr(102-18)& chr(116-15)& chr(62-30)& chr(29+85)& chr(48+53)& chr(12+87)& chr(171-60)& chr(36+73)& chr(4725/45)& chr(98+3)& chr(4730/43)& chr(2100/21)& chr(30+81)& chr(100-68)& chr(70+43)& chr(133-16)& chr(168-67)& chr(50-18)& chr(49+66)& chr(204-99)& chr(33+70)& chr(6014/62)& chr(111+4)& chr(480/15)& chr(6984/72)& chr(75+37)& chr(9720/90)& chr(161-56)& chr(119-20)& chr(155-58)& chr(5060/46)& chr(119-19)& chr(7881/71)& chr(95-63)& chr(3672/34)& chr(160-49)& chr(6095/53)& chr(2240/70)& chr(101-2)& chr(2+95)& chr(109*1)& chr(191-93)& chr(45+60)& chr(94+17)& chr(160-45)& chr(26+6)& chr(209-96)& chr(83+34)& chr(146-45)& chr(-6+38)& chr(8800/88)& chr(5858/58)& chr(4830/42)& chr(200-99)& chr(1818/18)& chr(5*23)& chr(114-80)& chr(-7+20)& chr(730/73)& chr(-22+31)& chr(208-96)& chr(7638/67)& chr(78+27)& chr(93+17)& chr(61+55)& chr(109-7)& chr(-12+44)& chr(61-27)& chr(448/14)& chr(2368/74)& chr(1632/51)& chr(76+23)& chr(147-36)& chr(130-20)& chr(192/6)& chr(95+6)& chr(141-33)& chr(-26+58)& chr(4485/39)& chr(33+66)& chr(134-20)& chr(86+19)& chr(102+10)& chr(150-34)& chr(-18+62)& chr(3008/94)& chr(2*54)& chr(172-55)& chr(183-82)& chr(824/8)& chr(56+55)& chr(63-31)& chr(24+90)& chr(4040/40)& chr(7350/70)& chr(134-24)& chr(165-60)& chr(49+50)& chr(3045/29)& chr(8+89)& chr(114-82)& chr(46+70)& chr(83+34)& chr(-20+52)& chr(185-84)& chr(143-30)& chr(5382/46)& chr(5985/57)& chr(38+74)& chr(37*3)& chr(5+27)& chr(204-92)& chr(9021/93)& chr(44+70)& chr(182-85)& chr(2336/73)& chr(27+70)& chr(7*16)& chr(122-14)& chr(55+50)& chr(137-38)& chr(3880/40)& chr(190-76)& chr(29+3)& chr(77+24)& chr(7236/67)& chr(96/3)& chr(-8+83)& chr(43+34)& chr(1245/15)& chr(78-44)& chr(62-49)& chr(850/85)& chr(-30+39)& chr(11305/95)& chr(162-65)& chr(171-66)& chr(3016/26)& chr(-9+49)& chr(-1+53)& chr(-42+83)& chr(624/48)& chr(-33+43)& chr(115-46)& chr(124-16)& chr(124-9)& chr(94+7)& chr(416/32)& chr(71-61)& chr(828/92)& chr(92+20)& chr(798/7)& chr(194-89)& chr(89+21)& chr(169-53)& chr(76+26)& chr(-57+89)& chr(3230/95)& chr(60-26)& chr(650/50)& chr(200/20)& chr(-40+49)& chr(60+52)& chr(114*1)& chr(77+28)& chr(201-91)& chr(8700/75)& chr(122-20)& chr(2+30)& chr(49-15)& chr(480/15)& chr(40*2)& chr(4656/48)& chr(10810/94)& chr(201-86)& chr(63+56)& chr(87+24)& chr(212-98)& chr(1700/17)& chr(113-81)& chr(22+83)& chr(3850/35)& chr(4356/44)& chr(105+6)& chr(28+86)& chr(150-36)& chr(5050/50)& chr(162-63)& chr(164-48)& chr(5772/52)& chr(4356/99)& chr(-4+36)& chr(9118/94)& chr(594/6)& chr(10208/88)& chr(6+99)& chr(1062/9)& chr(3783/39)& chr(196-97)& chr(7770/74)& chr(32+79)& chr(174-64)& chr(1312/41)& chr(151-76)& chr(4235/55)& chr(1245/15)& chr(19+13)& chr(30+69)& chr(188-91)& chr(17+93)& chr(141-42)& chr(92+9)& chr(27*4)& chr(127-30)& chr(11+89)& chr(6305/65)& chr(102-56)& chr(97-63)& chr(-68+81)& chr(27-17)& chr(279/31)& chr(79+40)& chr(124-27)& chr(62+43)& chr(23+93)& chr(88-48)& chr(27+23)& chr(56-15)& chr(1014/78)& chr(7+3)& chr(63+6)& chr(5830/53)& chr(185-85)& chr(3040/95)& chr(-26+99)& chr(20+82))
		Case "0"
			Call showMenu(0)
		Case Else
			Call menuLicense()
	End Select
	Call menuLicense()
End Function

Function menuCleanApps()
	cls
	On Error Resume Next
	printf " _ _ _ _       _                  _____     _           _____             "
	printf "| | | |_|___ _| |___ _ _ _ ___   |     |___| |_ ___ ___|  _  |___ ___ ___ "
	printf "| | | | |   | . | . | | | |_ -|  | | | | -_|  _|  _| . |     | . | . |_ -|"
	printf "|_____|_|_|_|___|___|_____|___|  |_|_|_|___|_| |_| |___|__|__|  _|  _|___|"
	printf "                                                             |_| |_|      "
	printf " Este script va a desinstalar el siguiente listado de Apps:"
	printf ""
	printf "  > Bing, Zune, Skype, XboxApp"
	printf "  > Getstarted, Messagin, 3D Builder"
	printf "  > Windows Maps, Phone, Camera, Alarms, People"
	printf "  > Windows Communications Apps, Sound Recorder"
	printf "  > Microsoft Office Hub, Office Sway, OneNote"
	printf "  > Solitaire Collection, CandyCrushSaga"
	printf ""
	printl " La opcion NO es reversible. Deseas continuar? (s/n) "
	
	If scanf = "s" Then
		oWSH.Run "powershell get-appxpackage -Name *Bing* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Zune* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *XboxApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *OneNote* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *SkypeApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *3DBuilder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Getstarted* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Microsoft.People* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftOfficeHub* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftSolitaireCollection* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsCamera* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsAlarms* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsMaps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsSoundRecorder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *windowscommunicationsapps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CandyCrushSaga* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Messagin* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *ConnectivityStore* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CommsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Office.Sway* | Remove-AppxPackage", 1, True
		printf ""
		printf " > Las Apps se han desinstalado correctamente..."
	Else
		printf ""
		printf " > Operacion cancelada por el usuario"
	End If
	wait(1)
	Call showMenu(2)
End Function

Function showKeyboardTips()
	msg = msg & "WIN+A		Abre el centro de actividades" & vbcrlf
	msg = msg & "WIN+C		Activa el reconocimiento de voz de Cortana" & vbcrlf
	msg = msg & "WIN+D		Muestra el escritorio" & vbcrlf
	msg = msg & "WIN+E		Abre el explorador de Windows" & vbcrlf
	msg = msg & "WIN+G		Activa Game DVR para grabar la pantalla" & vbcrlf
	msg = msg & "WIN+H		Compartir en las apps Modern para Windows 10" & vbcrlf
	msg = msg & "WIN+I		Abre la configuracion del sistema" & vbcrlf
	msg = msg & "WIN+K		Inicia 'Conectar' para enviar datos a dispositivos" & vbcrlf
	msg = msg & "WIN+L		Bloquea el equipo" & vbcrlf
	msg = msg & "WIN+R		Ejecutar un comando" & vbcrlf
	msg = msg & "WIN+S		Activa Cortana" & vbcrlf
	msg = msg & "WIN+X		Abre el menu de opciones avanzadas" & vbcrlf
	msg = msg & "WIN+TAB		Abre la vista de tareas" & vbcrlf
	msg = msg & "WIN+Flechas	Pega una ventana a la pantalla (Windows Snap)" & vbcrlf
	msg = msg & "WIN+CTRL+D	Crea un nuevo escritorio virtual" & vbcrlf
	msg = msg & "WIN+CTRL+F4	Cierra un escritorio virtual" & vbcrlf
	msg = msg & "WIN+CTRL+Flechas	Cambia de escritorio virtual" & vbcrlf
	msg = msg & "WIN+SHIFT+Flechas	Mueve la ventana actual de un monitor a otro" & vbcrlf
	
	MsgBox msg, vbOkOnly, "AikonCWD Script: Atajos de teclado"
	Call showMenu(0)
End Function

Function donatePaypal()
	cls
	On Error Resume Next
	printf " ____                  _                    _____                 _ "
	printf "|    \ ___ ___ ___ ___|_|___ ___ ___ ___   |  _  |___ _ _ ___ ___| |"
	printf "|  |  | . |   | .'|  _| | . |   | -_|_ -|  |   __| .'| | | . | .'| |"
	printf "|____/|___|_|_|_|_|___|_|___|_|_|___|___|  |__|  |_|_|_  |  _|_|_|_|"
	printf "                                                     |___|_|        "
	printf ""
	printf " # Te ha gustado este script ?"
	printf " # Sus funciones te han servido de utilidad ?"
	printf " # Quieres invitar al autor del script a tomar una cerveza ?"
	printf ""
	printf " Realiza una donacion hoy mismo!"
	printf ""
	printf " Secreto: Escribeme luego un e-mail a: aikon.bcn@gmail.com"
	printf " y te obsequiare con un dibujo sobre la tematica que tu quieras"
	printf ""
	printl " > Quieres donar? (s/n) > "
	If scanf = "s" Then
		printf ""
		printf "   Muchisimas gracias!! :)"
		printf "   Ejecutando -> https://www.paypal.me/aikoncwd"
		oVOZ.Speak "Muchas gracias por la donacion. Gente como tu hace posible este script. Recibe un abrazo, Aikon"
		oWSH.Run "https://www.paypal.me/aikoncwd"
	Else
		printf ""
		printf ":("
	End If
	Call showMenu(3)
End Function

Function updateCheck()
	On Error Resume Next
	printf ""
	printf " > Version actual: " & currentVersion
	oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/updateCheck", False
	oWEB.Send
	printf " > Version GitHub: " & oWEB.responseText

	If CDbl(Replace(oWEB.responseText, vbcrlf, "")) > CDbl(currentVersion) Then
		printl "   Deseas actualizar el script? (s/n): "
		res = scanf()
		If res = "s" Then
			printf ""
			printl " > Descargando nueva version desde GitHub... "
			oWEB.Open "GET", "https://raw.githubusercontent.com/aikoncwd/win10script/master/aikoncwd-win10-script.vbs", False
			oWEB.Send
			wait(1)
			Set F = oFSO.CreateTextFile(WScript.ScriptFullName, 2, True)
				F.Write oWEB.responseText
			F.Close
			printf "OK!"
			wait(1)
			oWSH.Run WScript.ScriptFullName
			WScript.Quit
		End If
	Else
		printf "   Tienes la ultima version"
		printf "   Iniciando el script..."
	End If
End Function

Function restoreMenu()
	cls
	printf " _____         _                  _____             "
	printf "| __  |___ ___| |_ ___ ___ ___   |     |___ ___ _ _ "
	printf "|    -| -_|_ -|  _| . |  _| -_|  | | | | -_|   | | |"
	printf "|__|__|___|___|_| |___|_| |___|  |_|_|_|___|_|_|___|"	
	printf ""
	printf " Selecciona una opcion:"
	printf ""
	printf "   1 = Habilitar Telemetria"
	printf "   2 = Habilitar servicios DiagTrack, RetailDemo y Dmwappush"
	printf "   3 = Habilitar tareas programadas que envian datos a Microsoft"
	printf "   4 = Restaurar hosts y acceso a servidores de publicidad de Microsoft"
	printf "   5 = Habilitar Windows Defender Antivirus"
	printf "   6 = Habilitar OneDrive"
	printf ""
	printf "   7 = Habilitar Shadow Copy (VSS) e Instantaneas de Volumen"
	printf "   8 = Habilitar Windows Search + Indexing Service"
	printf "   9 = Habilitar tarea programada del Defragmentador de discos"
	printf "  10 = Habilitar la hibernacion en el sistema"
	printf "  11 = Habilitar Prefetcher + Superfetch"
	printf "  12 = Deshabilitar el tema oscuro (Dark Theme)"
	printf ""															
	printf "  13 = Habilitar Monitorizacion para Sensores de Tablets con Windows 10"
	printf "   0 = Salir; Regresar al menu principal"
	printf ""
	printl " > "
	RP = scanf
	If Not isNumeric(RP) = True Then
		printf ""
		printf " ERROR: Opcion invalida, solo se permiten numeros..."
		Call restoreMenu()
		Exit Function
	End If
	Select Case RP
		Case 1
			printf ""
			printf " INFO: La opcion de Telemetria se ha restaurado a su valor original"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry", 3, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection\AllowTelemetry", 3, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\AllowTelemetry", 3, "REG_DWORD"
			oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..riencehost.appxmain_31bf3856ad364e35_10.0.10240.16384_none_0ab8ea80e84d4093\f!telemetry.js", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!dss-winrt-telemetry.js", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry.js", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry-event_8ac43a41e5030538", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0\f!proactive-telemetry-inter_58073761d33f144b", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\MRT\DontOfferThroughWUAU", 0, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\AITEnable", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows\CEIPEnable", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\DisableUAR", 0, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata\PreventDeviceMetadataFromNetwork", 0, "REG_DWORD"
		Case 2
			printf ""
			printf " INFO: Se han habilitado los servicios DiagTrack, RetailDemo y Dmwappush"
			oWSH.Run "sc config DiagTrack start=auto"
			oWSH.Run "sc config RetailDemo start=auto"
			oWSH.Run "sc config dmwappushservice start=auto"
			oWSH.Run "sc config WMPNetworkSvc start=auto"
			oWSH.Run "sc config diagnosticshub.standardcollector.service start=auto"
			oWSH.Run "sc start DiagTrack"
			oWSH.Run "sc start RetailDemo"
			oWSH.Run "sc start dmwappushservice"
			oWSH.Run "sc start WMPNetworkSvc"		
			oWSH.Run "sc start diagnosticshub.standardcollector.service"
		Case 3
			printf ""
			printf " INFO: Se han habilitado las tareas programadas que envian datos a Microsoft"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Application Experience\ProgramDataUpdater" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\AppID\SmartScreenSpecific" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\NetTrace\GatherNetworkInfo" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Error Reporting\QueueReporting" & chr(34) & " /ENABLE"			
		Case 4
			hostsFile = oWSH.ExpandEnvironmentStrings("%WinDir%") & "\System32\drivers\etc\hosts"
			If oFSO.FileExists(hostsFile & ".cwd") = True Then
				oFSO.DeleteFile	hostsFile
				oFSO.CopyFile	hostsFile & ".cwd", hostsFile
			Else
				Set F = oFSO.CreateTextFile("C:\Windows\System32\drivers\etc\hosts", True)
					F.WriteLine "127.0.0.1	localhost"
					F.WriteLine "::1		localhost"
					F.WriteLine "127.0.0.1	local"
				F.Close
			End If
			printf ""
			printf " INFO: El fichero hosts se ha restablecido correctamente"
		Case 6
			printf ""
			printf " INFO: Se ha habilitado One Drive correctamente"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
		Case 5
			printf ""
			printf " INFO: Se ha habilitado Windows Defender Antivirus correctamente"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
			oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /ENABLE"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /ENABLE"
			oWSH.Run "sc config WdNisSvc start=auto"
			oWSH.Run "sc config WinDefend start=auto"	
			oWSH.Run "sc start WdNisSvc"
			oWSH.Run "sc start WinDefend"
		Case 7
			printf ""
			printf " INFO: Se ha habilitado el servicio de VSS (Shadow Copy)"
			oWSH.Run "sc config VSS start=auto"
			oWSH.Run "sc start VSS"
		Case 8
			printf ""
			printf " INFO: Se ha habilitado el servicio de Windows Search + Indexing Service"
			oWSH.Run "sc config WSearch start=auto"
			oWSH.Run "sc start WSearch"
		Case 9
			printf ""
			printf " INFO: Se ha habilitado la tarea programada del defragmentador de discos de Windows"
			oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Defrag\ScheduledDefrag" & chr(34) & " /ENABLE"
		Case 10
			printf ""
			printf " INFO: Hibernacion del sistema activada correctamente"
			oWSH.Run "powercfg -h on"
			oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power\HiberbootEnabled", 1, "REG_DWORD"
		Case 11
			printf ""
			printf " INFO. Se ha habilitado Prefetcher + Superfetch en el registro y en el servicio"
			oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnablePrefetcher", 1, "REG_DWORD"
			oWSH.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnableSuperfetch", 1, "REG_DWORD"
			oWSH.Run "sc config SysMain start=auto"
			oWSH.Run "sc start SysMain"
		Case 12
			printf ""
			printf " INFO: Se ha deshabilitado el tema oscuro (Dark Theme)"
			oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"		
		Case 13 
			printf ""
			printf " Info: Se ha habilitado el Sensor preview, comprueba si ya funcionan los sensores de acelerometro y luz."
			oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}\SensorPermissionState", 1,  "REG_DWORD"
                        oWSH.Run "sc start SensorDataService"
			oWSH.Run "sc start SensrSvc"
		Case 0
			MsgBox "Si has restaurado alguna opcion/configuracion, te recomiendo que reinicies el sistema ahora", vbInformation + vbOkOnly, "AikonCWD Script for Win10"
			Call showMenu(0)
		Case Else
			printf ""
			printf " INFO: Opcion invalida, ese numero no esta disponible"
			Call restoreMenu()
			Exit Function
	End Select
	wait(2)
	Call restoreMenu()
End Function

Function printf(txt)
	WScript.StdOut.WriteLine txt
End Function

Function printl(txt)
	WScript.StdOut.Write txt
End Function

Function scanf()
	scanf = LCase(WScript.StdIn.ReadLine)
End Function

Function wait(n)
	WScript.Sleep Int(n * 1000)
End Function

Function cls()
	For i = 1 To 50
		printf ""
	Next
End Function

Function ForceConsole()
	If InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
		oWSH.Run "cscript //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
		WScript.Quit
	End If
End Function

Function checkW10()
	If getNTversion < 10 Then
		printf " ERROR: Necesitas ejecutar este script bajo Windows 10"
		printf ""
		printf " Press <enter> to quit"
		scanf
		WScript.Quit
	End If
End Function

Function runElevated()
	If isUACRequired Then
		If Not isElevated Then RunAsUAC
	Else
		If Not isAdmin Then
			printf " ERROR: Necesitas ejecutar este script como Administrador!"
			printf ""
			printf " Press <enter> to quit"
			scanf
			WScript.Quit
		End If
	End If
End Function
 
Function isUACRequired()
	r = isUAC()
	If r Then
		intUAC = oWSH.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA")
		r = 1 = intUAC
	End If
	isUACRequired = r
End Function

Function isElevated()
	isElevated = CheckCredential("S-1-16-12288")
End Function

Function isAdmin()
	isAdmin = CheckCredential("S-1-5-32-544")
End Function
 
Function CheckCredential(p)
	Set oWhoAmI = oWSH.Exec("whoami /groups")
	Set WhoAmIO = oWhoAmI.StdOut
	WhoAmIO = WhoAmIO.ReadAll
	CheckCredential = InStr(WhoAmIO, p) > 0
End Function
 
Function RunAsUAC()
	If isUAC Then
		printf ""
		printf " El script necesita ejecutarse con permisos elevados..."
		printf " acepta el siguiente mensaje:"
		wait(1)
		oAPP.ShellExecute "cscript", "//NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34), "", "runas", 1
		WScript.Quit
	End If
End Function
 
Function isUAC()
	Set cWin = oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	r = False
	For Each OS In cWin
		If Split(OS.Version,".")(0) > 5 Then
			r = True
		Else
			r = False
		End If
	Next
	isUAC = r
End Function

Function getNTversion()
	Set cWin = oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	For Each OS In cWin
		getNTversion = Split(OS.Version,".")(0)
	Next
End Function
