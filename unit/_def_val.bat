@echo off
rem set direct params.

rem [unit property]
rem virtual box name
set BOX_NM=MyUbuntuBox

rem loading iso file name
set ISO_NM=ubuntu14.04-preseed.iso

rem check 'vboxmanage list ostypes' or vbox_ostypes_list.txt
set OSTYPE=Ubuntu_64

rem memory - MB
set MMRY=1024

rem cpu count
set CPUS=2

rem [--nic<1-N> none|null|nat|bridged|intnet|hostonly|generic|natnetwork]
set NIC=bridged

rem [--nictype<1-N> Am79C970A|Am79C973|82540EM|82543GC|82545EM|virtio]
set NICTYPE=virtio

rem bridgeadapter - [--bridgeadapter<1-N> none|<devicename>]
rem 'ipconfig /all|findstr Description'
rem this is sample network case name.
set BRDG_ADPT=Intel(R) 82579LM Gigabit Network Connection


rem [strage property]
set STRG_SIZE=20000

set STRG_NM=SATA

rem strage add type[--add ide|sata|scsi|floppy|sas]
set STRG_TYPE=sata

rem  [--portcount <1-30>]
set PORT_CNT=5

rem  [--bootable on|off]
set BOOT=on

exit /b 0
