@echo off

set debug_on=1
set isonm=ubuntu14.04-preseed.iso
set boxnm=

set rtdir=%~dp0
set prmf=_set_param.bat

call %rtdir%%prmf% -kickrt %rtdir% -iso %isonm% -d %debug_on%

echo createvm

vboxmanage createvm --name %BOX_NM%

echo registervm

rem mkdir %VBOXRT%%BOX_NM%

vboxmanage registervm %VBOXRT%%BOX_NM%\%BOX_NM%.vbox

echo modifyvm

vboxmanage modifyvm %BOX_NM%  --ostype %OSTYPE% --memory %MMRY% --acpi on --ioapic on --cpus %CPUS% --hwvirtex on --nestedpaging on --largepages on --nic1 %NIC% --nictype1 %NICTYPE% --bridgeadapter1 "%BRDG_ADPT%" --cableconnected1 on --clipboard bidirectional --usb off --usbehci off --boot1 none --boot2 disk --boot3 dvd --boot4 net

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


echo virtualbox started - end this script.
