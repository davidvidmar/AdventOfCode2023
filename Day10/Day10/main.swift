import Foundation

let day = "10"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

var grid: [[Character]] = lines.map { Array($0) }
//printGrid(arrayOfArrays: grid)

// part 1

let start = findChar(grid: grid, char: "S")
print("Start: ", start!)

var gridValues: [[Int?]] = Array(repeating: Array(repeating: nil, count: grid.count), count: grid[0].count)
gridValues[start!.0][start!.1] = 0

let result1 = GetNext(position: start!, step: 0, grid: grid, values: gridValues) / 2

//printGrid(arrayOfArrays: gridValues)

print("Part 1: \(result1)")

// part 2

var result2 = lines.count
//...

print("Part 2: \(result2)")

func GetNext(position: (Int, Int), step: Int, grid: [[Character]], values: [[Int?]]) -> Int {
    
    let connections = findConnection(grid: grid, location: position)
//    print("Connections: ", connections)
    var len = 0
    for c in connections {
        if (gridValues[c.0][c.1] == nil) {
            gridValues[c.0][c.1] = step + 1
            if (c != position) {
//                print("NNext: \(c) = \(findConnection(grid: grid, location: c))")
                len = GetNext(position: c, step: step + 1, grid: grid, values: values)
            }
        }
    }
    return len + 1
}

func printGrid<T>(arrayOfArrays: [[T]]) {
    for array in arrayOfArrays {
        print(array)
    }
}

func findChar(grid: [[Character]], char: Character) -> (Int, Int)? {
    if let rowIndex = grid.firstIndex(where: { $0.contains(char) }),
       let colIndex = grid[rowIndex].firstIndex(of: char) {
        return (rowIndex, colIndex)
    }
    return nil
}

func findConnection(grid: [[Character]], location: (Int, Int)) -> [(Int, Int)] {
    var connections: [(Int, Int)] = []
    let current = grid[location.0][location.1]
    if (location.0 > 0) {
        // top
        let y = location.0 - 1
        let x = location.1
        let p = "S|JL".contains(current) ? "|7F" : ""
        // check
        if p.contains(grid[y][x]) {
            connections.append((y, x))
        }
    }
    if (location.0 < grid.count - 1) {
        // bottom
        let y = location.0 + 1
        let x = location.1
        let p = "S|F7".contains(current) ? "|JL" : ""
        // check
        if p.contains(grid[y][x]) {
            connections.append((y, x))
        }
    }
    if (location.1 > 0) {
        // left
        let y = location.0
        let x = location.1 - 1
        let p = "S-J7".contains(current) ? "-FL" : ""
        // check
        if p.contains(grid[y][x]) {
            connections.append((y, x))
        }
    }
    if (location.1 < grid[location.0].count - 1) {
        // right
        let y = location.0
        let x = location.1 + 1
        let p = "S-FL".contains(current) ? "-J7" : ""
        // check
        if p.contains(grid[y][x]) {
            connections.append((y, x))
        }
    }
    return connections
}
