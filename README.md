# initchef

## Synopsis

* This tool is initialize of my chef.
* オレオレChefです。
* 主に初期セットアップ用です。

## Description

主にオレのために以下のことをします。

* Vagrantが入っていたらsahari入れてある程度のところでスナップショットを取る
* knifeやBerkshelf入れる
* Vagrant のboxを追加し、sshを設定する
* CentOSかUbuntuを見分けて適当に必要な開発ツール群を入れる
* chefのcookbookからnginxなど適当に入れる
* 解析ツールを入れる
* その他使いそうなものを入れる

* 当方環境(動作確認済)
 * Mac OS X Marvericks(10.9) + rbenv
 * Win7 + Cygwin64 + rbenv

* すみません、英語が果てしなく苦手です...。 orz
* ソースのコメント等でおかしいところがあったら、レビューコメント頂けると頂けると嬉しいです...
* ソースについてもコメント頂けたら、嬉しいです! (^o^)/

## Requiments

* Ruby "> 2.0"
* libxml2 iconv iconv-devel libiconv libiconv-devel libxml2-devel libxslt1-devel
 * Cygwin
   - apt-cygで入れると楽です
 * Mac
   - もちろんHomebrewで
* Vagrant
* Virtual Box
* chefの鍵
 * 取得して、sbin/init-chef/.chef/knife.rb のclient_key のPathを自分の環境に
合わせてください
 * 鍵の取得場所
    * https://preview.opscode.com/signup?ref=community


## Notice

* Cygwinは、以下の対応が必要です
 * rbenv

    `$ peflags -v -x$[ 2*1024**2 ] -X$[ 256*2048 ] ~/.rbenv/versions/*/bin/ruby`
>  - See : http://seesaawiki.jp/w/kou1okada/d/Cygwin%20-%20Ruby

 * Virtual Box
  - CygwinのDirからVbox Vmsが見られるようになることがあります。
  すると、既存のがあるとOS再起動後に消えたように見えます。その際は以下。

     1.  VBoxのファイル => 環境設定から  一般を選択
     2.  デフォルトの仮想マシンフォルダーを通常のC:\Users\ユーザ\VirtualBox VMs のUNC Pathに戻します
     3.  OSを再起動します

## Installation

* **command**

    `$ bash Install.sh`

 * ubuntu, centosに対し、knife solo cookまでやってくれます
  - 初回のみ利用

## Command Reference

* **cook to all**

    `$ echo "ubuntu13.10 centos6.5" | xargs -n 1 knife solo cook`

* **ubuntu ssh access**

    `$ vagrant ssh ubuntu13.10`

* **CentOS ssh access**

    `$ vagrant ssh centos6.5`

* **Snap shot**

 * On or Commit

    `$ vagrant sahara {on|commit}`

 * Rollback

    `$ vagrant sahara rollback`

* **Vagrant shutdown (vm shutdown)**
 
    `$ vagrant halt {centos6.5|ubuntu13.10}`

* **Vagrant startup (vm start)**

    `$ vagrant up {centos6.5|ubuntu13.10}`


## Future

### Under Consideration

* vm.box増やすかも
* Early OS の boxを追加するかも
* 立ち上げるvmを選択型にするかも
