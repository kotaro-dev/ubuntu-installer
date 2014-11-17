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
