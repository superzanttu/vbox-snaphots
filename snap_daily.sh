#!/bin/bash
vbm=/usr/local/bin/VBoxManage
vm=EAWIN


wday=$(date +%u)


if ! $vbm showvminfo $vm --machinereadable | egrep '^VMState="running"$' > /dev/null; then
	sname=daily
	$vbm snapshot $vm take $sname
fi
