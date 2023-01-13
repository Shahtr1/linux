cat packages.csv | while read line; do
    NAME="`echo $line | cut -d\; -f1`"        # cut program allows us to go to a specific point to a line
    VERSION="`echo $line | cut -d\; -f2`"     
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    MD5SUM="`echo $line | cut -d\; -f4`"  

    CACHEFILE="$(basename "$URL")"      # basename just gives us the last part of this url string, when you cut everything at forward slashes

    # echo NAME $NAME
    # echo VERSION $VERSION
    # echo URL $URL
    # echo MD5SUM $MD5SUM
    # echo CACHEFILE $CACHEFILE

    if [ ! -f "$CACHEFILE" ]; then
        echo "Downloading $URL"
        wget "$URL"

        # The below lines are commited because of xz-utils, which is downloaded manually
        # if ! echo "$MD5SUM $CACHEFILE" md5sum -c >/dev/null; then # if that rejects this input then we will remove the file
        #     rm -f "$CACHEFILE"
        #     echo "Verification of $CACHEFILE failed! MD5 mismatch!"
        #     exit 1
        # fi
    fi

done   