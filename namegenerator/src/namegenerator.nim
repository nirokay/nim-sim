import strutils, tables, times, data, easy

# Main Function (holy shit, it's so long):
when isMainModule:
    var
        language: Style
        language_list: string
        generate_times: Natural

    # Create list of languages user can pick:
    for i, v in Styles:
        if language_list != "": language_list.add(", ")
        language_list.add(i)


    # Get user input for language:
    while true:
        try:
            let input: string = userinput("Please pick a language style from the following options:\n" & language_list).strip.toLower
            language = Styles[input]
            break
        
        except KeyError:
            echo "You have to select a valid option."
    
    # Get user input for amount:
    while true:
        try:
            let input: int = userinput("Specify the wished amounts of words:").parseint
            generate_times = input
            break
        except ValueError:
            echo "You have to provide a natural number above zero."
    if generate_times < 1: generate_times = 1

    # Time measuring:
    var timer_begin, timer_end: float
    timer_begin = epochTime()*1000

    # Generate Word(s):
    var words: seq[string]
    for i in 1..generate_times:
        let w: string = generateNewWord(language)
        words.add(w)

    # Print out words:
    for i, v in words:
        echo $(i+1) & ":\t" & v

    # Print out time information:
    timer_end = epochTime()*1000
    echo "\nGenerated " & $generate_times & " names. Time elapsed: " & $(timer_end - timer_begin) & "ms"
