import Foundation

let day = "09"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

//var result1 = 0
//
//for line in lines {
//    let values = line.components(separatedBy: " ").map { Int($0)! }
//    let new = getDiffs(values: values, level: 0)
//    printValues(values: values, level: 0, new: new)
//    result1 += new
//}
//
//print("Part 1: \(result1)")

// part 2

var result2 = 0

for line in lines {
    let values = line.components(separatedBy: " ").map { Int($0)! }
    let new = getDiffsBack(values: values, level: 0)
    printValues(values: values, level: 0, new: new, back: true)
    print()
    result2 += new
}

print("Part 2: \(result2)")

func printValues(values: [Int], level: Int, new: Int, back: Bool = false) {
    if (back) {
        print(String(format: "%3d", new), terminator: "")
    }
    print(String(repeating: " ", count: level * 2), terminator: "")
    print(values.map { String(format: "%3d", $0) }.joined(separator: " "), terminator: "")
    if (!back) {
        print(String(format: "%3d", new), terminator: "")
    }
    print()
}

func getDiffs(values: [Int], level: Int) -> Int
{
    var diffs = [Int]()
    for i in 0..<values.count - 1 {
        diffs.append(values[i+1] - values[i])
    }
    
    var diff = 0
    if !diffs.allSatisfy({ $0 == 0 }) {
        diff = getDiffs(values: diffs, level: level + 1)
    }
//    printValues(values: diffs, level: level, new: diff)
    return values.last! + diff
}

func getDiffsBack(values: [Int], level: Int) -> Int
{
    var diffs = [Int]()
    for i in 0..<values.count - 1 {
        diffs.append(values[i+1] - values[i])
    }
    
    var diff = 0
    if !diffs.allSatisfy({ $0 == 0 }) {
        diff = getDiffsBack(values: diffs, level: level + 1)
    }
    printValues(values: diffs, level: level, new: diff, back: true)
    return values.first! - diff
}
