@echo off

rem setlocal enabledelayedexpansion

rem local val
set rtdir=%~dp0
set elvl=-1
set dbgf=_debug_param.bat
set dbgl=0
set dbgoff=0

rem set deff=_def_val.bat
set deff2=_def_val2.bat

rem ----- beta global val s -----

set KICKRT=%rtdir%
set ISO_RT=..\iso\
set VBOXRT=..\

set BOX_NM=MyUbuntuBox
set ISO_NM=ubuntu14.04-preseed.iso
set OSTYPE=Ubuntu_64
set MMRY=1024
set CPUS=2
set NIC=bridged
set NICTYPE=virtio
set BRDG_ADPT=Intel(R) 82579LM Gigabit Network Connection
set STRG_SIZE=20000
set STRG_NM=SATA
set STRG_TYPE=sata
set PORT_CNT=5
set BOOT=on

rem ----- beta global val e -----

rem ----- load %deff% val s -----

rem param def type1 : normal windows set val
rem if exist %KICKRT%%deff% (call %KICKRT%%deff%)

rem ----- load %deff% val e -----

rem ----- load %deff2% val s -----

rem param def type2 : array set separate [:] use set value only.
if exist %KICKRT%%deff% (
  for /f "eol= tokens=1,2,* delims=:" %%a in (%KICKRT%%deff2%) do (
    if not "%%b"=="" (set %%a=%%b)
  )
)

rem ----- load %deff2% val e -----

rem ----- load from args val s -----

:START_LOOP
IF "%1"=="" GOTO END_LOOP
    IF NOT "%1"=="-debug" GOTO ELSE0
        SET dbgl=%2
        GOTO ENDIF
:ELSE0
    IF NOT "%1"=="-nm" GOTO ELSE1
        SET BOX_NM=%2
        GOTO ENDIF
:ELSE1
    IF NOT "%1"=="-iso" GOTO ELSE2
        SET ISO_NM=%2
        GOTO ENDIF
:ELSE2
    IF NOT "%1"=="-os" GOTO ELSE3
        SET OSTYPE=%2
        GOTO ENDIF
:ELSE3
    IF NOT "%1"=="-mmry" GOTO ELSE4
        SET MMRY=%2
        GOTO ENDIF
:ELSE4
    IF NOT "%1"=="-cpus" GOTO ELSE5
        SET CPUS=%2
        GOTO ENDIF
:ELSE5
    IF NOT "%1"=="-nic" GOTO ELSE6
        SET NIC=%2
        GOTO ENDIF
:ELSE6
    IF NOT "%1"=="-nictype" GOTO ELSE7
        SET NICTYPE=%2
        GOTO ENDIF
:ELSE7
    IF NOT "%1"=="-brdg_adpt" GOTO ELSE8
        SET BRDG_ADPT=%2
        GOTO ENDIF
:ELSE8
    IF NOT "%1"=="-strg_size" GOTO ELSE9
        SET STRG_SIZE=%2
        GOTO ENDIF
:ELSE9
    IF NOT "%1"=="-strg_nm" GOTO ELSE10
        SET STRG_NM=%2
        GOTO ENDIF
:ELSE10
    IF NOT "%1"=="-strg_type" GOTO ELSE11
        SET STRG_TYPE=%2
        GOTO ENDIF
:ELSE11
    IF NOT "%1"=="-portcnt" GOTO ELSE12
        SET PORT_CNT=%2
        GOTO ENDIF
:ELSE12
    IF NOT "%1"=="-boot" GOTO ELSE13
        SET BOOT=%2
        GOTO ENDIF
:ELSE13

    IF NOT "%1"=="-kickrt" GOTO ELSE80
        SET KICKRT=%2

        pushd .
        cd ..\iso
        set ISO_RT=%cd%\
        popd
        pushd .
        cd ..\
        set VBOXRT=%cd%\
        popd

        GOTO ENDIF
:ELSE80
    IF NOT "%1"=="-iso_rt" GOTO ELSE81
        SET ISO_RT=%2
        GOTO ENDIF
:ELSE81
    IF NOT "%1"=="-vboxrt" GOTO ELSE82
        SET VBOXRT=%2
        GOTO ENDIF
:ELSE82

    IF NOT "%1"=="-h" GOTO ELSE88
    GOTO PARAM-ERR
:ELSE88
    IF NOT "%1"=="-d" GOTO ELSE99
        SET dbgl=%2
        GOTO ENDIF
:ELSE99
    SHIFT
    GOTO START_LOOP
rem     GOTO PARAM-ERR
:ENDIF
    SHIFT
    SHIFT
GOTO START_LOOP
:END_LOOP

rem ----- load from args val e -----

rem endlocal && set BOXNM=%BOXNM% && set ISONM=%ISONM% && set elvl=%elvl%

if %dbgl% gtr %dbgoff% (call %KICKRT%%dbgf%)


exit /b %elvl%

:PARAM-ERR

echo.
echo ======help message====================
echo.
echo -h : show help message
echo -debug or -d : show setting params. set over 0.
echo                eg. -d 1
echo.
echo -nm  : Virtual BOX NAME
echo -iso : Loading ISO NAME
echo -os  : OSTYPE (check - vboxmanage list ostype)
echo -mmry: Memory Size(MB)
echo -cpus: Number of CPU count
echo -nic : NIC type ([none^|null^|nat^|bridged^|intnet^|hostonly^|generic^|natnetwork])
echo -nictype  : NICTYPE ([Am79C970A^|Am79C973^|82540EM^|82543GC^|82545EM^|virtio])
echo -brdg_adpt: BRDG_ADPT ([none^|^<devicename^>])
echo -strg_size: STORAGE SIZE(MB)
echo -strg_nm  : STORAGE NAME eg.SATA (def)
echo -strg_type: STORAGE TYPE ([ide^|sata^|scsi^|floppy^|sas])
echo -portcnt  : PORT_CNT eg.5 (def)
echo -boot BOOT: bootable [on^|off] on(def)
echo.
echo ======================================
echo.

exit /b %elvl%

