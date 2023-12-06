import Foundation
import Prism
 
// https://adventofcode.com/2023/day/5

let day = "05"
print("Hello, AoC 2023! This is Day \(day).")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input-sample.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n")

// parse input

var seeds = lines[0].components(separatedBy: ": ")[1].components(separatedBy: " ").map { Int($0)! }

var maps = [Map]()
var mapIndex = 0
maps.append(Map())

for i in 2..<lines.count {
    let line = lines[i]
    if (line.isEmpty) {
        mapIndex = mapIndex + 1;
    } else
    if line.first!.isLetter {
        maps.append(Map())
        maps[mapIndex].Name = line
    } else {
        maps[mapIndex].add(line: line)
    }
}

// part 1

var result1 = Int.max

//for seed in seeds {
//    var destination = seed;
////    print("\(seed) ->")
//    for map in maps {
//        destination = map.mapValue(value: destination)
//        //print("\(map.Name) -> \(destination)")
//    }
//    //let formatted = Prism(Bold("\(destination)"))
//    // print("   -> ", String(destination))
//    if result1 > destination {
//        result1 = destination
//    }
//}

print("Part 1: \(result1)")

// part 2

var result2 = Int.max

//for i in stride(from: 0, through: seeds.count-1, by: 2) {
//    for offset in 0..<seeds[i+1] {
//        var destination = seeds[i] + offset;
//        for map in maps {
//            destination = map.mapValue(value: destination)
//        }
//        if result2 > destination { result2 = destination }
//    }
//}
var seedsArray = [Seed]()
for i in stride(from: 0, to: seeds.count, by: 2) {
    seedsArray.append(Seed(number: seeds [i], length: seeds[i+1]))
}

var searching = 0
var found = false
while !found {
    
    var destination = searching
    
    for i in stride(from: maps.count-1, through: 0, by: -1) {
        destination = maps[i].inverseMapValue(value: destination)
    }
    
    if (seedsArray.contains(where: { $0.containtsSeed(value: destination) } )) {
        result2 = destination
        break
    }
    
    searching = searching + 1
    
}

print("Part 2: \(result2)")

class Map {
    var Name: String = "unkown"
    var Mappings: [Mapping] = [] // source, desc, length
    
    public func add(line: String) {
        let s = line.components(separatedBy: " ")
        Mappings.append(Mapping(source: Int(s[1])!, destination: Int(s[0])!, length: Int(s[2])!))
        Mappings.sort { $0.source < $1.source }
    }
    
    public func mapValue(value: Int) -> Int {
        if let index = Mappings.firstIndex(where: { $0.source <= value && $0.source + $0.length - 1 >= value }) {
            return value + Mappings[index].destination - Mappings[index].source
        } else {
            return value
        }
    }
    
    public func inverseMapValue(value: Int) -> Int {
        if let index = Mappings.firstIndex(where: { $0.ContaintsDestination(value: value) }) {
            return value + Mappings[index].source - Mappings[index].destination
        } else {
            return value
        }
    }
}

struct Seed {
    var number: Int
    var length : Int
    
    public func containtsSeed(value: Int) -> Bool {
        return number >= value && number <= value + length;
    }
}

struct Mapping {
    var source: Int
    var destination: Int
    var length: Int
    
//    public func ContaintsSource(value: Int) -> Bool {
//        return value >= source && value < value + length;
//    }
    
    public func ContaintsDestination(value: Int) -> Bool {
        return value >= destination && destination < value + length;
    }
}
