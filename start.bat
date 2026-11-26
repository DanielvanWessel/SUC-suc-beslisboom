@echo off
setlocal
title SUC-beslisboom
rem Haalt de nieuwste versie van de app van GitHub en opent die in je standaardbrowser.
rem Nodig: alleen Windows 10/11 (curl zit standaard in Windows). Geen git, Python of Node.

set "REPO=DanielvanWessel/SUC-suc-beslisboom"
set "BRANCH=main"
set "DIR=%LOCALAPPDATA%\suc-beslisboom"
if not exist "%DIR%" mkdir "%DIR%"

echo SUC-beslisboom: nieuwste versie ophalen...
curl.exe -fsSL --max-time 20 -o "%DIR%\index.new" "https://raw.githubusercontent.com/%REPO%/%BRANCH%/index.html"
if %errorlevel%==0 (
  move /y "%DIR%\index.new" "%DIR%\index.html" >nul
  echo Bijgewerkt.
  goto open
)
if exist "%DIR%\index.new" del "%DIR%\index.new"
if exist "%DIR%\index.html" (
  echo GitHub niet bereikbaar: de vorige versie wordt geopend.
  goto open
)
if exist "%~dp0index.html" (
  copy /y "%~dp0index.html" "%DIR%\index.html" >nul
  echo GitHub niet bereikbaar: de kopie naast dit bestand wordt geopend.
  goto open
)
echo Kon de app niet ophalen. Controleer je internetverbinding en probeer het opnieuw.
pause
exit /b 1

:open
start "" "%DIR%\index.html"
