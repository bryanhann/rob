cd $(dirname $0)
export BOB=$(dirname $PWD)
export PATH=$BOB/bin:$PATH
[ "$1" == "" ] && export NEXT=default || export NEXT=$1
bash --rcfile $BOB/here/shell.rc
