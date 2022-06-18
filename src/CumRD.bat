@ECHO OFF

:: Set the file names
title Wait...
set randomfilename=%random%
set randomlogname=%random%

:: Download the dependencies
timeout /t 1 /nobreak > %temp%%random%.%random%
echo Calling the WebRequest to download crd.msi...
title Downloading the dependencies...
powershell -command "Invoke-WebRequest https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi -OutFile crd.msi"

:: Start crd installer
title Starting crd...
echo Starting crd installer...
start crd.msi

:: Rename and config the keys.txt
timeout /t 2 /nobreak > %temp%%random%.%random% 
title Configurating the keys...
echo Configurating the keys...
type keys.txt > %randomfilename%.bat
copy keys.txt C:\Windows\System32\crdconf.bat

:: Check if crd is running
title Checking crd status...
echo Checking crd status...
:taskcheck
tasklist /FI "IMAGENAME eq crd.msi" /FO CSV > %randomlogname%.log

FOR /F %%A IN (%randomlogname%.log) DO IF %%~zA EQU 1 GOTO end

title Working, please wait...
echo Launching the keys...
start %randomfilename%.bat
echo Worked!!
echo You can now close this window.
set /p pressentertoclose=
exit
:end
goto taskcheck
