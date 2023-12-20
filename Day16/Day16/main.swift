import Foundation

let day = "16"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var dim = max(lines.count, lines[0].count)

let startTime = Date()

let result1 = run(lines: lines, start: Position(x: -1, y: 0), dir: "R")

print("Part 1: \(result1) \(Date().timeIntervalSince(startTime) * 1000) ms")

// part 2

var result2 = 0

for i in 0..<dim {
    let r = run(lines: lines, start: Position(x: -1, y: i), dir: "R")
    let l = run(lines: lines, start: Position(x: dim, y: i), dir: "L")
    let d = run(lines: lines, start: Position(x: i, y: -1), dir: "D")
    let u = run(lines: lines, start: Position(x: i, y: dim), dir: "U")
    result2 = max(result2, d, u, l, r)
}

print("Part 2: \(result2)")

// MARK - Utils

func run(lines: [String], start: Position, dir: String) -> Int {
    
    var table = Array(lines)
    var beams = [Beam]()
    
    var beam = Beam(pos: start, dir: dir)
    beams.append(beam)
    var energized: [Position:String] = [:]
    
    var step = 0
    
    while beams.count > 0 && step <= 50000 {
        
        //    print("step: ", step)
        
        for (i, beam) in beams.enumerated().reversed() {
            if let npos = beam.next() {
                
                let field = Array(table[npos.y])[npos.x]
                switch field {
                case "|":
                    if (beam.dir == "U" || beam.dir == "D") {
                        beams[i].pos = npos
                    } else if (beam.dir == "L" || beam.dir == "R") {
                        beams[i].pos = npos
                        beams[i].dir = "U"
                        var beam2 = beams[i]
                        beam2.dir = "D"
                        beams.append(beam2)
                    }
                    break
                case "-":
                    if (beam.dir == "L" || beam.dir == "R") {
                        beams[i].pos = npos
                    } else if (beam.dir == "U" || beam.dir == "D") {
                        beams[i].pos = npos
                        beams[i].dir = "L"
                        var beam2 = beams[i]
                        beam2.dir = "R"
                        beams.append(beam2)
                    }
                    break
                case "/":
                    switch beam.dir {
                    case "U":
                        beams[i].pos = npos
                        beams[i].dir = "R"
                        break
                    case "D":
                        beams[i].pos = npos
                        beams[i].dir = "L"
                        break
                    case "L":
                        beams[i].pos = npos
                        beams[i].dir = "D"
                        break
                    case "R":
                        beams[i].pos = npos
                        beams[i].dir = "U"
                        break
                    default:
                        assert(false)
                    }
                    
                    break
                case "\\":
                    switch beam.dir {
                    case "U":
                        beams[i].pos = npos
                        beams[i].dir = "L"
                        break
                    case "D":
                        beams[i].pos = npos
                        beams[i].dir = "R"
                        break
                    case "L":
                        beams[i].pos = npos
                        beams[i].dir = "U"
                        break
                    case "R":
                        beams[i].pos = npos
                        beams[i].dir = "D"
                        break
                    default:
                        assert(false)
                    }
                case ".":
                    beams[i].pos = npos
                    break
                default:
                    assert(false)
                }
                //            print("  \(i) \(beams[i])")
                
                if energized[beams[i].pos] == nil {
                    energized[beams[i].pos] = String(beams[i].dir)
                } else if !energized[beams[i].pos]!.contains(beams[i].dir) {
                    energized[beams[i].pos] = energized[beams[i].pos]!.appending(String(beams[i].dir))
                } else {
                    beams.remove(at: i)
                }
                
            } else {
                //            print("  \(i) Removing \(beams[i])")
                beams.remove(at: i)
                
            }
            
            step += 1
        }
    }
    
    //print(step)
    
    return energized.keys.count
}

struct Beam : CustomStringConvertible {
    
    var pos: Position //{
    var dir: String
    
    var description: String {
        return "\(pos.y),\(pos.x) \(dir)"
    }
    
    func next() -> Position? {
        var newPos = pos
        switch dir {
        case "U":
            newPos.y -= 1
            if newPos.y < 0 { return nil }
           break
        case "D":
            newPos.y += 1
            if newPos.y >= dim { return nil }
           break
        case "L":
            newPos.x -= 1
            if newPos.x < 0 { return nil }
           break
        case "R":
            newPos.x += 1
            if newPos.x >= dim { return nil }
           break
        default:
            assert(false)
        }
        return newPos
    }
}

struct Position: Hashable, CustomStringConvertible {
    
    var description: String {
        return "\(y),\(x)"
    }
    
    var x: Int
    var y: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
