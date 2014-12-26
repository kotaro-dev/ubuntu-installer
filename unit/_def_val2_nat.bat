@echo off
rem this is parametaer file
rem separate with colon,don't input a space with each paramater.
rem before colon - env name
rem after  colon - env value
rem don't write colon any other place in this file.

rem [unit property]
rem virtual box name
BOX_NM:UbuntuNat

rem loading iso file name
ISO_NM:ubuntu14.04.1-preseed.iso

rem check 'vboxmanage list ostypes' or vbox_ostypes_list.txt
OSTYPE:Ubuntu_64

rem memory - MB
MMRY:1024

rem cpu count
CPUS:1

rem [--nic<1-N> none|null|nat|bridged|intnet|hostonly|generic|natnetwork]
NIC:nat

rem [--nictype<1-N> Am79C970A|Am79C973|82540EM|82543GC|82545EM|virtio]
NICTYPE:virtio

rem [--nic<1-N> none|null|nat|bridged|intnet|hostonly|generic|natnetwork]
NIC2:hostonly

rem [--nictype<1-N> Am79C970A|Am79C973|82540EM|82543GC|82545EM|virtio]
NICTYPE2:virtio

rem hostonlyadapter - [--hostonlyadapter<1-N> none|<devicename>]
HOST_ADPT2:VirtualBox Host-Only Ethernet Adapter

rem [strage property]
STRG_SIZE:20000

STRG_NM:SATA

rem strage add type[--add ide|sata|scsi|floppy|sas]
STRG_TYPE:sata

rem  [--portcount <1-30>]
PORT_CNT:5

rem  [--bootable on|off]
BOOT:on

