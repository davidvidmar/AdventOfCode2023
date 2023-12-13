import Foundation

let day = "11"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// parse

var points: [(Int, Int)] = []
for (l, line) in lines.enumerated()  {
    for (c, char) in line.enumerated() {
        if char == "#" { points.append((l, c)) }
    }
}
//print(points)

// expand COLUMNS
for c in (0..<points.count).reversed() {
    if points.allSatisfy({ $0.1 != c }) {
//        print("extending column \(c)")
        for (i, p) in points.enumerated() {
            if p.1 > c { points[i].1 = p.1 + 1 }
        }
//        print(points)
    }
}

// expand ROWS
for r in (0..<points.count).reversed() {
    if points.allSatisfy({ $0.0 != r } ) {
//        print("extending row \(r)")
        for (i, p) in points.enumerated() {
            if p.0 > r { points[i].0 = p.0 + 1 }
        }
//        print(points)
    }
}

// parse

//var map: [[Int]] = []
//var i = 0
//for line in lines {
//    map.append(line.map( { $0 == "." ? 0 : 1 }))
//}

//printMap(map: map)
//print()

// expand rows

//for i in (0..<map.count).reversed() {
//    if map[i].reduce(0, +) == 0 {
//        let emptyLine = Array(repeating: 0, count:map[i].count)
////        print("Row: \(i)")
//        map.insert(emptyLine, at: i)
//    }
//}

//printMap(map: map)
//print()

// expand columns

//for colIndex in (0..<map[0].count).reversed() {
//    var colSum = 0
//    for rowIndex in (0..<map.count) {
//        colSum += map[rowIndex][colIndex]
//    }
//    if (colSum == 0) {
////        print("Col: \(colIndex)")
//        for rowIndex in (0..<map.count) {
//            map[rowIndex].insert(0, at: colIndex)
//        }
//    }
//}

// number items

//var counter = 1
//for rowIndex in 0..<map.count {
//    for colIndex in 0..<map[0].count {
//        if (map[rowIndex][colIndex] != 0) {
//            map[rowIndex][colIndex] = counter
//            counter += 1
//        }
//    }
//}

//printMap(map: map)

// part 1

var result1 = 0

for (i, p) in points.enumerated() {
    for (j, r) in points.enumerated() {
        if i < j && p != r {
//            print("\(i): \(p) -> \(j): \(r) = \( abs(p.0 - r.0) + abs(p.1 - r.1) )")
            result1 += abs(p.0 - r.0) + abs(p.1 - r.1)
        }
    }
}

print("Part 1: \(result1)")

// part 2

var result2 = lines.count
//...

print("Part 2: \(result2)")

func printMap(map: [[Int]]) {
    for row in map {
        print(row)
    }
}
