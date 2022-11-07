import strutils, easy, throw

# Variables:
const
    out_sep*:string = " " # funky space unicode: helps fix some tabing issues

    out_group*: int = 4
    out_group_sep*: string = "\t"

    out_column*: int = 7

# Throw operation:
proc callThrow() =
    var times, die: int

    # Get user input:
    try:
        times = userinput("How many times do you want to throw a die?").parseInt
        if times < 1: echo "You have to provide a positive integer as input!"; return

        die = userinput("Select the die you want to throw *" & alldice & "*:").parseInt

    except ValueError: echo "You have to provide a positive integer as input!"; return

    # Get random rolls:
    var rolls: seq[int] = @[]
    var cont: bool = true

    case die:
        of dice[0..^2]:
            rolls = throwDie(times, die)

        of dice[^1]:
            # 100 Die Exception:
            rolls = throw100(times, die)
        else:
            echo "Invalid die option."
            cont = false

    # Print out results:
    if not cont: return
    for i, v in rolls:
        # Handle formating:
        if i mod (out_column*out_group) == 0:
            stdout.write("\n")
        elif i mod out_group == 0:
            stdout.write(out_group_sep)
        else:
            stdout.write(out_sep)
        # Write out value:
        stdout.write(v)
    stdout.write("\n")


# Main:
when isMainModule:
    callThrow()
