import Foundation

let day = "14"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

let tlines = transposeArray(lines)
var result1 = 0

for line in tlines {
    let parts = line.components(separatedBy: "#")
//    print(parts, " ", separator: "")
    var total = 0
    var weight = line.count
    for part in parts {
        let c = part.filter { $0 == "O" }.count
        for i in 0..<c {
            total += (weight - i)
        }
//        print(total)
        weight -= part.count + 1
    }
    result1 += total
}

print("Part 1: \(result1)")

// part 2

var result2 = 0
//...

print("Part 2: \(result2)")

func transposeArray(_ table: [String]) -> [String] {
       
    let rowCount = table.count
    let columnCount = table[0].count

    var t = Array(repeating: "", count: columnCount)

    for i in 0..<rowCount {
       let row = table[i]
       for j in 0..<columnCount {
           let char = row[row.index(row.startIndex, offsetBy: j)]
           t[j].append(char)
       }
    }
   
    return t
}
