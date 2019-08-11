function setup {
	# U and V should be recognized as urls
	# u and v should be what they are replaced with
	# A and B should not be recongized as urls.
	source ./utils.sh
	export U=abc://def/ghi
	export u=abc/def/ghi
	export V=//def:gh:/kij/abd://def/ghi
	export v=//def:gh:/kij/abd/def/ghi
	export A=abc:/def/ghi
	export B=abc//def/ghi
	export C=abc/def/ghi
	export P=someprefix
}

#---------------------------------------------------------------------------
# is_url ARG
#---------------------------------------------------------------------------
# Exit zero iff ARG contains the substring '://'
#---------------------------------------------------------------------------
@test "is_url should accept URL1" { run is_url $U ; [[ $status -eq 0 ]] ; }
@test "is_url should accept URL2" { run is_url $V ; [[ $status -eq 0 ]] ; }
@test "is_url should reject NON1" { run is_url $A ; [[ $status -eq 1 ]] ; }
@test "is_url should reject NON2" { run is_url $B ; [[ $status -eq 1 ]] ; }
@test "is_url should reject null" { run is_url    ; [[ $status -eq 1 ]] ; }

#---------------------------------------------------------------------------
# strip_url ARG
#---------------------------------------------------------------------------
# Echo ARG with occurances of '://' replaced with '/'
#---------------------------------------------------------------------------
@test 'Invoke [strip_url $U   ] -> $u' { run strip_url $U ; [[ .$output == .$u ]] ; }
@test 'Invoke [strip_url $V   ] -> $v' { run strip_url $V ; [[ .$output == .$v ]] ; }
@test 'Invoke [strip_url $A   ] -> $A' { run strip_url $A ; [[ .$output == .$A ]] ; }
@test 'Invoke [strip_url      ] ->   ' { run strip_url    ; [[ .$output == .     ]] ; }

#---------------------------------------------------------------------------
# get_url [arguments]
#---------------------------------------------------------------------------
# echo the *first* argumebt that is recognized as a URL
#---------------------------------------------------------------------------
@test "get_url U     " { run get_url $U       ; [[ .$output == .$U ]] ; }
@test "get_url V     " { run get_url $V       ; [[ .$output == .$V ]] ; }
@test "get_url V U   " { run get_url $V $U    ; [[ .$output == .$V ]] ; }
@test "get_url U V   " { run get_url $U $V    ; [[ .$output == .$U ]] ; }
@test "get_url A U V " { run get_url $A $U $V ; [[ .$output == .$U ]] ; }
@test "get_url U A V " { run get_url $U $A $V ; [[ .$output == .$U ]] ; }
@test "get_url U V A " { run get_url $U $V $A ; [[ .$output == .$U ]] ; }
@test "get_url A B   " { run get_url $A $B    ; [[ .$output == .   ]] ; }
@test "get_url A     " { run get_url $A       ; [[ .$output == .   ]] ; }
@test "get_url null  " { run get_url          ; [[ .$output == .   ]] ; }

@test "replace1      " { run replace        a://b X c://d ; [[ "$output" == "a/b X c/d"        ]] ; }
@test "replace3      " { run replace  -cfoo a://b X c://d ; [[ "$output" == "fooa/b X fooc/d"  ]] ; }
@test "count_url A U V B " { run count_url $A $U $V $B ; [[ "$output" == "2" ]] ; }
@test "count_url A U B   " { run count_url $A $U $B    ; [[ "$output" == "1" ]] ; }
@test "count_url A B     " { run count_url $A $B       ; [[ "$output" == "0" ]] ; }

