#!/bin/bash
# Delete development snapshots (dev_state), but keep latest one.

vm_list=("EAWIN")

function delete() {
  # Parameters
  vm=$1
  sname=$2
  keep=$3

  # Count snapshots
  snaps=$(VBoxManage snapshot $vm list | grep -i "$sname" | wc -l)

  echo Keep $keep \'$sname\' snapshots on vm $vm

  if [ $snaps -gt $keep ]; then
    dcount=$(($snaps - $keep))
    echo Delete $dcount of $snaps oldest \'$sname\' snapshots
    VBoxManage snapshot "$vm" list | grep -i "$sname"| head -n $dcount | awk -F "UUID: " '{print $2}' | awk -F ")" '{print $1}' | xargs -L1 VBoxManage snapshot "$vm" delete
  else
    echo Nothing to do. Vm have $snaps  \'$sname\' snapshots
  fi
}

for vm in ${vm_list[*]}; do

  keep=4
  sname="started"
  delete $vm $sname $keep

  keep=4
  sname="daily"
  delete $vm $sname $keep


  #VBoxManage snapshot "$vm" list | head -n 5 | awk -F "UUID: " '{print $2}' | awk -F ")" '{print $1}' | xargs -L1 VBoxManage snapshot "$vm" delete
done



echo Done.
