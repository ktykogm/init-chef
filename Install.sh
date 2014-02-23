#!/bin/bash

# Please check README.

readonly msg=": Initialize start up for Vagrant on the Chef."
readonly LOGFILE="Install.log"
readonly bundler="bundle exec"
readonly vm=$(grep "vm.box" Vagrantfile | grep -v "#" | awk '{ print $3 }'|sed s/\"//g)
readonly cmd="prepare cook"
readonly progress_msg="Initialization in progress ---> "
readonly wait_msg='Please wait....'
berks="$bundler berks"
knife="$bundler knife"

rm -f $LOGFILE

progress(){
  echo $progress_msg $1
  sleep 1
}

err_handle(){
  [ $? -eq 0 ] || { \
    echo `timestmp` ": Setup is interrupted because there was a failure of $1 $2. "|logging;\
    echo `timestmp` ": Chef-solo setup has stopped."|logging;\
    echo "Please check $LOGFILE"
    exit 1; }
}

logging() {
  tee -a $LOGFILE
}

timestmp(){
  date +%m/%d-%H:%M:%S-%Y
}

echo `timestmp` $msg |logging

# Checking whether Vagrant is installed.
# It does not use the Gem, because old.
[ `which vagrant` ] || { echo "Please install Vagrant. See: http://www.vagrantup.com/downloads.html" ;exit 1; }


# Bundle install
echo `timestmp` ": Start of bundler." |logging
bundle install --path vendor/bundle
err_handle bundle install
echo `timestmp` ": End of bundler." |logging

progress 10%

# SSH-Key check.
echo "Checking ssh-key of chef for the knife."
ssh_key=$(grep client_key .chef/knife.rb | awk '{print $2}'| sed s/\'//g )
if [ -f $ssh_key ];then
  echo "$ssh_key was discovered!"
else
  echo `timestmp` ": Not found client_key. Please check .chef/knife.rb " |logging
  echo `timestmp` ": Had you made the key to Chef?" |logging
  exit 1
fi

progress 15%

# Bundler check
echo "Checking use of the bundle of gems."
for bundles in berks knife
do
  bundle show $bundles
  [ $? = 7 ] && $bundles=${bundles#$bundler}
done

progress 20%

# Berkshelf check
[ -f Berksfile ] && { \
  echo 'Berksfile was discovered!';
  $berks ;\
}

err_handle berkshelf

progress 30%

# Vagrantfile check

[ -f Vagrantfile ]|| { echo "Not found Vagrantfile" ; exit 1; }

echo `timestmp` ": Starting Vagrant."|logging
echo "$wait_msg"

vagrant box list | grep -E "$(echo $vm | sed 's/\ /|/g' )"

if [ $? = 0 ];then
  echo `timestmp` ": The Vagrant have boxes." |logging
else
  echo `timestmp` ": You have not boxes in your vagrant." |logging

  for i in $vm
  do
    case $i in
      "ubuntu13.10")
        vagrant box add $vm http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box |logging
        echo "Added vagrant box of $i"
        ;;
      "centos6.5")
        vagrant box add $vm https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box |logging
        echo "Added vagrant box of $i"
        ;;
      *)
        echo "Please check Vagrantfile."
        echo "The name of \"vm.box\" is different from an assumption.
        Please add box by oneself."
        exit 1
    esac
  done
fi

echo `timestmp` ": Run vagrant-up." |logging
vagrant up
err_handle vagrant-up
echo `timestmp` ": Vagrant has been started." |logging

progress 50%

echo "Check of ssh config for vagrant access."
for i in $vm
do
  [[ $(grep $i ~/.ssh/config) ]] || { \
    vagrant ssh-config $i >> ~/.ssh/config ;
    echo "Added .ssh/config for access of the vagrant.";
  }
done

progress 60%

# Sahara install and on.
vagrant plugin list | grep sahara
[ $? = 0 ] || vagrant plugin install sahara |logging
vagrant sandbox on

# knife solo start.
echo "knife solo start"
for i in $cmd
do
  echo "$wait_msg"
  echo `timestmp` ": Starting of the knife solo $i" |logging
  echo $vm | xargs -n 1 $knife solo $i
  err_handle knife-solo
done

echo `timestmp` ": knife solo command is finished!." |logging
echo
echo "Sahara commit."
vagrant sandbox commit $vm

progress 100%
echo `timestmp` ": All finished!!" |logging
echo "Please check Install.log"
exit 0
