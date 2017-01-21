# every OS setting
case ${OSTYPE} in
  darwin*)
    # Mac
    export CLICOLOR=true
    ;;
  linux*)
    # Linux
    ;;
esac

case ${OSTYPE} in
  darwin*)
    function tp() {
      if [ $# -ne 1 ] ; then
        echo "    invalid argument."
        echo "    use 0 - 9"
      else
        echo "
          tell application \"iTerm\"
            activate -- make window active
            tell current session of current window
              set transparency to $1/10
            end tell
          end tell
        " | /usr/bin/osascript -
      fi
    }
    ;;
esac
