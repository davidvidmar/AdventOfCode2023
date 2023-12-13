import Foundation

let day = "13"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n")

// part 1

var result1 = 0

var table: [String] = []
for line in lines {
    if (!line.isEmpty) {
        table.append(line)
    } else {
        print(table)
        result1 += findReflection(table, multiplier: 100)
        table = transposeArray(table)
        print(table)
        result1 += findReflection(table, multiplier: 1)
        print(result1)
        table = []
    }
}

print("Part 1: \(result1)")

// part 2

var result2 = lines.count
//...

print("Part 2: \(result2)")

// ..

func findReflection(_ table: [String], multiplier: Int) -> Int {
    
    var result = 0
    
    for i in 0..<table.count - 1 {
        if table[i] == table[i+1] {
            // we have a split, check all lines
            print("possible mirror: \(i) and \(i+1) \(table[i])")
            var fix = true
            var a = i
            var b = i+1
            while fix && a >= 0 && b < table.count {
                if (table[a] == table[b]) {
                    print("\(a) = \(b)")
                    a -= 1
                    b += 1
                } else {
                    fix = false
                    print("  nope")
                }
            }
            if fix {
                result += (i+1) * multiplier
            }
        }
    }

    return result
}

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
