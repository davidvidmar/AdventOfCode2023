import Foundation

let day = "07"
print("AoC 2023, Day \(day)\n")

// MARK: load and parse

print("Parsing: ", terminator: "")
var startTime = DispatchTime.now()

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// ...

print("\(lines.count) lines ", terminator: "")
print("(\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)\n")

// MARK: part 1
print("Part 1: ", terminator: "")
startTime = DispatchTime.now()

var result1 = 0
// ...

print("\(result1) (\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)")

// MARK: part 2
print("Part 2: ", terminator: "")
startTime = DispatchTime.now()

var result2 = 0
//...

print("\(result2) (\(((DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000)) ms)\n")

// MARK:
