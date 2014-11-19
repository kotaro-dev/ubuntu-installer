ubuntu-installer
================

this is  the ubuntu14.04 install for using preseed.cfg with url. 

##目的
 
 ubuntu server 環境を、shell(batch) で、vbox の構築からubuntu再起動(自動ログイン)まで一気に実行します。

##概要

1. virtual box の構築、起動
1. ubuntu.iso をload、installer
1. 必要な初期設定、Package Install(設定含む) 及び 再起動(自動ログイン)。

   以上の処理を、設定 に従って 実行します。

##具体的な処理の流れ

*   ubuntu のpreseed.cfg を利用したauto install の応用です。

1.  preseed.cfg をhttp server に外部に出し、hard disk 構成等状況により変更できる構成にしてあります。
1.  isolinux.cfg で preseed.cfg をurl=http://xxx/preseed.cfg で指定しています。
1.  preseed.cfg  で auto(silent) isntall を実行します。
1.  preseed.cfg  の preseed/late_command 部分で、事後処理用のshell(late_seed.sh)をcallしています。
1.  late_seed.sh は github上にコミットしており、
    wget http://raw.github.com/xxxx/master/late_seed.sh --no-check-certificate -O /target/tmp/late_seed.sh
    により取得、load しています。
1.  late_seed.sh の中は、#!/bin/sh で記述しています。

*   virtualbox の自動構築は、vboxmanage コマンドを利用しています。
    必要な vboxmanage による処理を、windows batch(createbox.bat)に 記述しています。
    ※こちらは、今のところ べた書きです。

*   他に、preseed.cfg を利用するように iso image を再構築する作業が必要です。
    iso image の作成手順は、別途 記載します。

##構成

(on windows os)  
 virtualStrage : work directory for virtualbox (C:\virtualStrage)  
  ├ github  
  │   * github 上に公開している ubuntu 初期設定file  
  ├ http-svr  
  │   * preseed.cfg (apache等で簡易的に http serverを立てて配置)  
  ├ iso  
  │   * ubuntu 公式site 等から取得し、isolinux.cfg を書換、再構築したiso  
  ├ test  
  │   * batch の 引数チェックに利用した簡易テストbatch  
  └ unit  
      * windows 上で、virtual box を構築するbatch  
  README.md  
  LICENSE  

##利用条件

 1. virtual box をあらかじめinstallして、pathを通してください。  
    例) set Path="C:\Program Files\Oracle\VirtualBox";%Path%

##前準備

 1. Boot CD 作成手順 : ubuntu14.04-preseed.iso の作り方(on linux)

##作業手順 及び 使い方

(configure param)  
 unit\  
   **_set_param.bat**  or  **_def_val2.bat**  or  **_def_val.bat**  or  **実行時引数**  
 いずれかで、paramater を設定できます。  
   **_set_param.bat**  <  **_def_val.bat**  <  **_def_val2.bat**  <  **実行時引数**  
 上記の順に上書きされます。  
 
(start on commmand prompt)  
 cd C:\virtualStrage\unit  
 cmd  
 createbox.bat  

##ライセンス

 MIT License (see LICENSE)

##雑記

PXEのような大量に同じ環境を構築する用途でなく  
自分の開発用環境を 楽をして構築したくなったので作成しました。  
基本的にshell と batch だけで作成しています。  
必要に応じて、追記していく予定です。  

Windows7 64bit OS 上で、ubuntu14.04-server.iso base で利用しています。  
virtualbox は 4.3.18 r96516 です。  

##このコンテンツに記載されている事
1. virtualbox の CUI 作業(作成・起動 等) -> [unit/createbox.bat]  
   vboxmanage コマンドで実行できる。  
   vboxmanage と入力すると、help が表示される。(install先をpath に通す必要あり)  
1. batch の変数・引数のコントロール -> [unit/_set_param.bat|_def_val.bat|_def_val2.bat]  
   _set_param.bat : argment のset 及び _def_val系batch をcall. debug用ベタinit val area あり。  
   _def_val.bat : initial val batch. set variable=value style. if set variable= (空白上書き:overwrite with empty)  
   -del_val2.bat: initial val batch. varianle:value style. if variable: (無視:ignore this variable)  
1. isolinux.cfg の編集 - preseed.cfg with Url style. -> [iso/isolinux.cfg]  
   auto=true priority=critical : url 指定でなく、Boot CD に file= とする場合、priority は無くてもできました。  
   url= の場合、critical に設定しないと、どうしても最初にlocale を聞かれてしまい full auto で稼動しませんでした。  
   isolinux.cfg は、iso image file を解凍、isolinux/isolinux.cfg にあります。  
1. preseed.cfg の編集 -> [http-svr/preseed.cfg]  
   とりあえず動きましたlevel 。何度も検証したかったので http リクエストで取得できるように外に配置.  
   preseed.cfg は、http protocol のみです。https は無理。(apache serverを立てて簡単に検証してみました)  
   (冷静に考えれば、OSがinstallされていない状況で https ssl/tls のprotocol ができるはずも無く... )  
   
   一番最後に preseed/late_command を仕込んであります。  
   preseed でのpackage install は最小限にして、後処理で必要なpackage をinstallするようにしています。  
   late_seed.sh は、https:// が利用できました。github 上のスクリプトをget してます。  
   github の shell をget する記述も最初悩みました。(説明が見つけられず)  
   各file page の[Raw] をクリックした URL が利用できます。  
   が、実際には   
     https://raw.githubusercontent.com/kotaro-dev/ubuntu-installer/master/http-svr/preseed.cfg  
   では無く  
     [raw.githubusercontent.com] を [raw.github.com]   
     [https://] を [http://]  
    と変更して、下記のように設定しています。  
     http://raw.github.com/kotaro-dev/ubuntu-installer/master/http-svr/preseed.cfg --no-check-certificate  
    
    wget でget したfileの置き場所も試行錯誤。  
     -O /target/tmp/late_seed.sh; \  
     in-target chmod +x /tmp/late_seed.sh; \  
     in-target /bin/sh -x /tmp/late_seed.sh;  
     
     /target がroot だと考えて、/tmp 以下にshellをdownload、  
     in-target で shell を指定するので、/tmp/xxx でunix command を実施。  
     (manual に書いてあるのですが、manualを理解できず。正解がわかるとmanualが理解できる という感じで)  
    
1. [preseed.cfg]  
   d-i passwd/user-password-crypted password $1$ElgTiXpM$vSun4F.QDb5IyBbGyvXlA0 の部分について  
   MD5 で暗号化して記載しています。(大元は user name と同じ sasaki です)  
   -> [github/userchg.sh] で別途 初期userと同一group に属するuserを作成するshell を用意。install後に sasaki は破棄)  
   
   iso image を解凍・再構築 した linux 上で 下記command で暗号化  
   printf "sasaki" | mkpasswd -s -m md5  
   $1$ElgTiXpM$vSun4F.QDb5IyBbGyvXlA0  
   
   mkpasswd が利用できない場合は、sudo apt-get install -y whois を 追加。  
1. disk image(ubuntu-14.04.1-server-amd64.iso) の解凍・再構成  
   [解凍]
   sudo apt-get install -y syslinux mtools mbr genisoimage dvd+rw-tools  
   mkdir -p tmp && cd tmp  
   (wget or cp original ubuntu14.04.1-server.iso)  
   -> tmp/ubuntu14.04.1-server.iso  
   mkdir -p tmp/dvd  
   mkdir -p tmp/dvdr  
   sudo mount -t iso9660 tmp/ubuntu14.04.1-server.iso tmp/dvd  
   cd dvd  
   find . ! -type l | cpio -pdum ../dvdr/  
   (edited : isolinix/isolinux.cfg)  
   (sample : doc/install/manual/example-preseed.txt.gz)   
   
   [再構築]：for Booting image
   sudo genisoimage -N -J -R -D -V "PRESEED-URL" -o ubuntu14.04-preseed.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table dvdr 
1. [github/ late_seed.sh]  
   - 自動ログイン : (そもそもあまり用途が無いのですが、面倒になったので設定)  
     sudo echo exec /sbin/agetty -a ${user} tty1 >> /etc/init/tty1.conf  
     sed で書き換えたほうが良いのかも。今回は 最終行に追記。  
   - フォルダ共有(Samba) : 設定fileをベタで置き換え。  
     pdbedit へ user を追加する際の password をsilent で実施する方法。  
     sudo echo -e "${user}\n${user}\n"|sudo pdbedit -t -a ${user}  
   - package の定期update/upgrade :   
      - 10periodic  
      - 50unattended-upgrades  
1. [github/postfix.sh] : debconf-set-selections をset することで silent install  
   postfix install すろとmailname や mailer_type など入力待ち状態 になりますが、これを回避するsample です。  
   手動で構築した環境があれば、  
   sudo debconf-get-selections|grep xxx  
   上記のコマンドで、設定情報がわかります。(なんとなく)  
1. 普段利用するUser の新規作成 shell  
   preseed.cfg は  github 上で管理するので そのうち user/paaawd をubuntu/ubuntu に修正したく。  
   その際に、初期Userと同じ設定・権限(所属group) のUserを作成するshell が欲しく作成。  
   adduser を一般的に推奨されますが、silent で実施したかったので  
   あえて useradd を利用しています。  
   passwd のsilent 入力は ２つの方法を記載しておきます。  
   `echo ${new_pswd}|mkpasswd -s -m sha-512`  
   `perl -e "print (crypt('{passwd}', '**'));"`  
    -> ** は 暗号用の2文字(数字可)  
1. [github/hostnm.sh] : hostname の変更  
   初期user と同じ理由で、hostname も変更したいかなぁと。shell を作成。  
   sed を使うことにしました。
