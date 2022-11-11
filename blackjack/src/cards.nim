import modules, easy

type Card* = object
    name*: string
    value*: int


# Card Constructors:
proc newCard(v: int): Card =
    return Card(name: $v, value: v)
proc newCard(v: int, n: string): Card =
    return Card(name: n, value: v)

# Array of all Cards:
const Cards*: array[13, Card] = [
    # Face Value Cards:
    newCard(2), newCard(3), newCard(4), newCard(5),
    newCard(6), newCard(7), newCard(8), newCard(9),

    # Value 10 Cards:
    newCard(10), newCard(10, "Jack"), newCard(10, "King"), newCard(10, "Queen"),
    
    # Special:
    newCard(0, "Ace")
]


# Private Functions:
proc sumSimple(cards: seq[Card]): int =
    for i, v in cards:
        result += v.value
    return result


# Public Functions:
proc cardallsums*(cards: seq[Card]): seq[int] =
    var already: int = cards.sumSimple
    var all_sums: seq[int]

    # Write all minimum ace value to sequence:
    var aces: seq[int]
    for i, v in cards:
        # only add 1 if it is an ace:
        if v.value == 0: aces.add(1)
    
    # Add other cards and all aces as 1:
    all_sums.add(aces.addAllValues + already)
    
    # Change each ace value from 1 to 11 and add to all_sums:
    for i, v in aces:
        aces[i] = 11
        let aces_summed: int = aces.addAllValues
        # add new ace list to already values:
        all_sums.add(aces_summed + already)
        

    #echo $all_sums
    return all_sums

proc cardbestsum*(cards: seq[Card]): int =
    var all: seq[int] = cards.cardallsums
    var best_sum: int = 100

    # Set best_sum to lowest sum:
    for i in all:
        if i < best_sum: best_sum = i
    
    # Loop over all sums, find the best one
    for i, v in all:
        # Throw out over 21:
        if v > 21: continue

        # Found best possible option:
        if v == 21:
            best_sum = v
            break

        # Update best found option:
        if v > best_sum:
            best_sum = v
    
    return best_sum

proc cardnames*(cards: seq[Card]): string =
    for i, v in cards:
        if result != "": result.add(", ")
        result.add(v.name)
    return result

proc drawcard*(): Card =
    var id: int = rand(Cards.len - 1)
    return Cards[id]
