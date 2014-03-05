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
* Vagrant

## Notice

* Cygwinは、以下の対応が必要です
`$ peflags -v -x$[ 2*1024**2 ] -X$[ 256*2048 ] ~/.rbenv/versions/*/bin/ruby`
* See : http://seesaawiki.jp/w/kou1okada/d/Cygwin%20-%20Ruby

## Installation

`$ bash Install.sh`

* knife solo cookまでやってくれます(オレのために)

## Command Reference

    $ echo "ubuntu13.10 centos6.5" | xargs -n 1 knife solo cook
    $ vagrant ssh ubuntu13.10

## Future

### Under Consideration

* vm.box増やすかも
* Early OS の boxを追加するかも
* 立ち上げるvmを選択型にするかも
