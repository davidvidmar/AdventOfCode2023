import Foundation

let day = "07"
print("Hello, AoC 2023! This is Day \(day).")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// parse input

// part 1

var result1 = 0

print("Part 1: \(result1)")

// part 2

var result2 = 0

print("Part 2: \(result2)")
