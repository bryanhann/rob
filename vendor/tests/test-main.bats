function setup {
	./vendor.sh bats +bare +repo +bin
}
@test "setup should guarantee existance of ./local/bin/bats" {
	[ -x $HOME/.local/bin/bats ]
}

@test "./vendor.sh bats -bin should remove it" {
	./vendor.sh bats -bin
	[ ! -f $HOME/.local/bin/bats ]
}

@test "./vendor.sh bats +bin should replace it" {
	./vendor.sh bats -bin
	[ ! -f $HOME/.local/bin/bats ]
	./vendor.sh bats +bin
	[ -x $HOME/.local/bin/bats ]
}

@test "setup should guarantee existance of the bob/vendor repo" {
	[[ -d ~/.bob/vendor/git-repo/github.com/sstephenson/bats.git  ]]
}

@test "./vendor.sh bats -repo should remove it" {
	./vendor.sh bats -repo
	[[ ! -d ~/.bob/vendor/git-repo/github.com/sstephenson/bats.git  ]]
}
@test "./vendor.sh bats +repo should restore it" {
	./vendor.sh bats -repo
	[[ ! -d ~/.bob/vendor/git-repo/github.com/sstephenson/bats.git  ]]
	./vendor.sh bats +repo
	[[ -d ~/.bob/vendor/git-repo/github.com/sstephenson/bats.git  ]]
}


