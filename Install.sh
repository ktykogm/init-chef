#!/bin/bash

msg="Initialize start up for Vagrant on the Chef."
LOGFILE="Install.log"

echo $msg

# Vagrantfile check

[ -f Vagrantfile ]|| { echo "Not found Vagrantfile" ; exit 1; }

vm=$(grep "vm.box" Vagrantfile | grep -v "#" | awk '{ print $3 };')
cmd="prepare cook"

for i in $cmd
do
  echo $vm | xargs -n 1 bundle exec knife solo $i | tee $LOGFILE
done
