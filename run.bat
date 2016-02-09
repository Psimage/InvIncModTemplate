@echo off

if "%MSYS2_HOME%" == "" (
	echo MSYS2_HOME environment variable is not set
	PAUSE
	exit 1
)

%MSYS2_HOME%\usr\bin\bash -l "%~dp0bind.sh" "../../"
if errorlevel 1 (
	echo.
	PAUSE
	exit 1
)

start /B %MSYS2_HOME%\usr\bin\mintty --window hide /usr/bin/bash -l "%~dp0steam.sh"
exit