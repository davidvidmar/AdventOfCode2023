import Foundation

let day = "07"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var result1 = 0

var hands = lines.map { Hand(line: $0, jokerRule: false) }

var sortedHand = hands.sorted(by: { $0.Value < $1.Value })
for (i, hand) in sortedHand.enumerated() {
    //print (hands[0].Cards)
    //print ("\(hand.Name): \(i+1) * \(hand.Bid) = \((i + 1) * hand.Bid), \(hand.Value)")
    result1 += (i+1) * hand.Bid
}
    
print("Part 1: \(result1)")

// part 2

var result2 = 0

hands = lines.map { Hand(line: $0, jokerRule: true) }

sortedHand = hands.sorted(by: { $0.Value < $1.Value })
for (i, hand) in sortedHand.enumerated() {
//    print ("\(i) - \(hand.Name): \(i+1) * \(hand.Bid) = \((i + 1) * hand.Bid), \(hand.Value)")
//    print ("\(hand.Name) \(i+1) \(hand.Bid) \(hand.Value)")
//    print ("\(hand.Name) \(i+1) \(hand.Bid)")
    result2 += (i+1) * hand.Bid
}

print("Part 2: \(result2)")

// MARK:

struct Hand {
    
    var Name: String
    
    var Bid: Int
    var Cards: [Card]
    
    var JokerRule: Bool
    var Value: Int
    
    init (line: String, jokerRule: Bool) {
        let str = line.components(separatedBy: " ")
        self.init(bid: Int(str[1])!, cards: str[0], jokerRule: jokerRule)
    }
    
    init (bid: Int, cards: String, jokerRule: Bool) {
        
        Bid = bid
        Cards = cards.enumerated().map { Card(card: $0.element, jokerRule: jokerRule) }
        Name = cards
        JokerRule = jokerRule
        
        let jokers = jokerRule ? Cards.filter { $0.Value == 1 }.count : 0
        if (jokerRule && jokers > 0)
        {
            Cards.removeAll(where: { $0.Value == 1 }) // Joker Out!
        }
    
        let counts = Cards.reduce(into: [:]) {
            counts, card in counts[card.Value, default: 0] += 1
        }
        
        var maxCount = counts.values.max() ?? 0
        
        var handValue = 0
        
        if (jokerRule) {
            if (jokers == 5) {
                maxCount = 5
            } else if (counts.filter { $0.value == 5 - jokers }.count >= 1) {
                maxCount = 5
            } else if (counts.filter { $0.value == 4 - jokers }.count >= 1) {
                maxCount = 4
            } else if (counts.filter { $0.value == 2 }.count == 2) {
                if jokers == 1 {
                    maxCount = 3
                    handValue = 50000000000000
                } // full house
            } else if (counts.filter { $0.value == 1 }.count == 2) {
                if jokers == 1 {
                    maxCount = 3
                    //handValue = 50000000000000
                }
            } else if (counts.filter { $0.value == 3 - jokers }.count >= 1) {
                maxCount = 3
            } else {
                maxCount += jokers == 1 ? 1 : 0
            }
        }
        
        handValue += maxCount * 100000000000000
        
        if true {
            if maxCount == 5 {
                
            } else if maxCount == 4 {
                
            } else if maxCount == 3 {
                if (jokers == 0) {
                    if (counts.filter { $0.value == 2 }.count == 1) {
                        handValue += 50000000000000
                    } // full house
                }
            } else if maxCount == 2 {
                if (jokers == 0) {
                    if (counts.filter { $0.value == 2 }.count == 2) {
                        handValue += 50000000000000
                    } // two pairs
                }
            } else if maxCount == 1 {
                
            } else if maxCount == 0 {
                
            } else {
                fatalError("tbd")
            }
        }

        Cards = cards.enumerated().map { Card(card: $0.element, jokerRule: jokerRule) }
        for (i, card) in Cards.enumerated()  {
            handValue += Int(pow(10.0, (Double(10-2*i)))) * card.Value
        }
        
        Value = handValue
        
    }
}

struct Card {
    var Value: Int
    init (card: Character, jokerRule: Bool) {
        switch card {
        case "A":
            Value = 14
        case "K":
            Value = 13
        case "Q":
            Value = 12
        case "J":
            Value = jokerRule ? 1 : 11
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
