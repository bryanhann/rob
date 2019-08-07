function setup {
	./vendor.sh bats +bare +repo +bin
}
@test "setup should guarantee existance of the bob/vendor bare" {
	[[ -d ~/.bob/vendor/git-bare/github.com/sstephenson/bats.git  ]]
}
@test "./vendor.sh bats -bare should remove it" {
	./vendor.sh bats -bare
	[[ ! -d ~/.bob/vendor/git-bare/github.com/sstephenson/bats.git  ]]
}
@test "./vendor.sh bats +bare should restore it" {
	./vendor.sh bats -bare
	[[ ! -d ~/.bob/vendor/git-bare/github.com/sstephenson/bats.git  ]]
	./vendor.sh bats +bare
	[[ -d ~/.bob/vendor/git-bare/github.com/sstephenson/bats.git  ]]
}

