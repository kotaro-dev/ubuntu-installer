@echo off
rem echo check param values - for _set_param.bat

rem local val
set rtdir=%~dp0
set tsfm=_set_param.bat
set elvl=0
set debug_on=1

rem 1 :call %rtdir%%tsfm% -nm UbuntuTest -iso my-ubuntu-preseed.iso

rem 2 :call %rtdir%%tsfm% -mn ubuntu -iso dummy-ubuntu.iso -l -nm myUbuntu

rem 3 :call %rtdir%%tsfm% -iso my-ubuntu-preseed.iso

rem 4 :call %rtdir%%tsfm%

call %rtdir%%tsfm% -d %debug_on%


set kickshell=createbox.bat
set isonm=ubuntu14.04-preseed.iso

call %rtdir%%tsfm% -kickrt %rtdir% -iso %isonm% -d %debug_on%


rem echo In stub
rem echo BOXNM=%BOXNM%
rem echo ISONM=%ISONM%
rem echo.
rem echo fdef=%fdef%
rem echo.

rem echo e-level=%elvl%
