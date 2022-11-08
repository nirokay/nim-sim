import tables, random
randomize()


# Different Styles for language templates:

type Style* = object
    vowels*: string
    alphabet: string # used to generate ...
    consonants*: string # ... consonants on object init (saves me time and sanity)

proc newStyle(vow, alp: string): Style =
    var con: string
    for i in alp:
        if not(i in vow): con.add(i)
    
    return Style(vowels: vow, alphabet: alp, consonants: con)

let Styles*: Table[string, Style] = {
    "german": newStyle(
        "eiauoüäö",
        "enirtsahduclgmobfwzkvpüäößjxqy"
    ),
    "english": newStyle(
        "eaoiuy",
        "etaoinshrdlcumwfgypbvkjxqz"
    )
}.toTable

#[
    Currently inactive:
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Letters are ordered by their frequency.
    Don't sue me if it is wrong in like a minimal amount, it's
    just to give more "accurate" names. :)

    Sources for language data:
        https://de.wikipedia.org/wiki/Buchstabenh%C3%A4ufigkeit
        https://en.wikipedia.org/wiki/Letter_frequency
        http://www.ravi.io/language-word-lengths
]#


# Word Structure:

const NameStructure*: array[30, string] = [
    #[ 2 ]# ".a", "a.",
    #[ 3 ]# "a.a", ".a.", "a..",
    #[ 4 ]# "a.a.", "a..a", "aa..", ".aa.", ".a.a", ".a.a",
    #[ 5 ]# "a..a.", "a.a..", ".a.a.", ".a..a", ".a.a.", ".a..a", ".a.a..",
    #[ 6 ]# ".a.a..", "a.a..a", ".a..a.", "..a.a.", ".a.a.a", "a.a.a.",
    #[ 7 ]# "a..a.a.", ".a.a...", ".a..a..", "a..a..a", ".a..aa.", "a.a..a."
]

proc newStructure(): string =
    return NameStructure[rand(NameStructure.len - 1)]

proc randomCharFromString(s: string): char =
    var l: int = s.len
    var i: int = rand(l-1)
    return s[i]

proc newLetters(language: Style, strucutre: string): Table[string, string] =
    var vow, con: string
    for i in strucutre:
        case i:
            of '.':
                con.add($randomCharFromString(language.consonants))

            of 'a':
                vow.add($randomCharFromString(language.vowels))

            else:
                discard

    result = {
        "vowel": vow,
        "consonant": con
    }.toTable
    return result

proc generateNewWord*(language: Style): string =
    # Get random structure:
    var structure: string = newStructure()

    # Get random letters:
    var letterPool: Table[string, string] = newLetters(language, structure)

    # Construct new Word:
    var vow, con: int
    for i in structure:
        case i:
            of 'a':
                result.add($letterPool["vowel"][vow])
                vow.inc

            of '.':
                result.add($letterPool["consonant"][con])
                con.inc

            else:
                result.add("?")


    return result
