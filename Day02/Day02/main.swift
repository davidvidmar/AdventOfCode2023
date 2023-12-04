import Foundation
 
let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"

// https://adventofcode.com/2023/day/2
let day = "02"
print("Hello, AoC 2023! This is Day \(day).")
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n")

// part 1

var games: [Game] = []

for line in lines {
    
    if (line == "") {
        break
    }
    
    var game = Game()
    
    let sid = line.components(separatedBy: ": ")
    game.ID = Int(sid[0].components(separatedBy: " ")[1])!
    
    let cubesList = sid[1].components(separatedBy: "; ")
    for cubes in cubesList {
        var rgb = RGB()
        let colors = cubes.components(separatedBy: ", ")
        for color in colors {
            let x = color.components(separatedBy: " ")
            switch x[1] {
            case "red": rgb.Red = Int(x[0])!
            case "blue": rgb.Blue = Int(x[0])!
            case "green": rgb.Green = Int(x[0])!
            default: fatalError("unknown color")
            }
        }
        game.cubes.append(rgb)
    }
    games.append(game)
}

var rgb = RGB(Red: 12, Green: 13, Blue: 14)
var result1 = 0

for game in games {
    
    // print("\(game.ID): ", terminator: "")
    
    var possible = true;
    for cube in game.cubes {
        
        if (rgb.Red < cube.Red || rgb.Green < cube.Green || rgb.Blue < cube.Blue) {
            possible = false
        }
        
        // let desc = game.cubes.map { $0.description }.joined(separator: ";")
        // print(desc)
    }
    if (possible) {
        result1 += game.ID
    }
}

print("Part 1: \(result1)")

// part 2

var result2 = 0

for game in games {
    
    // print("\(game.ID): ", terminator: "")
    
    var rgbMin = RGB(Red: 0, Green: 0, Blue: 0)
    
    for cube in game.cubes {
        
        if (rgbMin.Red < cube.Red) {
            rgbMin.Red = cube.Red
        }
        if (rgbMin.Green < cube.Green) {
            rgbMin.Green = cube.Green
        }
        if (rgbMin.Blue < cube.Blue) {
            rgbMin.Blue = cube.Blue
        }
        
        // let desc = game.cubes.map { $0.description }.joined(separator: ";")
        // print(desc)
        
    }
    
    let power = rgbMin.Red * rgbMin.Green * rgbMin.Blue
    result2 += power
    
}

print("Part 2: \(result2)")

// ...

struct Game {
    var ID: Int = 0
    var cubes: [RGB] = []
}

struct RGB {
    var Red: Int = 0
    var Green: Int = 0
    var Blue: Int = 0
    
    var description: String {
        return "\(Red),\(Blue),\(Green)"
    }
}
