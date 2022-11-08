# Display prompt and return user input:
proc userinput*(displaytext: string = "Input:"): string =
    stdout.write(displaytext & "\n > ")
    return stdin.readLine
