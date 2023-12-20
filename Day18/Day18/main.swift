import Foundation

let day = "18"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

let digs = lines.map { Dig($0) }

let dirs: [String: (Int, Int)] = [ "R": (1, 0), "D": (0, 1), "L": (-1, 0), "U": (0, -1) ]
var points: [(Int, Int)] =  [(0, 0)]

// part 1

// https://www.youtube.com/watch?v=bGWK76_e-LM

// površina poligona: shoelace formula
// A = 1/2 * Abs ( Sum i=1 to n (xi * (yi+1 - yi-1 )
// https://en.wikipedia.org/wiki/Shoelace_formula

var b = 0
for dig in digs {
    let l = points.last!
    let d = dirs[dig.Direction]!
    b += dig.Meters
    points.append((l.0 + d.0 * dig.Meters, l.1 + d.1 * dig.Meters))
}
//print(points)

// shoelace = površina notranjosti
var A = 0
for (i, _) in points.enumerated() {
    A += points[i].0 * (
        points[i-1 >= 0 ? i-1 : points.count - 1].1 - 
        points[i+1 < points.count ? i+1 : 0].1
    )
}
A = abs(A)/2

// pick's theorem
// https://en.wikipedia.org/wiki/Pick%27s_theorem
var i = A - b / 2 + 1

//print(A, b, i)

let result1 = i + b
//let result1 = grid.reduce(0) { $0 + $1.filter { $0 == "#" || $0 == "%" }.count }

print("Part 1: \(result1)")

// part 2

let digs2 = lines.map { Dig($0, hasBug: true) }

points = [(0,0)]
b = 0
for dig in digs2 {
    let l = points.last!
    let d = dirs[dig.Direction]!
    b += dig.Meters
    points.append((l.0 + d.0 * dig.Meters, l.1 + d.1 * dig.Meters))
}
//print(points)

// shoelace = površina notranjosti
A = 0
for (i, _) in points.enumerated() {
    A += points[i].0 * (
        points[i-1 >= 0 ? i-1 : points.count - 1].1 -
        points[i+1 < points.count ? i+1 : 0].1
    )
}
A = abs(A)/2

// pick's theorem
// https://en.wikipedia.org/wiki/Pick%27s_theorem
i = A - b / 2 + 1

//print(A, b, i)

var result2 = i + b

print("Part 2: \(result2)")

struct Dig: CustomStringConvertible {
    var Direction: String
    var Meters: Int
//    var Color: String
    
    init(_ string: String, hasBug: Bool = false) {
        let c = string.components(separatedBy: " ")
        if (!hasBug) {// part 1
            Direction = c[0]
            Meters = Int(c[1])!
        } else {
            switch Array(c[2])[7] {
            case "0":
                Direction = "R"
            case "1":
                Direction = "D"
            case "2":
                Direction = "L"
            case "3":
                Direction = "U"
            default:
                Direction = "?"
            }
            Meters = Int(String(Array(c[2])[2...6]), radix: 16)!
        }
    }
    
    var description: String {
        return "\(Direction) \(Meters)"
    }
    
}

func printGrid<T: CustomStringConvertible>(_ grid: [[T?]], empty: String = ".") {
    let lines = grid.map { $0.map { "\($0 != nil ? String(describing: $0!) : empty)" }.joined() }
    let output = lines.joined(separator: "\n")
    print(output)
}
