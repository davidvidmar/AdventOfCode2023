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

points.removeAll()
for (l, line) in lines.enumerated()  {
    for (c, char) in line.enumerated() {
        if char == "#" { points.append((l, c)) }
    }
}

// expand COLUMNS
for c in (0..<points.count).reversed() {
    if points.allSatisfy({ $0.1 != c }) {
        for (i, p) in points.enumerated() {
            if p.1 > c { points[i].1 = p.1 + 999999 }
        }
    }
}

// expand ROWS
for r in (0..<points.count).reversed() {
    if points.allSatisfy({ $0.0 != r } ) {
        for (i, p) in points.enumerated() {
            if p.0 > r { points[i].0 = p.0 + 999999 }
        }
    }
}

var result2 = 0
for (i, p) in points.enumerated() {
    for (j, r) in points.enumerated() {
        if i < j && p != r {
            result2 += abs(p.0 - r.0) + abs(p.1 - r.1)
        }
    }
}

print("Part 2: \(result2)")
