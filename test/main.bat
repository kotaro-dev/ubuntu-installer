@echo off
rem this is main script.

echo main batch start

set rtdir=%~dp0

call %rtdir%preset.bat
echo.
echo ERRORLEVEL=%ERRORLEVEL%
echo.

echo FILE NAME=%filenm%
echo Hello=%HW%
echo Moring=%ming%

echo main batch end

exit /b 0
