#!/bin/bash
vbm=/usr/local/bin/VBoxManage

if ! $vbm showvminfo EAWIN --machinereadable | egrep '^VMState="running"$' > /dev/null; then
	$vbm snapshot EAWIN take started
	$vbm startvm EAWIN
fi
