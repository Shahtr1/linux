CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE;" | grep -i -v "\.patch;" | while read line; do # throw out every line that is not of this package, also throw out patch
    export VERSION="`echo $line | cut -d\; -f2`"     
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')" 
    # .*  ==>  recognizes any string, in particular the start of the filename
    # \(.*\)  ==>  this here will capture it in a capture group, that we can use in \1
    # \.tar\.  ==>  tar. whatever gz, xs, bz whatever

    # test the regex with  ==> echo foo-1.2.3.tar.gz | sed 's/\(.*\)\.tar\..*/\1/' , result should be foo-1.2.3

    if [ -d "$DIRNAME" ]; then
        rm -rf "$DIRNAME"
    fi
    mkdir -pv "$DIRNAME"


    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME" # this is a cd, we are changing into the directory, but we are storing the old directory on the stack
        if [ "$(ls -1A | wc -l)" == "1" ]; then # we go into the directory, we create list of the directory ls -1A , and we count the number of entries, and if that is 1, then we move everything from that subdirectory ls -1A => gives us name, and everything in there will be moved to current directory, and .* is for explicitly including hidden files.
            mv $(ls -1A)/{*,.*} ./
        fi

        echo "Compiling $PACKAGE"
        sleep 5

        mkdir -pv "../log/chapter$CHAPTER/"
        
        if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then # store the output of whole process in a log file, and redirect stderr of the script to std out, so both are logged in this log file
            echo "Compiling $PACKAGE FAILED!"
            popd # as exit below will bypass the popd below
            exit 1
        fi

        echo "Done Compiling $PACKAGE"
    popd

done

    