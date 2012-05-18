# $FreeBSD: user/dougb/portmaster/files/bash-completions 220533 2011-04-11 03:12:10Z dougb $
#
_portmaster () {
	local cur
	cur=${COMP_WORDS[COMP_CWORD]}

	case "$cur" in
	/usr/ports/*)
		COMPREPLY=( $( compgen -d $cur ) ) ;;
	*/*)	COMPREPLY=( $( compgen -d /usr/ports/$cur ) ) ;;
	--*)	COMPREPLY=( $( compgen -W '--force-config --show-work \
		--packages --packages-only \
		--packages-build --packages-if-newer --delete-build-only \
		--always-fetch --delete-packages \
		--local-packagedir= --packages-local \
		--update-if-newer \
		--no-confirm --no-term-title --no-index-fetch \
		--index --index-first --index-only \
		--clean-distfiles --clean-packages \
		--check-depends --check-port-dbdir --list-origins \
		--help --version' -- $cur ) )
		;;
	*)	COMPREPLY=( $( compgen -d /var/db/pkg/$cur ) )
		COMPREPLY=( ${COMPREPLY[@]#/var/db/pkg/} )
		COMPREPLY=( ${COMPREPLY[@]} $( compgen -d /usr/ports/$cur ) )
		COMPREPLY=( ${COMPREPLY[@]#/ports/} )
		;;
	esac

	return 0
}
complete -F _portmaster portmaster
