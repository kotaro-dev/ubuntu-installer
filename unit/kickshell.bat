@echo off

set rtdir=%~dp0
set kickrt=%~dp0
set debug_on=1

set kickshell=createbox.bat
set isonm=ubuntu14.04-preseed.iso

rem pushd .
rem cd ..\iso
rem set isort=%cd%\
rem popd

rem pushd .
rem cd ..\
rem set vboxrt=%cd%\
rem popd

rem call createbox.bat -kickrt %kickrt% -iso_rt %isort% -vboxrt %vboxrt% -iso %isort%isonm%

echo kickshell start

call createbox.bat -kickrt %kickrt% -iso %isonm% -d %debug_on%

echo kickshell end

