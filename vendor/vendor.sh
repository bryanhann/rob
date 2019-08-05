export vendor=${HOME}/.bob/vendor
function rp {
	echo \$HOME/$( python -c "import os.path; print os.path.relpath( \"$1\" , \"$HOME\" )" )
}


function note {
	if [ "$2" == "" ]; then
		echo "LU    $( tput sgr 0 1 )$1$( tput sgr0 )"
	else
		echo "LU    $( tput sgr 0 1 )$1 [$( rp "$2" )]$( tput sgr0 )"
	fi
}

function -bin {
	if [ ! -f ${lu_exe_dst} ]; then
		note "-bin: missing:"   ${lu_exe_dst} 
	else
		note "-bin: deleting:"  ${lu_exe_dst}
		rm ${lu_exe_dst}
	fi
	$*
}

function +bin {
	if [ ! -f ${lu_exe_dst} ]; then
		note "+bin: writing:"      ${lu_exe_dst} 
	else
		note "+bin: overwriting:"  ${lu_exe_dst} 
	fi
	echo "${lu_exe_src} \$*" > ${lu_exe_dst}
	chmod +x ${lu_exe_dst}
	$*
}

function .lu {
	function foo {
		export lu_name=${1}
		export lu_protocol=${2}
		export lu_path=${3}
		export lu_bare=${vendor}/git-bare/${lu_path}
		export lu_repo=${vendor}/git-repo/${lu_path}
		export lu_exe_src=${lu_repo}/${4}
		export lu_exe_dst=${HOME}/.local/bin/${5}
		export lu_orig=${lu_protocol}//${lu_path}
	}
	[ "$1" == "" ] && echo arg required && return 1
	foo $( cat ./table | grep "^$1 " )
	shift
	$*
}

function +bare {	
	if [ -d ${lu_bare} ]; then
		note "+bare: pre-exists:"   ${lu_bare}
	else
		note "+bare: cloning to:"   ${lu_bare}
		git clone ${lu_orig} ${lu_bare} --bare
	fi
	$*
}
function -bare {
	if [ ! -d ${lu_bare} ]; then
		note "-bare: missing:"      ${lu_bare}
	else
		note "-bare: removing:"     ${lu_bare}
		rm -rf ${lu_bare}
	fi
	$*
}

function +repo {
	if [ -d ${lu_repo} ]; then
		note "+repo: pre-exists:"   ${lu_repo}
	else
		note "+repo: cloning to:"   ${lu_repo}
		git clone ${lu_bare} ${lu_repo}
	fi
	$*
}
function -repo {
	if [ ! -d ${lu_repo} ]; then
		note "-repo: missing:"      ${lu_repo}
	else
		note "-repo: removing:"     ${lu_repo}
		rm -rf ${lu_repo}
	fi
	$*
}
function __main__ {
	.lu $1 ; shift
	if [ X${lu_name} == X ]; then
	       	echo package [$1] not found
		return 1
	fi
	$*
}

__main__ $*
echo
