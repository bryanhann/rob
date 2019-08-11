function fixargs {
	unset URL
	unset DST
	unset ACC
	for ARG in $*; do
		echo ${ARG} | grep "://" > /dev/null   # does $ARG have substring ://? 
		if [ $? -eq 0 ]; then
			URL=$ARG
			DST=$PREFIX/$(echo ${URL} | sed s_://_/_) 
			ARG=${DST}
		fi
		ACC="${ACC} ${ARG}"
	done 
}

case .$1) in 
	--test)
		PREFIX=$2 ; shift 2
		fixargs $*
		echo ${ACC}
		;;
exac
exit
shift
fixargs $*

#[[ -z URL ]] || git clone ${URL} ${DST} 
#git clone ${ACC}


