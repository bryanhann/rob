function E { echo $* ;             } # Echo
function T { shift ; E $* ;        } # Tail
function H { E $1 ;                } # Head
function N { [ "$1" == "" ] ;      } # Null
function K { $* && E 1 || E 0 ;    } # Kronecker

function count_url { N $1 && E 0 || E $((  $(K is_url $(H $*)) + $(count_url $(T $*))  )) ; }
function get_url   { N $1 && return ; is_url $(H $*) && E $(H $*) || E $(get_url $(T $*)) ; }
function is_url    { E $1 | grep "://" > /dev/null ; }
function strip_url { E $1 | sed s_://_/_ ; }
function def       { export $1=$2 ; }
function strip     { echo $* ; }

function klone {
        if [ "$__klonecache" == "" ]; then
		__klonecache=/tmp/klonecache/
	fi
        if [[ ! .$(count_url $*) == .1 ]]; then
               echo "git clone $*"
        else   
		echo git clone ${get_url $* } #${__klonecache}${strip_url}
        	echo git clone $(replace -c$__klonecache $*)
        fi      
}       

function get_prefix {
	prefix=$( echo $1 | sed 's|^\-c||' )
	[ "$prefix" == "$1" ] && unset prefix 
	echo $prefix
}
function replace {
	prefix=$( get_prefix $1 )
	[ "$prefix" == "" ] || shift
	for A in $* ; do
		if is_url $A ; then 
			acc="$acc ${prefix}$(strip_url $A)" 
		else
			acc="$acc $A"
		fi
	done
	echo $(strip $acc)
}
