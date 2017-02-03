## The Architecture is checked.  (return archName)
##
checkArchitecture () {
	#Select Architecte
	checkArchName=`uname -m`

	case "$checkArchName" in
		"i386" | "i486")
			archName="i386"
			;;
		"i586" | "i686")
			archName="i586"
			;;
		"amd64" | "x86_64")
			archName="x86_64"
			;;
		*)
			archName=""
			;;
	esac
}
checkArchitecture

echo "$archName"
