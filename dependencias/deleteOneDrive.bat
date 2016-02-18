	set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
	set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
	echo.
	echo Closing OneDrive process.
	echo.
	taskkill /f /im OneDrive.exe > NUL 2>&1

	echo Uninstalling OneDrive.
	echo.
	if exist %x64% (
	%x64% /uninstall
	) else (
	%x86% /uninstall
	)

	echo Removing OneDrive leftovers.
	echo.
	rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
	rd "%systemroot%/Users/%username%/OneDrive" /Q /S > NUL 2>&1
	rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
	rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
	rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
	rd "%Windir%\SysWOW64" /Q /S > NUL 2>&1 
	TASKKILL /F /IM OneDrive.exe /T 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
	reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
	reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
	reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
	reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
	reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f
	takeown /F %Windir%\SysWOW64\OneDriveSetup.exe
	icacls %Windir%\SysWOW64\OneDriveSetup.exe /grant Administrators:F
	del %Windir%\SysWOW64\OneDriveSetup.exe
	takeown /F %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll
	icacls %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll /grant Administrators:F
	del %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll
	Del %AppData%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk 

	echo Removeing OneDrive from the Explorer Side Panel.
	echo.
	REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
	REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
