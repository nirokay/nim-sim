import modules, os, terminal
import easy, cards
randomize()


# Variables:
const
    startingPlayerCards: Natural = 2
    startingDealerCards: Natural = 1
var
    dealer*: seq[Card]
    dealerbust = false

    player*: seq[Card]
    playerbust = false
    playerplaying = true


# Colour Functions:
proc dealerEcho(str: string) = styledEcho(fgCyan, str)
proc playerEcho(str: string) = styledEcho(fgYellow, str)
proc drawEcho(str: string) = styledEcho(fgMagenta, str)
proc loseEcho(str: string) = styledEcho(fgRed, str)
proc winEcho(str: string) = styledEcho(fgGreen, str)


# Game Functions:
proc displayGameTable() =
    dealerEcho "Dealers deck: " & dealer.cardnames & "\nClosest to 21-sum: " & $dealer.cardbestsum & "\n"
    playerEcho "Your deck: " & player.cardnames & "\nClosest to 21-sum: " & $player.cardbestsum & "\n"

proc playerdraw() =
    while true:
        case userinput("Do you wish to hit or stand?").strip.toLower
            of "hit", "h", "draw":
                var card: Card = drawcard()
                player.add(card)
                echo "You have drawn " & card.name & "."
                break

            of "stay", "stand", "s", "pass":
                echo "You stood."
                playerplaying = false
                break

            else:
                echo "\nI'm sorry. I don't know what that means. Let's try again..."
    
    # Check if player went bust:
    var best: int = player.cardbestsum
    if best > 21:
        playerEcho "Your best cards value is " & $best & ". You went bust."
        playerplaying = false
        playerbust = true


# Game Loop:
proc gameloop() =
    # Game Variables:
    dealerbust = false
    playerbust = false
    playerplaying = true
    player = @[]
    dealer = @[]

    # Draw initial cards:
    for i in 1..startingPlayerCards: player.add(drawcard())
    for i in 1..startingDealerCards: dealer.add(drawcard())

    # Player Playing:
    while playerplaying:
        displayGameTable()

        playerdraw()
        sleep(1)
    
    # Dealer Playing:
    var hidden = drawcard()
    dealerEcho "The dealer reveals their hidden card: " & hidden.name
    sleep(1000)
    while dealer.cardbestsum < 16:
        var card: Card = drawcard()
        dealer.add(card)
        dealerEcho "The dealer is forced to draw another card. They have drawn " & card.name & ". They are now at a score of " & $dealer.cardbestsum & "!"
        sleep(1000)
    
    # Compare Cards:
    let
        player_final: int = player.cardbestsum
        dealer_final: int = dealer.cardbestsum

    if player_final > 21: playerbust = true
    if dealer_final > 21: dealerbust = true
    echo ""

    # Bust conditions:
    if dealerbust and playerbust:
        drawEcho "Both of you went bust and lose!"
    elif dealerbust:
        winEcho "Dealer went bust, you win with " & $player_final & "!"
    elif playerbust:
        loseEcho "You went bust! Dealer wins with " & $dealer_final & "!"
    
    # No busts, check for winner:
    else:
        if player_final == dealer_final:
            drawEcho "Draw! You both had " & $player_final & "..."
        elif player_final > dealer_final:
            winEcho "You win! You beat the dealer with " & $player_final & " over " & $dealer_final & "!"
        elif player_final < dealer_final:
            loseEcho "You lost! You were beaten by the dealer with " & $dealer_final & " over " & $player_final & "!"
        else:
            echo "What the hell went wrong, this isn't supposed to happen, I swear..."

    # Print out final results:
    echo "\nFinal decks:"
    displayGameTable()


# Main Loop:
proc main() =
    gameloop()
    promptNewGame()

when isMainModule:
    while true: main()

