type Good* = object
    name*:  string
    price*: float
    left*:  int

proc newGood(Name: string, Price: float = 1.00, Left: int = 10): Good =
    return Good(name: Name, price: Price, left: Left)

# Create Goods and add to the store:
var Goods*: seq[Good] = @[
    newGood("Carrot",    0.30, 20),
    newGood("Potato",    0.24, 30),
    newGood("Choco",     1.70, 7),
    newGood("Coffee",    1.30, 3)
]
