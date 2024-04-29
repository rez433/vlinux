#!/usr/bin/env bash
#
# A template for creating command line scripts taking options, commands
# and arguments.
#
# Exit values:
#  0 on success
#  1 on failure
#



# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"



#
# Message to display for usage and help.
#
function usage
{
    local txt=(
"Utility $SCRIPT for doing stuff."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"Command:"
"  cal                          Print out current calendar with(out) events."
"  greet                        To greet user"
"  loop <min> <max>             To print numbers between min and max."
"  lower <n n n...>             Print out all numbers smaller than 42."
"  reverse <random sentence>    Print out a sentence in reverse."
"  all                          Runs all the commands above and prints out the results."
""
"Options:"
"  --help, -h     Print help."
"  --version, -h  Print version."
    )

    printf "%s\\n" "${txt[@]}"
}



#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
"For an overview of the command, execute:"
"$SCRIPT --help"
    )

    [[ -n $message ]] && printf "%s\\n" "$message"

    printf "%s\\n" "${txt[@]}"
}



#
# Message to display for version.
#
function version
{
    local txt=(
"$SCRIPT version $VERSION"
    )

    printf "%s\\n" "${txt[@]}"
}



#
# Function for taking care of specific command. Name the function as the
# command is named.
#
function app-greet
{
    echo "Hello ${SUDO_USER:-$USER} from greet command."
}



#
# Function for taking care of specific command. Name the function as the
# command is named.
#
function app-loop
{
    for (( i=$1; i<=$2; i++))
    do
        echo "$i"
    done
}


function app-lower
{
    forty2=()
    antal="$#"
    lst=("$@")

    for (( i=0; i<antal; i++))
    do
        x="${lst[$i]}"
        if [ "$x" -lt 42 ]
        then
            forty2+=("$x")
        fi
    done

    echo "${forty2[*]}"
}


function app-reverse
{
    echo "$@" | rev

}


#
# Function for taking care of specific command. Name the function as the
# command is named.
#


function app-cal
{
    local events="$1"

    cal -3

    if [ "$events" = "events" ]; then
        echo
        calendar
    fi
}



function app-all
{
    echo -e "\\n Demonstration of all functions with example:\\n"
    echo -e "*** To show the calendar, run:"
    echo -e " ./commands.bash cal events\\n "
    app-cal events
    echo -e "*** To get the username and greet them, run: "
    echo -e " ./commands.bash greet\\n "
    app-greet
    echo -e "\\n *** To iterate over numbers between min and max numbers given by user, run: "
    echo -e " ./commands.bash loop 1 7\\n"
    app-loop 1 7

    echo -e "\\n *** To iterate over list of numbers given by user and return numbers smaller than 42, run: "
    echo -e " ./commands.bash app-lower 1 7 22 35 41 55 88 40\\n"
    app-lower 1 7 22 35 41 55 88 40

    echo -e "\\n *** To reverse a given sentence, run: "
    echo -e "./commands.bash reverse random sentence\\n"
    app-reverse random sentence
    echo -e "\\n End of Demonstraion \\n"
}






#
# Process options
# in case no arguments supplied
#
if [ $# -eq 0 ]
  then
    app-all
    exit 0
fi


#
# Process options
# in case arguments supplied
#
while (( $# ))
do
    case "$1" in

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;

        cal         \
        | greet     \
        | loop      \
        | lower     \
        | reverse   \
        | all)
            command=$1
            shift
            app-"$command" "$@"
            exit 0
        ;;

        *)
            badUsage "Option/command not recognized."
            exit 1
        ;;

    esac
done

badUsage
exit 1
