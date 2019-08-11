function isurl {
		echo $1 | grep "://" > /dev/null   # does $ARG have substring ://? 
}
return
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

export _test=0
export k_prefix=/tmp/kkk
function main {
	while true; do
		case .$1 in 
			.-t)
				export k_test=$2
				shift 2
				;;
			.-p)
				export k_prefix=$2
				shift 2
				;;
			*)
				export k_args=$*
				break
				;;
		esac
	done
#	set | grep ^k_
	k_test.${k_test}
}

function k_test.prefix {
	echo ${k_prefix}
}
main $*	
exit
shift
fixargs $*

#[[ -z URL ]] || git clone ${URL} ${DST} 
#git clone ${ACC}


