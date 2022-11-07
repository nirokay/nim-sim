import strutils, strformat, tables
import goods

# User:
var money: float = 20.00
var Inventory: Table[string, int]

# Get User input:
proc userinput(question: string = "Input:"): string =
    io.write(stdout, "\n" & question & "\n> ")
    result = readLine(stdin).strip()
    io.write(stdout, "\n")

# Buying function:
proc buyGood() =
    echo "Name\tPrice\tAmount Left"
    for i, v in Goods:
        var
            n = v.name
            p = v.price
            l = v.left
        echo(n & "\t" & $p & "\t" & $l)
    
    # Buying:
    var request: string = userinput(fmt"What do you want to buy? (Your Money: {money})")
    var amount_r: string = userinput("How many do you want to buy?")
    var amount: int = 0

    try: amount = amount_r.parseInt()
    except ValueError: amount = 0


    for i, v in Goods:
        if v.name.toLower != request.toLower: continue

        # Attempt to purchase:
        if (money - (v.price * float(amount))) < 0:
            echo "You cannot afford this product."
            break

        # Attempt to remove from shelf:
        if (v.left - amount) < 0:
            echo "No more product left to buy."
            break

        # Actually Buying:
        money -= v.price * float(amount)
        Goods[i].left -= amount

        if not Inventory.haskey(v.name):
            Inventory[v.name] = 0
        Inventory[v.name] += amount
        
        echo fmt"You have bought {amount} {v.name}!"


# Display the Users inventory:
proc displayInventory() =
    const sep: string = "----------------------------------------"
    echo "\n" & sep & "\nYour Inventory:"
    for i, v in Inventory:
        echo $i & "\t" & $v
    echo sep


# Main:
proc main() =
    displayInventory()
    var action: string = userinput("You are in a store and have " & $money & " money, what do you do?")
    const valid: array[4, string] = [
        "exit", "leave",
        "buy", "purchase"
    ]

    case action
    of valid[0..1]:
        echo "You left the store."
        system.quit(0)

    of valid[2..3]:
        buyGood()
    
    else:
        echo "I'm sorry, '" & action & "' is not an option. Valid options are:\n" & $valid

when isMainModule:
    while true:
        main()
