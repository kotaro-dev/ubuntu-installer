@echo off

set elvl=-1

rem ============ for unit test ==================
rem set debug_on=1
rem set isonm=ubuntu14.04.1-preseed.iso
rem set boxnm=UbuntuTest

rem set rtdir=%~dp0
rem set prmf=_set_param.bat

rem call %rtdir%%prmf% -kickrt %rtdir% -iso %isonm% -d %debug_on% 
rem call %rtdir%%prmf% -kickrt %rtdir% -iso %isonm% -d %debug_on% -nm %boxnm%
rem ============ for unit test ==================

echo createvm

vboxmanage createvm --name %BOX_NM%

echo registervm

rem mkdir %VBOXRT%%BOX_NM%

vboxmanage registervm %VBOXRT%%BOX_NM%\%BOX_NM%.vbox

echo modifyvm

rem -- bridge --
rem vboxmanage modifyvm %BOX_NM%  --ostype %OSTYPE% --memory %MMRY% --acpi on --ioapic on --cpus %CPUS% --hwvirtex on --nestedpaging on --largepages on --nic1 %NIC% --nictype1 %NICTYPE% --bridgeadapter1 "%BRDG_ADPT%" --cableconnected1 on --clipboard bidirectional --usb off --usbehci off --boot1 none --boot2 disk --boot3 dvd --boot4 net

rem -- nat and hostonly --
vboxmanage modifyvm %BOX_NM%  --ostype %OSTYPE% --memory %MMRY% --acpi on --ioapic on --cpus %CPUS% --hwvirtex on --nestedpaging on --largepages on --nic1 %NIC% --nictype1 %NICTYPE% --nic2 %NIC2% --nictype2 %NICTYPE2%  --hostonlyadapter2 "%HOST_ADPT2%" --cableconnected1 on --clipboard bidirectional --usb off --usbehci off --boot1 dvd --boot2 disk --boot3 net --boot4 none

rem vboxmanage modifyvm %BOX_NM%  --ostype %OSTYPE% --memory %MMRY% --acpi on --ioapic on --cpus %CPUS% --hwvirtex on --nestedpaging on --largepages on --nic1 %NIC% --nictype1 %NICTYPE% --cableconnected1 on --clipboard bidirectional --usb off --usbehci off --boot1 dvd --boot2 disk --boot3 net --boot4 none


echo createhd

vboxmanage createhd --size %STRG_SIZE% --variant Fixed --filename %VBOXRT%%BOX_NM%\%BOX_NM%.vdi


echo storagectl

vboxmanage storagectl %BOX_NM%  --name "%STRG_NM%" --add %STRG_TYPE% --portcount %PORT_CNT% --bootable %BOOT%

echo storageattach port 1

vboxmanage storageattach %BOX_NM%  --storagectl "%STRG_NM%" --port 1 --type hdd --medium %VBOXRT%%BOX_NM%\%BOX_NM%.vdi

echo storageattach port 2

vboxmanage storageattach %BOX_NM%  --storagectl "%STRG_NM%" --port 2 --type dvddrive --medium %ISO_RT%%ISO_NM%

echo end setting not startvm

vboxmanage startvm %BOX_NM%

set elvl=%ERRORLEVEL%

echo virtualbox started - end this script.

exit /b %elvl%

:PARAM-ERR

exit /b %elvl%
