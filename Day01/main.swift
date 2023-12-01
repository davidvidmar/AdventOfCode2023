import Foundation

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"

// https://adventofcode.com/

let day = "01"

print("Hello, AoC 2023! This is Day \(day).")

let content = try String(contentsOfFile:path + "/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n")

// part 1

var sum = 0;

for line in lines {
    if line == "" {
        break
    }
    let num = String(line.filter { "0123456789".contains($0) })
    //print(num)
    let a = num.first!
    let b = num.last!
    let x = Int(String(a)+String(b))
    //print(x!)
    sum = sum + x!
}

print("Part 1: " + String(sum))

// part 2

sum = 0;

for line in lines {
    if line == "" {
        break
    }
    // print(line)
    
    let numbers: [(String, Int)] =
        [("1", 1), ("2", 2), ("3", 3), ("4", 4), ("5", 5),
         ("6", 6), ("7", 7), ("8", 8), ("9", 9), ("0", 0),
         ("one", 1), ("two", 2), ("three", 3), ("four", 4), ("five", 5),
         ("six", 6), ("seven", 7), ("eight", 8), ("nine", 9), ("zero", 0)
    ]
   
    var firstIndex: Int = 99999;
    var firstNumber: Int = 0;
    for n in numbers {
        (firstIndex, firstNumber) = getFirstNumber(string: line, number: n.0, value: n.1, position: firstIndex, best: firstNumber)
    }
    
    var lastIndex: Int = -1;
    var lastNumber: Int = 0;
    for n in numbers {
        (lastIndex, lastNumber) = getLastNumber(string: line, number: n.0, value: n.1, position: lastIndex, best: lastNumber)
    }

    // print (firstNumber, " ", lastNumber)
    let x = Int(String(firstNumber)+String(lastNumber))
    
    //print(x!)
    sum = sum + x!
    //print(x!)
    //sum = sum + x!
}

print("Part 2: " + String(sum))

func getFirstNumber(string: String, number: String, value: Int, position: Int, best: Int) -> (Int, Int) {
    
    let i = string.firstIndex(of: number)
    
    var p = position;
    var v = best;
    
    if (i < position && i >= 0) {
        p = i
        v = value
    }
    
    return (p, v)
}

func getLastNumber(string: String, number: String, value: Int, position: Int, best: Int) -> (Int, Int) {
    
    let i = string.lastIndex(of: number)
    
    var p = position;
    var v = best;
    
    if (i > position && i >= 0) {
        p = i
        v = value
    }
    
    return (p, v)
}

extension String {
    func firstIndex(of substring: String) -> Int {
        if let range = self.range(of: substring) {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        }
        return -1
    }
}

extension String {
    func lastIndex(of substring: String) -> Int {
        if let range = self.range(of: substring, options: .backwards) {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        }
        return -1    }
}
