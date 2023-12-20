import Foundation

let day = "?"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input-sample.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// parse

// convert to [[Int]] grid
var grid: [[Int]] = []
for (i, line) in lines.enumerated() {
    grid.append(line.map { Int(String($0))! })
}

dijkstra(grid)

//print(grid)

// part 1

var result1 = 0
// ...

print("Part 1: \(result1)")


// part 2

var result2 = 0
//...

print("Part 2: \(result2)")

typealias IntTuple = (Int, Int)

func dijkstra(_ grid: [ [Int]], source: (Int, Int) = (0, 0)) {
    var dist: [Int] // output
}
