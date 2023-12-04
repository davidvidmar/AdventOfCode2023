import Foundation
 
let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"

// https://adventofcode.com/2023/day/4

let day = "04"
print("Hello, AoC 2023! This is Day \(day).")
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var result1 = 0

let cards = lines.map(Card.init)
for card in cards {
    let result = pow(2, Double(card.wins.filter { card.nums.contains($0) }.count - 1))
    
    // or sets!
    // let winners = Set(nums[0].allInts())
    // let numbers = Set(nums[1].allInts())
    // matches = numbers.intersection(winners).count
    
    // or << instead of pow
    // 1 << (matches - 1) // pow(2, matches - 1)
    
    result1 = result1 + Int(result)
}

print("Part 1: \(result1)")

// part 2

var result2 = 0

var ownedCards = [Int: Int]()
for i in 0..<cards.count  {
    ownedCards[i] = 1
}

for (index, card) in cards.enumerated() {
    let wins = card.wins.filter { card.nums.contains($0) }.count
    if (wins > 0) {
        for i in index+1...index+wins { ownedCards[i]! += 1 * ownedCards[index]! }
    }
}

result2 = ownedCards.values.reduce(0, +)

print("Part 2: \(result2)")

// MARK: test

struct Card : CustomStringConvertible {
    
    var ID: Int
    var nums: [Int] = []
    var wins: [Int] = []
    
    init(line: String) {
        
        let s1 = line.components(separatedBy: ": ")
        let s0 = s1[0].components(separatedBy: CharacterSet.whitespaces).filter { !$0.isEmpty }
        let s2 = s1[1].components(separatedBy: " | ")
    
        ID = Int(s0[1])!
        nums = s2[1].components(separatedBy: " ").compactMap{ Int($0) }
        wins = s2[0].components(separatedBy: " ").compactMap{ Int($0) }
        
    }
    
    var description: String {
        return "ID: \(ID), nums: \(nums.count), wins: \(wins.count)"
    }
}
