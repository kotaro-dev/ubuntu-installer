@echo off
rem this is parametaer file
rem separate with colon,don't input a space with each paramater.
rem before colon - env name
rem after  colon - env value
rem don't write colon any other place in this file.

rem [unit property]
rem virtual box name
BOX_NM:MyUbuntuBox

rem loading iso file name
ISO_NM:ubuntu14.04-preseed.iso

rem check 'vboxmanage list ostypes' or vbox_ostypes_list.txt
OSTYPE:Ubuntu_64

rem memory - MB
MMRY:1024

rem cpu count
CPUS:2

rem [--nic<1-N> none|null|nat|bridged|intnet|hostonly|generic|natnetwork]
NIC:bridged

rem [--nictype<1-N> Am79C970A|Am79C973|82540EM|82543GC|82545EM|virtio]
NICTYPE:virtio

rem bridgeadapter - [--bridgeadapter<1-N> none|<devicename>]
rem 'ipconfig /all|findstr Description'
rem this is sample network case name.
BRDG_ADPT:Intel(R) 82579LM Gigabit Network Connection

rem [strage property]
STRG_SIZE:20000

STRG_NM:SATA

rem strage add type[--add ide|sata|scsi|floppy|sas]
STRG_TYPE:sata

rem  [--portcount <1-30>]
PORT_CNT:5

rem  [--bootable on|off]
BOOT:on

