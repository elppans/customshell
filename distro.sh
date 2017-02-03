#!/bin/bash

## Do distribution check. (return distName)
##
checkDistribution()
{
	# check distribution
	checkdistName=`lsb_release -d 2>/dev/null`
	os=`echo "$checkdistName" | awk '{print $2}'`
	ver=`echo "$checkdistName" | awk '{print $3}'`
	p4=`echo "$checkdistName" | awk '{print $4}'`
	p5=`echo "$checkdistName" | awk '{print $5}'`
	if [ -n "$os" ]; then
		if [ "Fedora" = $os ]; then
			ver=$p4
		fi
		if [ "CentOS" = "$os" ]; then
			ver=$p5
		fi
		if [ "Ubuntu" = $os ]; then
			if [ "12." = "${ver:0:3}" -o "14." = "${ver:0:3}" -o "16." = "${ver:0:3}" ]; then
				ver=${ver:0:5}
			fi
		fi
		if [ "SUSE-Linux-Enterprise-Desktop" = "$os-$ver-$p4-$p5" ]; then
			os="SLED"
			ver=`echo "$checkdistName" | awk '{print $6}'`
		fi
		if [ "Red-Hat-Enterprise-Linux" = "$os-$ver-$p4-$p5" ]; then
			os="RHEL"
			ver=`echo "$checkdistName" | awk '{print $8}'`
		fi
	fi
	if [ -z "$os" ]; then
		cat /etc/*release | grep -q "openSUSE" > /dev/null 2>&1
		if [ 0 -eq $? ]; then
			os="openSUSE"
			ver=`cat /etc/*release | head -1 | awk '{print $2}'`
		else
			cat /etc/*release | grep "_ID=" | grep -q "Ubuntu" > /dev/null 2>&1
			if [ 0 -eq $? ]; then
				os="Ubuntu"
				ver=`cat /etc/*release | grep DISTRIB_RELEASE=`
				ver=${ver#DISTRIB_RELEASE=}
			else
				cat /etc/*release | head -1 | grep -q "Fedora" > /dev/null 2>&1
				if [ 0 -eq $? ]; then
					os="Fedora"
					ver=`cat /etc/*release | head -1 | awk '{print $3}'`
				else
					cat /etc/*release | head -1 | grep -q "CentOS" > /dev/null 2>&1
					if [ 0 -eq $? ]; then
						os="CentOS"
						ver=`cat /etc/*release | head -1 | awk '{print $3}'`
					else
						cat /etc/*release | head -1 | grep -q "Red Hat Enterprise Linux" > /dev/null 2>&1
						if [ 0 -eq $? ]; then
							os="RHEL"
							ver=`cat /etc/*release | head -1 | awk '{print $7}'`
						else
							os="Unknown"
						fi
					fi
				fi
			fi
		fi
	fi
	distName="$os-$ver"

}
checkDistribution

echo "$distName"
