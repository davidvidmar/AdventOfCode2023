import Foundation

let day = "07"
print("AoC 2023, Day \(day)\n")

// MARK: load and parse
print("Parsing: ", terminator: "")
var startTime = DispatchTime.now()

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

var hands = lines.map { Hand(line: $0) }

print("\(lines.count) lines ", terminator: "")
print("(\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)\n")

// MARK: part 1

print("Part 1: ", terminator: "\n")
startTime = DispatchTime.now()

var result1 = 0

let sortedHand = hands.sorted(by: { $0.Value < $1.Value })
for (i, hand) in sortedHand.enumerated() {
    //print (hands[0].Cards)
    print ("\(i+1) * \(hand.Bid) = \((i + 1) * hand.Bid), \(hand.Value)")
    result1 += (i+1) * hand.Bid
}
    
print("Part 1: \(result1) (\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)")

// MARK: part 2

print("Part 2: ", terminator: "")
startTime = DispatchTime.now()

var result2 = 0
//...

print("\(result2) (\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)\n")

// MARK:

struct Hand {
    var Name: String
    var Bid: Int
    var Cards: [Card]
    var Value: Int
    
    init (line: String) {
        let str = line.components(separatedBy: " ")
        self.init(bid: Int(str[1])!, cards: str[0])
    }
    
    init (bid: Int, cards: String, part: Int) {
        
        Bid = bid
        Cards = cards.enumerated().map { Card(card: $0.element) }
        Name = cards
        //print(Name)
        
        let counts = Cards.reduce(into: [:]) {
            counts, card in counts[card.Value, default: 0] += 1
        }
        let maxCount = counts.values.reduce(0, { max($0, $1) })
        var handValue = maxCount * 100000000000000
            
        if maxCount == 2 {
            // two pairs
            if (counts.values.filter({ $0 == 2 }).count == 2) { handValue += 50000000000000 }
        } else if maxCount == 3 {
            // full house
            if (counts.values.filter({ $0 == 2 }).count == 1) { handValue += 50000000000000 }
        } else if maxCount == 4 {
            
        } else if maxCount == 5 {
            
        } else if maxCount == 1 {
            
        } else {
            //
            fatalError("tbd")
        }

        
        for (i, card) in Cards.enumerated()  {
            handValue += Int(pow(10.0, (Double(10-2*i)))) * card.Value
        }
        
        Value = handValue
        
    }
}

struct Card {
    var Value: Int
    init (card: Character) {
        switch card {
        case "A":
            Value = 14
        case "K":
            Value = 13
        case "Q":
            Value = 12
        case "J":
            // Value = 11 - part 1
            Value = 11
        case "T":
            Value = 10
        default:
            Value = Int(String(card))!
        }
    }
}

/*
 
 Algorithm for Ranking Poker Hands:

 1. Start
 2. Create an empty dictionary to map the card values to numerical values.
 3. Assign the numerical values to card values as per:
    '2' is 2, '3' is 3, '4' is 4,5' is 5, '6' is , '7' is7, '8' 8, '9' is 9,T' is 10, 'J' is 11, 'Q' is 12, 'K' is 13, and 'A' is 14.
 4. Define functions to recognize different hand ranks such as High Card, One Pair, Two Pair, Three of a Kind, Straight, Flush, Full House, Four of a Kind, Straight Flush, and Royal Flush.
 5. In each function, parse the hand and map each card to its numerical value using the dictionary.
 6. Check for the rank of the hand by comparing the numerical values, patterns, or sequences.
 7. For, One Pair: Check if two cards have the same rank.
 8. For, Two Pair: Check if there are two different pairs.
 9. For, Three of a Kind: Check if three cards have the same rank.
 10. For, Straight: Check if the hand has 5 consecutive cards of any suit.
 11. For, Flush: Check if all the cards are of the same suit.
 12. For, Full House: Check for one pair and a three of a kind in the same hand.
 13. For, Four of a Kind: Check if four cards have the same rank.
 14. For, Straight Flush: Check if the hand has five consecutive cards all of the same suit.
 15. For, Royal Flush: Check if the hand is a straight flush, and the cards are Ten, Jack, Queen, King, and Ace.
 16. Rate the hand using the rank of the hand (e.g., assign weight 1 for High Card, 2 for One Pair, up to 10 for Royal Flush).
 17. If two hands have the same rank, compare the highest card(s) of each. If they are also the same, compare the next highest, and so on.
 18. Declare the hand with the highest weighted rank or highest card as the winner.
 19. End
 
 */
