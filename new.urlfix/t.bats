#./fix.sh git clone https://github.com/sstephenson/bats mybats
rm -rf a
rm -rf b
rm -rf c
rm -rf d
rm -rf ~/.cache/https 

#url=https://github.com/sstephenson/bat
#cache=~/.clone/https/github/sstephenson/bat
url=https://github.com/bryanhann/test-marco
cache=~/.clone/https/github/bryanhann/test-marco
T=/tmp/$RANDOM

function setup {
	export X="run ./k.sh"
}
@test "isurl with url string should pass" {
	source ./k.sh
	isurl w://3
}
@test "isurl on empty2 " {
	source ./k.sh
	isurl  && false || true
}

@test "cache should be empty" {
	[ ! -d $cache ]
}
@test "T should be empty" {
	[ ! -d $T ]
}

@test "-t prefix -p foo" { $X -t prefix -p foo ; [ X$output == Xfooix ] ; }

@test "-p foo -t prefix" { run ./k.sh -t prefix -p foo ; [ X$output == Xfoo ];  }
@test "-t prefix" { run ./k.sh -t prefix ; [ X$output == X/tmp/kkk ] ; }
