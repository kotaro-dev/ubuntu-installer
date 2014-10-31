set boxnm=UbuntuSvr
set isonm=ubuntu14.04-preseed.iso

:START_LOOP
IF "%1"=="" GOTO END_LOOP
    IF NOT "%1"=="-nm" GOTO ELSE1
        SET boxnm=%2
        GOTO ENDIF
:ELSE1
    IF NOT "%1"=="-iso" GOTO ELSE2
        SET isonm=%2
        GOTO ENDIF
:ELSE2
        GOTO PARAM-ERR
:ENDIF
    SHIFT
    SHIFT
GOTO START_LOOP
:END_LOOP


set rtdir=%~dp0

echo createvm

vboxmanage createvm --name %boxnm%

echo registervm

rem mkdir %rtdir%%boxnm%

vboxmanage registervm %rtdir%%boxnm%\%boxnm%.vbox

echo modifyvm

vboxmanage modifyvm %boxnm%  --ostype Ubuntu_64 --memory 1024 --acpi on --ioapic on --cpus 2 --hwvirtex on --nestedpaging on --largepages on --nic1 bridged --nictype1 82540EM --bridgeadapter1 "Intel(R) 82579LM Gigabit Network Connection" --cableconnected1 on --clipboard bidirectional --usb off --usbehci off --boot1 none --boot2 disk --boot3 dvd --boot4 net


echo createhd

vboxmanage createhd --size 20000 --variant Fixed --filename %rtdir%%boxnm%\%boxnm%.vdi


echo storagectl

vboxmanage storagectl %boxnm%  --name SATA --add sata --portcount 5 --bootable on

echo storageattach port 1

vboxmanage storageattach %boxnm%  --storagectl SATA --port 1 --type hdd --medium %rtdir%%boxnm%\%boxnm%.vdi

echo storageattach port 2

rem vboxmanage storageattach %boxnm%  --storagectl SATA --port 2 --type dvddrive --medium %rtdir%ubuntu-14.04-server-amd64.iso
vboxmanage storageattach %boxnm%  --storagectl SATA --port 2 --type dvddrive --medium %rtdir%%isonm%

echo end setting not startvm

vboxmanage startvm %boxnm%

