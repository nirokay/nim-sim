import modules

# Easy Player Prompt:
proc userinput*(str: string = "Input:"): string =
    stdout.write(str & " > ")
    return stdin.readLine()

# Add all numbers in a sequence:
proc addAllValues*[T](sequence: seq[T]): T =
    for i, v in sequence:
        result += v
    return result

# Ask for new game:
proc promptNewGame*() =
    while true:
        case userinput("Do you want to play another round of Blackjack? [y/n]").strip.toLower
            of "y":
                echo "Good Luck to you!\n\n------------------------------------\n"
                break

            of "n":
                echo "Goodbye!"
                quit(0)

            else:
                echo "I'm sorry. I don't know what that means. Let's try again:"

