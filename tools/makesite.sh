#!/bin/sh
# Why copy paste webby site when you can copy paste code to copy paste the webby site
# I am not a professional

# Where am I!
# (There is probably some command to do this but I forgot... Oopsie)
[ "${0%/*}" != "$0" ] && { cd "${0%/*}" || exit 1; }

websrc=../web-src
webroot=../site-root

# Old away
rm $webroot/*

# Copy le full html files
for file in "$websrc/"*
do
	[ -d "$file" ] && continue            # I can't believe it wasn't a file
	[ "${file##*/}" = "skel.html" ] && continue # Don't need it... yet!

	cp "$file" "$webroot"
done

# We need a little baby function
# not two
# promise
skel_eton() (
	splat() (
		while read -r line
		do printf '%s\n' "$line"
		done < "$1"
	)

	while read -r line
	do
		printf '%s\n' "$line"
		case $line in
			'<!-- Content -->') splat "$1" ;;
		esac
	done < "$websrc/skel.html"
)

# Copy le content to le skel                                                      eton
for file in "$websrc/content/"*
do skel_eton "$file" > "$webroot/${file##*/}"
done
